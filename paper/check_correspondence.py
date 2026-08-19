"""Validate the publication correspondence matrix and its source declarations.

Run from the repository root. The check is executed in GitHub Actions and
fails when the appendix, the explicit claim matrix, or a referenced formal or
finite declaration drifts. Exact theorem-signature claims are compiled
separately by Goedel4PEL.PublicationCorrespondence.
"""

import json
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parents[1]
LEAN = ROOT / "formal" / "lean" / "Goedel4PEL"
FINITE = ROOT / "formal" / "finite"
APPENDIX = ROOT / "paper" / "sections" / "A_formal_correspondence.tex"
MANIFEST = ROOT / "paper" / "correspondence_manifest.json"
SIGNATURE_FILE = LEAN / "PublicationCorrespondence.lean"

DECL = re.compile(
    r"^(?:@\[[^\]]*\]\s*)?(?:theorem|def|structure|abbrev|instance)\s+([\w'.]+)",
    re.M,
)
FUNC = re.compile(r"^def\s+(\w+)", re.M)
TEXTTT = re.compile(r"texttt\{([^}]*)\}")
SUBSECTION = re.compile(r"\\subsection\{([^}]*)\}")
ITEM = re.compile(
    r"\\item\[(.*?)\]\s*([\s\S]*?)(?=\\item\[|\\end\{description\})"
)

SIGNATURE_GATE_DECLS = {
    "GoedelScott/T1.t1T_of_a1R_a2Plus",
    "GoedelScott/T2.t2Plus_of_regG",
    "GoedelScott/ScottFrames.t3Plus_of_possible_t2_a5_symmetric",
    "GoedelScott/FittingAdmissible.god_has_currentExtension_essence_admissible",
    "GoedelScott/FittingActualistQuotient.profileQuotientEntailPlus_iff_pullback",
    "GoedelScott/FittingQuotientDeltaFilter.profileQuotient_has_nondeciding_primeDeltaFilter",
    "FourValued/PairedNeighborhood.diamondPlus_iff_boxNeg_neg",
}


def source_declarations():
    lean = {}
    for path in LEAN.rglob("*.lean"):
        stem = path.relative_to(LEAN).with_suffix("").as_posix()
        names = set(DECL.findall(path.read_text(encoding="utf-8")))
        lean[stem] = names | {name.rsplit(".", 1)[-1] for name in names}

    finite = {
        path.stem: set(FUNC.findall(path.read_text(encoding="utf-8")))
        for path in FINITE.glob("*.py")
    }
    return lean, finite


def parse_appendix(text):
    sections = [
        (match.start(), re.sub(r"\s+", " ", match.group(1)).strip())
        for match in SUBSECTION.finditer(text)
    ]
    claims = []
    current_module = None

    for index, match in enumerate(ITEM.finditer(text), start=1):
        section = next(
            (
                title
                for start, title in reversed(sections)
                if start < match.start()
            ),
            "",
        )
        claim = re.sub(r"\s+", " ", match.group(1)).strip()
        references = []

        for raw in TEXTTT.findall(match.group(2)):
            entry = raw.replace("\\_", "_")
            if entry.startswith("."):
                name = entry[1:]
                if current_module is None or not name or name.startswith("_"):
                    continue
                module = current_module
            else:
                if (
                    "." not in entry
                    or entry.endswith("/")
                    or entry.endswith((".py", ".lean"))
                ):
                    continue
                module, name = entry.rsplit(".", 1)
                if not name or name.startswith("_"):
                    continue
                current_module = module

            references.append({"module": module, "declaration": name})

        claims.append(
            {
                "id": f"claim-{index:03d}",
                "section": section,
                "claim": claim,
                "references": references,
            }
        )

    return claims


def is_finite_module(module):
    return module == "checker" or module == "gate7_search" or module.startswith(
        ("gate8_", "gate10_", "gate11_")
    )


def reference_key(reference):
    return f"{reference['module']}.{reference['declaration']}"


problems = []
lean, finite = source_declarations()

if not MANIFEST.exists():
    problems.append("claim matrix is missing: paper/correspondence_manifest.json")
    manifest = {}
else:
    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))

appendix_claims = parse_appendix(APPENDIX.read_text(encoding="utf-8"))
manifest_claims = manifest.get("claims", [])

if manifest.get("schema_version") != 1:
    problems.append("claim matrix schema_version must be 1")
if manifest.get("source") != "paper/sections/A_formal_correspondence.tex":
    problems.append("claim matrix source does not name the correspondence appendix")
reference_count = sum(
    len(claim.get("references", [])) for claim in manifest_claims
)
signature_claim_count = sum(
    claim.get("signature_gate") is True for claim in manifest_claims
)

if len(appendix_claims) != len(manifest_claims):
    problems.append(
        f"claim count mismatch: appendix={len(appendix_claims)} "
        f"matrix={len(manifest_claims)}"
    )
if manifest.get("claim_count") != len(manifest_claims):
    problems.append("claim matrix claim_count is stale")
if manifest.get("reference_count") != reference_count:
    problems.append("claim matrix reference_count is stale")
if manifest.get("signature_gate_claims") != signature_claim_count:
    problems.append("claim matrix signature_gate_claims is stale")

for expected, actual in zip(appendix_claims, manifest_claims):
    if expected["id"] != actual.get("id"):
        problems.append(f"{expected['id']}: claim id drift")
    if expected["section"] != actual.get("section"):
        problems.append(f"{expected['id']}: section drift")
    if expected["claim"] != actual.get("claim"):
        problems.append(f"{expected['id']}: claim text drift")

    expected_refs = expected["references"]
    actual_refs = [
        {
            "module": ref.get("module"),
            "declaration": ref.get("declaration"),
        }
        for ref in actual.get("references", [])
    ]
    if expected_refs != actual_refs:
        problems.append(f"{expected['id']}: reference list drift")

    bounded = any(is_finite_module(ref["module"]) for ref in expected_refs)
    expected_evidence = "bounded-finite" if bounded else "machine-checked-general"
    expected_scope = "bounded" if bounded else "general"
    if actual.get("evidence") != expected_evidence:
        problems.append(f"{expected['id']}: evidence type is incorrect")
    if actual.get("scope") != expected_scope:
        problems.append(f"{expected['id']}: scope is incorrect")
    if not isinstance(actual.get("signature_gate"), bool):
        problems.append(f"{expected['id']}: signature_gate must be boolean")

    if actual.get("signature_gate"):
        gated = {
            reference_key(ref)
            for ref in actual.get("references", [])
            if isinstance(ref, dict)
        }
        if not gated.intersection(SIGNATURE_GATE_DECLS):
            problems.append(f"{expected['id']}: signature gate has no declared target")

manifest_gated = {
    reference_key(ref)
    for claim in manifest_claims
    if claim.get("signature_gate")
    for ref in claim.get("references", [])
}
for required in sorted(SIGNATURE_GATE_DECLS - manifest_gated):
    problems.append(f"signature-gate declaration missing from claim matrix: {required}")

if not SIGNATURE_FILE.exists():
    problems.append("signature-gate source is missing")
else:
    signature_text = SIGNATURE_FILE.read_text(encoding="utf-8")
    for required in SIGNATURE_GATE_DECLS:
        name = required.rsplit(".", 1)[-1]
        if name not in signature_text:
            problems.append(f"signature-gate source does not mention {required}")

checked = 0
for claim in manifest_claims:
    for reference in claim.get("references", []):
        module = reference.get("module")
        name = reference.get("declaration")
        kind = reference.get("kind")
        pool = finite.get(module) if is_finite_module(module) else lean.get(module)

        if pool is None:
            problems.append(f"{claim.get('id')}: module not found: {module}")
            continue

        expected_kind = "finite" if is_finite_module(module) else "lean"
        if kind != expected_kind:
            problems.append(
                f"{claim.get('id')}: {module}.{name} has kind {kind!r}, "
                f"expected {expected_kind!r}"
            )

        checked += 1
        if name not in pool:
            problems.append(
                f"{claim.get('id')}: declaration not found: {module}.{name}"
            )

print("claims in appendix:", len(appendix_claims))
print("references in claim matrix:", reference_count)
print("declarations checked:", checked)
print("general claims:", sum(
    claim.get("evidence") == "machine-checked-general" for claim in manifest_claims
))
print("bounded claims:", sum(
    claim.get("evidence") == "bounded-finite" for claim in manifest_claims
))
print("signature-gated claims:", sum(
    claim.get("signature_gate") is True for claim in manifest_claims
))
print("problems:", len(problems))

for problem in problems:
    print("  ", problem)

if problems:
    raise SystemExit(1)

"""Verify that every identifier named in the correspondence appendix exists.

Run from the repository root. Not part of the build; delete after use.
"""

import re
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
LEAN = ROOT / "formal" / "lean" / "Goedel4PEL"
FINITE = ROOT / "formal" / "finite"

DECL = re.compile(
    r"^(?:@\[[^\]]*\]\s*)?(?:theorem|def|structure|abbrev|instance)\s+([\w'.]+)", re.M
)
FUNC = re.compile(r"^def\s+(\w+)", re.M)
TEXTTT = re.compile(r"texttt\{([^}]*)\}")

lean = {}
for path in LEAN.rglob("*.lean"):
    stem = path.relative_to(LEAN).with_suffix("").as_posix()
    names = set(DECL.findall(path.read_text(encoding="utf-8")))
    lean[stem] = names | {n.rsplit(".", 1)[-1] for n in names}

finite = {
    path.stem: set(FUNC.findall(path.read_text(encoding="utf-8")))
    for path in FINITE.glob("*.py")
}

tex = (ROOT / "paper" / "sections" / "A_formal_correspondence.tex").read_text(
    encoding="utf-8"
)

current = None
checked = 0
problems = []

for raw in TEXTTT.findall(tex):
    entry = raw.replace("\\_", "_")

    if entry.startswith("."):
        name = entry[1:]
        if current is None or not name or name.startswith("_"):
            continue
        module = current
    else:
        if "." not in entry or entry.endswith("/"):
            continue  # prose token such as `sorry` or a bare directory
        if entry.endswith((".py", ".lean")):
            continue  # prose mention of a file, not of a declaration
        module, name = entry.rsplit(".", 1)
        if not name or name.startswith("_"):
            continue
        current = module

    pool = lean.get(module)
    if pool is None:
        pool = finite.get(module)
    if pool is None:
        problems.append((module, name, "module not found"))
        continue

    checked += 1
    if name not in pool:
        problems.append((module, name, "declaration not found"))

print("identifiers checked:", checked)
print("problems:", len(problems))
for module, name, why in problems:
    print("   %-55s %-45s %s" % (module, name, why))

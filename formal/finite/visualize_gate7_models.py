"""Render selected Gate-7 Scott-T2 countermodels as Kripke graphs.

The script consumes the same generated matrix family as ``gate7_search.py``.
It writes Graphviz ``.dot`` sources and rendered ``.png`` files to
``formal/finite/renders/`` by default.

Dependencies::

    python -m pip install -r formal/finite/requirements-visualization.txt

The Graphviz system executable ``dot`` must also be installed.
"""

from __future__ import annotations

import argparse
import os
import shutil
from pathlib import Path
from typing import Iterable, Iterator

try:
    from graphviz import Digraph
    from graphviz.backend import ExecutableNotFound
except ImportError as error:  # pragma: no cover - exercised only without dependency
    raise SystemExit(
        "Missing Python dependency 'graphviz'. Install it with "
        "'python -m pip install -r "
        "formal/finite/requirements-visualization.txt'."
    ) from error

from checker import FiniteModel, Val
from gate7_search import (
    T2_RECOVERY_ASSUMPTIONS,
    is_t2_minimality_baseline,
    iter_t2_minimality_models,
    iter_t2_regular_models,
    t2_recovery_assumption_values,
)


SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_RENDER_DIR = SCRIPT_DIR / "renders"

VALUE_COLORS = {
    Val.T: "#d9ead3",
    Val.F: "#f4cccc",
    Val.B: "#fff2cc",
    Val.N: "#e7e6e6",
}


def filter_single_premise_countermodels(
    models: Iterable[FiniteModel], dropped: str
) -> Iterator[FiniteModel]:
    """Yield exact T2 countermodels obtained by dropping only ``dropped``.

    The fixed complement/Godlikeness interfaces and the other three recovery
    assumptions must hold. The selected assumption and ``T2+`` itself must
    fail.
    """

    if dropped not in T2_RECOVERY_ASSUMPTIONS:
        choices = ", ".join(T2_RECOVERY_ASSUMPTIONS)
        raise ValueError(f"Unknown premise {dropped!r}; choose one of {choices}")

    for model in models:
        if not is_t2_minimality_baseline(model):
            continue

        assumptions = t2_recovery_assumption_values(model)
        if assumptions[dropped]:
            continue
        if not all(
            assumptions[name]
            for name in T2_RECOVERY_ASSUMPTIONS
            if name != dropped
        ):
            continue
        if model.t2_plus():
            continue
        yield model


def _fde_rows(model: FiniteModel, world: str) -> list[tuple[str, str, Val]]:
    entity = model.entities[0]
    extension_rows = [
        (entity, f"{prop}({entity})", model.val(world, entity, prop))
        for prop in model.properties
    ]
    positivity_rows = [
        ("property", f"P({prop})", model.pval(world, prop))
        for prop in model.properties
    ]
    return extension_rows + positivity_rows


def _world_label(model: FiniteModel, world: str) -> str:
    index = world.removeprefix("w")
    rows = [
        "<TR><TD COLSPAN='5' BGCOLOR='#cfe2f3'>"
        f"<B>w<SUB>{index}</SUB></B></TD></TR>",
        "<TR><TD><B>Object</B></TD><TD><B>Expression</B></TD>"
        "<TD><B>FDE</B></TD><TD><B>+</B></TD><TD><B>-</B></TD></TR>",
    ]
    for carrier, expression, value in _fde_rows(model, world):
        rows.append(
            "<TR>"
            f"<TD>{carrier}</TD>"
            f"<TD ALIGN='LEFT'>{expression}</TD>"
            f"<TD BGCOLOR='{VALUE_COLORS[value]}'><B>{value.name}</B></TD>"
            f"<TD>{int(value.pos)}</TD>"
            f"<TD>{int(value.neg)}</TD>"
            "</TR>"
        )
    table_open = (
        "<<TABLE BORDER='1' CELLBORDER='1' CELLSPACING='0' CELLPADDING='4'>"
    )
    return table_open + "".join(rows) + "</TABLE>>"


def build_kripke_graph(model: FiniteModel, dropped: str) -> Digraph:
    """Build a two-world Graphviz graph for one filtered countermodel."""

    if model.worlds != ("w0", "w1") or model.entities != ("a",):
        raise ValueError("Gate-7 rendering expects exactly worlds w0,w1 and entity a")

    graph = Digraph(
        name=f"gate7_drop_{_slug(dropped)}",
        comment=f"Gate 7 T2+ countermodel after dropping {dropped}",
    )
    graph.attr(
        rankdir="LR",
        bgcolor="white",
        label=f"Gate 7: drop {dropped}; T2+ fails",
        labelloc="t",
        fontsize="18",
        fontname="Helvetica",
        nodesep="0.8",
        ranksep="1.0",
        dpi="180",
    )
    graph.attr("node", shape="plain", fontname="Helvetica")
    graph.attr("edge", color="#333333", fontname="Helvetica", arrowsize="0.8")

    for world in model.worlds:
        graph.node(world, label=_world_label(model, world))
    for source, target in sorted(model.access):
        graph.edge(source, target, label="R")
    return graph


def _slug(premise: str) -> str:
    return (
        premise.lower()
        .replace("+", "plus")
        .replace("^", "")
        .replace("-", "_")
    )


def _ensure_dot_available() -> None:
    if shutil.which("dot"):
        return

    # Winget installs Graphviz here by default. A fresh process may not yet
    # have inherited the updated machine PATH, so make that case deterministic.
    windows_bins = [
        Path(os.environ.get("ProgramFiles", "C:/Program Files"))
        / "Graphviz"
        / "bin"
    ]
    portable_root = (
        Path(os.environ.get("LOCALAPPDATA", ""))
        / "Programs"
        / "GraphvizPortable"
    )
    if portable_root.is_dir():
        windows_bins.extend(
            dot.parent for dot in sorted(portable_root.rglob("dot.exe"), reverse=True)
        )
    for windows_bin in windows_bins:
        if (windows_bin / "dot.exe").is_file():
            os.environ["PATH"] = (
                f"{windows_bin}{os.pathsep}{os.environ.get('PATH', '')}"
            )
            return
    raise SystemExit(
        "Graphviz executable 'dot' was not found. Install Graphviz and ensure "
        "its bin directory is on PATH."
    )


def export_model(
    model: FiniteModel, dropped: str, output_dir: Path = DEFAULT_RENDER_DIR
) -> tuple[Path, Path]:
    """Write one model to stable ``.dot`` and ``.png`` paths."""

    _ensure_dot_available()
    output_dir.mkdir(parents=True, exist_ok=True)
    stem = f"gate7_drop_{_slug(dropped)}_first"
    dot_path = output_dir / f"{stem}.dot"
    png_path = output_dir / f"{stem}.png"
    graph = build_kripke_graph(model, dropped)
    graph.save(filename=dot_path.name, directory=str(output_dir))
    try:
        rendered = Path(
            graph.render(
                filename=stem,
                directory=str(output_dir),
                format="png",
                cleanup=True,
            )
        )
    except ExecutableNotFound as error:
        raise SystemExit(
            "The Python graphviz package is installed, but executable 'dot' "
            "could not be run."
        ) from error
    if rendered != png_path or not png_path.is_file():
        raise RuntimeError(f"Graphviz did not create expected output {png_path}")
    return dot_path, png_path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--premise",
        choices=T2_RECOVERY_ASSUMPTIONS,
        default="A1-L",
        help="render the first T2+ countermodel for this dropped premise",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=DEFAULT_RENDER_DIR,
        help="directory for generated .dot and .png files",
    )
    args = parser.parse_args()

    regular_count = sum(1 for _ in iter_t2_regular_models())
    if regular_count != 873:
        raise RuntimeError(
            f"Gate-7 oracle drift: expected 873 regular models, got {regular_count}"
        )

    countermodel = next(
        filter_single_premise_countermodels(
            iter_t2_minimality_models(), args.premise
        ),
        None,
    )
    if countermodel is None:
        raise RuntimeError(f"No exact countermodel found after dropping {args.premise}")

    dot_path, png_path = export_model(countermodel, args.premise, args.output_dir)
    print(f"Gate-7 regular models verified: {regular_count}")
    print(f"Dropped premise: {args.premise}")
    print(f"DOT: {dot_path}")
    print(f"PNG: {png_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

#!/usr/bin/env python3
"""Print alternating times-table questions and answers for a notifier."""

from __future__ import annotations

import argparse
import json
import os
import random
import sys
from pathlib import Path
from typing import Iterable, Sequence


DEFAULT_SELECTOR = "2-12"
CACHE_DIR_NAME = "notifier-times-tables"
STATE_FILE_NAME = "state.json"


class SelectorError(ValueError):
    """Raised when a table selector cannot be parsed."""


def parse_table_selector(selector: str) -> list[int]:
    tables: set[int] = set()

    for raw_part in selector.split(","):
        part = raw_part.strip()
        if not part:
            raise SelectorError("table selector contains an empty item")

        if "-" in part:
            start, end = parse_range_part(part)
            tables.update(range(start, end + 1))
        else:
            tables.add(parse_table_number(part))

    return sorted(tables)


def parse_range_part(part: str) -> tuple[int, int]:
    pieces = [piece.strip() for piece in part.split("-")]
    if len(pieces) != 2 or not pieces[0] or not pieces[1]:
        raise SelectorError(f"invalid range: {part!r}")

    start = parse_table_number(pieces[0])
    end = parse_table_number(pieces[1])
    if start > end:
        raise SelectorError(f"range start is greater than range end: {part!r}")
    return start, end


def parse_table_number(value: str) -> int:
    try:
        table = int(value)
    except ValueError as exc:
        raise SelectorError(f"invalid table number: {value!r}") from exc

    if table < 2:
        raise SelectorError(f"table number must be at least 2: {value!r}")
    return table


def cache_state_path() -> Path:
    cache_home = os.environ.get("XDG_CACHE_HOME")
    if cache_home:
        base = Path(cache_home).expanduser()
    else:
        base = Path.home() / ".cache"
    return base / CACHE_DIR_NAME / STATE_FILE_NAME


def generate_problem(tables: Sequence[int], rng: random.Random) -> dict[str, int]:
    table = rng.choice(tables)
    factor = rng.randint(2, table)

    if rng.choice((True, False)):
        left, right = factor, table
    else:
        left, right = table, factor

    return {"left": left, "right": right}


def format_question(problem: dict[str, int]) -> str:
    return f"{problem['left']} * {problem['right']} = ?"


def format_answer(problem: dict[str, int]) -> str:
    left = problem["left"]
    right = problem["right"]
    return f"{left} * {right} = {left * right}"


def load_problem(state_path: Path) -> dict[str, int] | None:
    try:
        raw = json.loads(state_path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        return None
    except (OSError, json.JSONDecodeError):
        return None

    if not isinstance(raw, dict):
        return None

    left = raw.get("left")
    right = raw.get("right")
    if not isinstance(left, int) or not isinstance(right, int):
        return None
    if left < 2 or right < 2:
        return None

    return {"left": left, "right": right}


def save_problem(problem: dict[str, int], state_path: Path) -> None:
    state_path.parent.mkdir(parents=True, exist_ok=True)
    tmp_path = state_path.with_name(f"{state_path.name}.{os.getpid()}.tmp")
    tmp_path.write_text(json.dumps(problem, sort_keys=True) + "\n", encoding="utf-8")
    tmp_path.replace(state_path)


def clear_problem(state_path: Path) -> None:
    try:
        state_path.unlink()
    except FileNotFoundError:
        pass


def run(
    selector: str,
    *,
    rng: random.Random | None = None,
    state_path: Path | None = None,
) -> str:
    tables = parse_table_selector(selector)
    rng = rng or random.SystemRandom()
    state_path = state_path or cache_state_path()

    previous_problem = load_problem(state_path)
    if previous_problem is not None:
        clear_problem(state_path)
        return format_answer(previous_problem)

    problem = generate_problem(tables, rng)
    save_problem(problem, state_path)
    return format_question(problem)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Alternate between times-table questions and answers."
    )
    parser.add_argument(
        "selector",
        nargs="?",
        default=DEFAULT_SELECTOR,
        help=(
            "table selector: a number, range, or comma-separated mix "
            f"(default: {DEFAULT_SELECTOR})"
        ),
    )
    return parser


def main(argv: Iterable[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    try:
        print(run(args.selector))
    except SelectorError as exc:
        print(f"times-tables.py: {exc}", file=sys.stderr)
        return 2
    except OSError as exc:
        print(f"times-tables.py: {exc}", file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

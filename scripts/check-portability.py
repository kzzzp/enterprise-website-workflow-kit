#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]

FORBIDDEN = [
    re.compile(r"C:[/\\]Users[/\\]Administrator", re.I),
    re.compile(r"2026-06-14"),
    re.compile(r"Documents[/\\]Codex", re.I),
    re.compile(r"ai-ai-html", re.I),
]

SKIP_PARTS = {".git", "__pycache__"}
TEXT_SUFFIXES = {".md", ".txt", ".ps1", ".sh", ".py", ".yaml", ".yml", ".json"}


def main() -> int:
    hits: list[str] = []
    self_path = Path(__file__).resolve()
    for path in ROOT.rglob("*"):
        if not path.is_file():
            continue
        if path.resolve() == self_path:
            continue
        if any(part in SKIP_PARTS for part in path.parts):
            continue
        if path.suffix.lower() not in TEXT_SUFFIXES:
            continue
        text = path.read_text(encoding="utf-8", errors="ignore")
        for line_no, line in enumerate(text.splitlines(), 1):
            if any(pattern.search(line) for pattern in FORBIDDEN):
                rel = path.relative_to(ROOT)
                hits.append(f"{rel}:{line_no}: {line}")

    if hits:
        print("Portability check failed. Remove local machine paths:")
        for hit in hits:
            print(hit)
        return 1

    print("Portability check passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

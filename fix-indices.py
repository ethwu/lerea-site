#! /usr/bin/env python3

from pathlib import Path
import sys

# Rename any markdown file with the same name as its parent directory to
# `index.md`.

def cmpfold(s: str) -> str:
    """
    Fold a string into a comparable string ignoring capitalization and all
    non-alphanumeric characters.
    """
    return ''.join(filter(str.isidentifier, s)).casefold()

if __name__ == '__main__':
    if len(sys.argv) < 2:
        sys.exit(64)
    # Intermediate file directory.
    intermediate = Path(sys.argv[1])
    for file in intermediate.glob('**/*.md'):
        new_path = file.parent / 'index.md'
        if cmpfold(file.stem) == cmpfold(file.parent.name) and not new_path.exists():
            # Found a file that needs to be turned into an index.
            print(file, '->', new_path)
            file.rename(new_path)

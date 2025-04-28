#!/usr/bin/env python3

import sys
import argparse

def main():
    parser = argparse.ArgumentParser(
        description="A simple grep-like tool (case-insensitive)"
    )
    
    parser.add_argument(
        "-n", "--line-number",
        action="store_true",
        help="Show line numbers with output"
    )
    parser.add_argument(
        "-v", "--invert-match",
        action="store_true",
        help="Invert the match (show non-matching lines)"
    )
    parser.add_argument(
        "search_string",
        help="String to search for"
    )
    parser.add_argument(
        "filename",
        help="File to search in"
    )

    args = parser.parse_args()

    try:
        with open(args.filename, 'r') as file:
            for lineno, line in enumerate(file, start=1):
                match = args.search_string.lower() in line.lower()

                if args.invert_match:
                    match = not match

                if match:
                    output = ''
                    if args.line_number:
                        output += f"{lineno}:"
                    output += line.rstrip()
                    print(output)

    except FileNotFoundError:
        print(f"Error: File '{args.filename}' not found.")
        sys.exit(1)

if __name__ == "__main__":
    main()

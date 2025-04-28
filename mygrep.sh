#!/bin/bash

# Show usage/help message
usage() {
    echo "Usage: $0 [-n] [-v] search_string filename"
    echo
    echo "Options:"
    echo "  -n    Show line numbers"
    echo "  -v    Invert match (show non-matching lines)"
    echo "  --help   Show this help message"
    exit 1
}

# Check for no arguments
if [[ $# -lt 1 ]]; then
    usage
fi

# Initialize options
show_line_numbers=false
invert_match=false

# Parse options
while [[ "$1" == -* ]]; do
    case "$1" in
        -n)
            show_line_numbers=true
            ;;
        -v)
            invert_match=true
            ;;
        --help)
            usage
            ;;
        -*)
            # Split combined options like -vn, -nv
            optstring="${1:1}"
            for ((i=0; i<${#optstring}; i++)); do
                opt="${optstring:$i:1}"
                case "$opt" in
                    n) show_line_numbers=true ;;
                    v) invert_match=true ;;
                    *) usage ;;
                esac
            done
            ;;
        *)
            usage
            ;;
    esac
    shift
done

# Now, after options, we must have exactly 2 arguments: search_string and filename
if [[ $# -ne 2 ]]; then
    usage
fi

search_string="$1"
filename="$2"

# Check if file exists
if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Build grep options
grep_options="-i"  # always case-insensitive
if $invert_match; then
    grep_options="$grep_options -v"
fi
if $show_line_numbers; then
    grep_options="$grep_options -n"
fi

# Execute grep
grep $grep_options -- "$search_string" "$filename"

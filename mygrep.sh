#!/bin/bash

# i decided to use the original grep by passing args to it
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

# Check for no arguments then show usage
if [[ $# -lt 1 ]]; then
    usage
fi

# Initialize options to false
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
        #adding the combined options like -vn
        -[nv])
            # Check for combined options like -nv or -vn
            if [[ "$1" == "-n" ]]; then
                show_line_numbers=true
            elif [[ "$1" == "-v" ]]; then
                invert_match=true
            fi
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

# Check if file exists to avoid grep errors

if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Build grep options based on user input
grep_options="-i"  # always case-insensitive
if $invert_match; then
    grep_options="$grep_options -v"
fi
if $show_line_numbers; then
    grep_options="$grep_options -n"
fi

# Execute grep
grep $grep_options -- "$search_string" "$filename"


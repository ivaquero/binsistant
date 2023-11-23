#!/bin/bash /bin/zsh
##########################################################

# query column
# $1: filename; $2: column index
csv_col() {
    if [[ ${#2} -gt 3 ]]; then
        idx=$(echo "$2" | grep --extended-regexp --only-matching '\d(\d+)?')
        cut -d ',' -f "$idx" <"$1"
    else
        cut -d ',' -f "$2" <"$1"
    fi
}

# query row
# $1: filename; $2: rowidx; $3 colname; $4: rowidx of results
csv_row() {
    if [[ $2 == *p ]]; then
        res=$(sed -n "$2" "$1" | sed 's/,,/,0,/g' | sed 's/,,/,0,/g')
    elif [[ $2 != -* ]]; then
        res=$(head -n "$2" "$1" | sed 's/,,/,0,/g' | sed 's/,,/,0,/g')
    else
        res=$(tail -n "${2/#-/}" "$1" | sed 's/,,/,0,/g' | sed 's/,,/,0,/g')
    fi

    if [[ -z "$3" ]]; then
        echo "$res"
    else
        echo "$res" | cut -d ',' -f "$3"
    fi
}

#!/bin/bash

execute() {
    if [[ -n $VERBOSE ]]; then
        echo
        echo_verbose "executing: $1 $2 $3 $4 $5 $6 $7 $8 $9"
        echo_verbose "----->"
        set_color $COLOR_GRAY
        $1 $2 $3 $4 $5 $6 $7 $8 $9
        reset_color
        echo_verbose "<----"
        echo
    else
        $1 $2 $3 $4 $5 $6 $7 $8 $9 >/dev/null
    fi
}
export -f execute

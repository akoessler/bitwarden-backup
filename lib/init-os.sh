#!/bin/bash

get_os()
{
    echo_verbose "OSTYPE: $OSTYPE"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        IS_LINUX=true
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        IS_MAXOS=true
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        IS_WINDOWS=true
    elif [[ "$OSTYPE" == "msys" ]]; then
        # e.g. git bash
        IS_WINDOWS=true
    fi

    if [[ -n $IS_LINUX ]]; then
        echo_verbose "Running on Linux"
    fi
    if [[ $IS_WINDOWS ]]; then
        echo_verbose "Running on Windows"
    fi
    if [[ $IS_MAXOS ]]; then
        echo_verbose "Running on MacOS"
    fi
}

get_os

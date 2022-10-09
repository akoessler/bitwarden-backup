#!/bin/bash

export COLOR_NOCOLOR='\033[0m'
export COLOR_BLACK='\033[0;30m'
export COLOR_GRAY='\033[1;30m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_LIGHT_GRAY='\033[0;37m'
export COLOR_WHITE='\033[1;37m'

echo_color() {
    printf "${1}${2}${COLOR_NOCOLOR}\n"
}
echo_info() {
    echo_color $COLOR_WHITE "$1"
}
echo_success() {
    echo_color $COLOR_GREEN "$1"
}
echo_error() {
    echo_color $COLOR_RED "$1"
}
echo_header() {
    echo_color $COLOR_LIGHT_PURPLE "$1"
}
echo_verbose() {
    if [[ -n $VERBOSE ]]; then
        echo_color $COLOR_GRAY "$1"
    fi
}
set_color() {
    printf "$1"
}
reset_color() {
    printf "$COLOR_NOCOLOR"
}

export -f echo_color
export -f echo_info
export -f echo_success
export -f echo_error
export -f echo_header
export -f echo_verbose
export -f set_color
export -f reset_color

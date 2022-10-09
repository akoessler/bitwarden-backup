#!/bin/bash

abort_error() {
    echo
    echo_error "$1"
    exit 1
}

abort_show_usage() {
    EXITCODE=0
    if [[ -n $1 ]]; then
        echo
        echo_error "$1"
        EXITCODE=1
    fi
    echo
    echo "Usage: backup.sh [OPTIONS]"
    echo
    echo "Options:"
    echo "  [--input_folder <folder>]               Folder where input files are searched for (see file parameters)  [default: ./input]"
    echo "  [--temp_folder <folder>]                Temp folder to use for temporary files, e.g. bw cli executable  [default: ./temp]"
    echo "  [--backup_file <filename>]              Filename of the json backup file, created in temp_folder  [default: export.json]"
    echo
    echo "  [--server_url <url>]                    URL of the server to create the backup from  [default: https://bitwarden.com]"
    echo "  [--sclientid_file <filename>]           File that contains the client id of the api key  [default: clientid]"
    echo "  [--sclientsecret_file <filename>}       File that contains the client secret of the api key  [default: clientsecret]"
    echo "  [--smasterpassword_file <filename>}     File that contains the master password of the vault  [default: masterpassword]"
    echo
    echo "  [--download_bw_mode <mode>]             Set download mode for bw cli executable. Options: always, ifnotexist  [default: ifnotexist]"
    echo "  [--verbose]                             Turn on verbose output"
    echo
    echo "  [--help, -h]                            Display this help text"
    echo
    echo "Notes:"
    echo "  * The export is done with an unencrypted json export!"
    echo "  * Secure the secret/password files as well as the export file from unwanted access!"
    echo
    exit $EXITCODE
}


# parse arguments

while [ $# -gt 0 ]; do
    if [[ $1 == "--help" || $1 == "-h" ]]; then
        abort_show_usage
    fi
    if [[ $1 == "--"* ]]; then
        arg_name="${1/--/}"
        arg_name=${arg_name^^}
        if [[ $2 == "--"* || $# -eq 1 ]]; then
            arg_value=true
        else
            arg_value=$2
            shift
        fi

        declare -g -x "$arg_name"="$arg_value"
    fi
    shift
done


# set defaults for optional arguments

if [[ -z $TEMP_FOLDER ]]; then
    TEMP_FOLDER="./temp"
    if [[ ! -d $TEMP_FOLDER ]]; then
        echo_verbose "create temp folder"
        mkdir $TEMP_FOLDER
    fi
fi

if [[ -z $INPUT_FOLDER ]]; then
    INPUT_FOLDER="./input"
    if [[ ! -d $INPUT_FOLDER ]]; then
        echo_verbose "create input folder"
        mkdir $INPUT_FOLDER
    fi
fi

if [[ -z $BACKUP_FILE ]]; then
    BACKUP_FILE="export.json"
fi


if [[ -z $DOWNLOAD_BW_MODE ]]; then
    DOWNLOAD_BW_MODE="ifnotexist"
fi
list_of_download_bw_modes="always,ifnotexist"
if [[ "$list_of_download_bw_modes" =~ (,|^)$DOWNLOAD_BW_MODE(,|$) ]]; then
    echo_verbose "Using download mode: $DOWNLOAD_BW_MODE"
else
    abort_show_usage "Invalid download_bw_mode: $DOWNLOAD_BW_MODE"
fi


# defaults for source

if [[ -z $SERVER_URL ]]; then
    SERVER_URL="https://bitwarden.com"
fi

if [[ -z $CLIENTID_FILE ]]; then
    CLIENTID_FILE="clientid"
fi
CLIENTID_PATH="$INPUT_FOLDER/$CLIENTID_FILE"
if [[ ! -f $CLIENTID_PATH ]]; then
    abort_show_usage "Missing file: $CLIENTID_PATH"
fi

if [[ -z $CLIENTSECRET_FILE ]]; then
    CLIENTSECRET_FILE="clientsecret"
fi
CLIENTSECRET_PATH="$INPUT_FOLDER/$CLIENTSECRET_FILE"
if [[ ! -f $CLIENTSECRET_PATH ]]; then
    abort_show_usage "Missing file: $CLIENTSECRET_PATH"
fi

if [[ -z $MASTERPASSWORD_FILE ]]; then
    MASTERPASSWORD_FILE="masterpassword"
fi
MASTERPASSWORD_PATH="$INPUT_FOLDER/$MASTERPASSWORD_FILE"
if [[ ! -f $MASTERPASSWORD_PATH ]]; then
    abort_show_usage "Missing file: $MASTERPASSWORD_PATH"
fi

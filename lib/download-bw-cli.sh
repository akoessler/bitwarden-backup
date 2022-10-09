#!/bin/bash

echo
echo
echo_header "download bitwarden cli binary"
echo

DOWNLOAD_LINK_BASE="https://vault.bitwarden.com/download/?app=cli&platform="
BIN_FOLDER="$TEMP_FOLDER_PATH"
FILE_NAME_ZIP="$BIN_FOLDER/bw.zip"
FILE_NAME_CLI="$BIN_FOLDER/bw"


if [[ "$IS_LINUX" == "true" ]]; then
    DOWNLOAD_LINK="${DOWNLOAD_LINK_BASE}linux"
fi
if [[ "$IS_WINDOWS" == "true" ]]; then
    DOWNLOAD_LINK="${DOWNLOAD_LINK_BASE}windows"
    FILE_NAME_CLI="$BIN_FOLDER/bw.exe"
fi
if [[ "$IS_MAXOS" == "true" ]]; then
    DOWNLOAD_LINK="${DOWNLOAD_LINK_BASE}macos"
fi


DO_DOWNLOAD_BW_CLI=true

if [[ -f $FILE_NAME_CLI ]]; then
    echo_verbose "found existing bitwarden cli binary"

    case $DOWNLOAD_BW_MODE in
        "ifnotexist")
            DO_DOWNLOAD_BW_CLI=false
            echo_verbose "skip download, bw cli already exists"
            ;;
        "always")
            DO_DOWNLOAD_BW_CLI=true
            echo_verbose "re-download because of download_bw_mode always"
            ;;
        *)
            abort_error "Invalid download_bw_mode: $DOWNLOAD_BW_MODE"
            ;;
    esac
fi


if [[ "$DO_DOWNLOAD_BW_CLI" == "true" ]]; then

    echo_verbose "using download link: $DOWNLOAD_LINK"

    echo_info "start download"
    execute curl -L -o $FILE_NAME_ZIP $DOWNLOAD_LINK

    if [[ -f $FILE_NAME_ZIP ]]; then
        echo_verbose "download zip successful"
    else
        abort_error "download zip failed"
    fi

    echo_verbose "unpacking downloaded zip file"
    execute unzip -o $FILE_NAME_ZIP -d $BIN_FOLDER

    echo_verbose "unpacking finished"

fi


export BITWARDEN_CLI="$FILE_NAME_CLI"
echo_verbose "using cli executable: $BITWARDEN_CLI"


if [[ -f $BITWARDEN_CLI ]]; then
    echo_success "download bitwarden cli binary successful"
else
    abort_error "download bitwarden cli binary failed"
fi

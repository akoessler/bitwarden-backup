#!/bin/bash

echo
echo
echo_header "create backup"
echo


# set environment variables for api key login
export BW_CLIENTID=$(<$CLIENTID_PATH)
export BW_CLIENTSECRET=$(<$CLIENTSECRET_PATH)
MASTERPASSWORD=$(<$MASTERPASSWORD_PATH)


if [[ -z $BW_CLIENTID ]]; then
    abort_error "bitwarden client id is empty: $CLIENTID_PATH"
fi
if [[ -z $BW_CLIENTSECRET ]]; then
    abort_error "bitwarden client secret is empty: $CLIENTSECRET_PATH"
fi
if [[ -z $MASTERPASSWORD ]]; then
    abort_error "bitwarden master password is empty: $MASTERPASSWORD_PATH"
fi


EXPORT_FILE="$TEMP_FOLDER_PATH/$BACKUP_FILE"
echo_info "backup file name: $EXPORT_FILE"


if [[ -f $EXPORT_FILE ]]; then
    echo_verbose "delete existing backup file"
    execute rm $EXPORT_FILE
fi


echo
echo_info "set source server to: $SERVER_URL"
execute $BITWARDEN_CLI config server $SERVER_URL
echo_verbose "set config successful."


echo
echo_info "logout in case it is logged in"
set +e # ignore not logged in
execute $BITWARDEN_CLI logout
set -e
echo_verbose "login successful."


echo
echo_info "login to server"
execute $BITWARDEN_CLI login --apikey
echo_verbose "login successful."


echo
echo_info "export vault"
execute $BITWARDEN_CLI --raw export --format json --output $EXPORT_FILE < $MASTERPASSWORD_PATH
echo_verbose "export successful."


echo
echo_info "logout"
execute $BITWARDEN_CLI logout
echo_verbose "logout successful."


unset BW_CLIENTID
unset BW_CLIENTSECRET


if [[ ! -f $EXPORT_FILE ]]; then
    abort_error "file not found after export: $EXPORT_FILE"
fi

#!/bin/bash

CUR_DIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

set -e

. $CUR_DIR/lib/init-colors.sh


# see init args for usage:
. $CUR_DIR/lib/init-args.sh


# arguments are ok, let's go ...

. $CUR_DIR/lib/init-os.sh
. $CUR_DIR/lib/init-utils.sh


echo
echo_info "start bitwarden backup"


. $CUR_DIR/lib/download-bw-cli.sh


echo_verbose "remember previous server config setting"
previous_config_server=$($BITWARDEN_CLI config server)


. $CUR_DIR/lib/do-backup.sh


echo_verbose "restore previous server config setting"
execute $BITWARDEN_CLI config server $previous_config_server


echo
echo
echo_success "backup successful"

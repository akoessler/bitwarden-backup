#!/bin/bash

set -e

. ./lib/init-colors.sh


# see init args for usage:
. ./lib/init-args.sh


# arguments are ok, let's go ...

. ./lib/init-os.sh
. ./lib/init-utils.sh


echo
echo_info "start bitwarden backup"


. ./lib/download-bw-cli.sh


echo_verbose "remember previous server config setting"
previous_config_server=$($BITWARDEN_CLI config server)


. ./lib/do-backup.sh


echo_verbose "restore previous server config setting"
execute $BITWARDEN_CLI config server $previous_config_server


echo
echo
echo_success "backup successful"

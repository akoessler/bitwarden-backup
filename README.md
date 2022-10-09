# bitwarden-backup

Script to create backups of a bitwarden vault.

# Usage

## Instructions

Clone the repository, or put the script (including lib folder) into a folder manually.

Retrieve the api key from bitwarden (or vaultvarden server):
* https://bitwarden.com/help/personal-api-key/

Create a folder `input` and put the credentials into files there:
* Put the client id into a file `clientid`.
* Put the client secret into a file `clientsecret`.
* Put the master password into a file `masterpassword`.

Run `backup.sh` manually or set it as a cronjob for periodic backup.

## Notes / Limitations

The api key (client id and secret) is needed to login into the server.

The master password is also needed, because the bitwarden cli api asks for it during export.

The export is done with unencrypted json format, because that is tied to the encryption key.

The export is missing the folders, see: https://github.com/bitwarden/clients/issues/3615

Make sure the secret/password files and the export file are secured from unwanted access!

## Usage help text

```
Usage: backup.sh [OPTIONS]

Options:
  [--input_folder <folder>]               Folder where input files are searched for (see file parameters)  [default: ./input]
  [--temp_folder <folder>]                Temp folder to use for temporary files, e.g. bw cli executable  [default: ./temp]
  [--backup_file <filename>]              Filename of the json backup file, created in temp_folder  [default: export.json]

  [--server_url <url>]                    URL of the server to create the backup from  [default: https://bitwarden.com]
  [--sclientid_file <filename>]           File that contains the client id of the api key  [default: clientid]
  [--sclientsecret_file <filename>}       File that contains the client secret of the api key  [default: clientsecret]
  [--smasterpassword_file <filename>}     File that contains the master password of the vault  [default: masterpassword]

  [--download_bw_mode <mode>]             Set download mode for bw cli executable. Options: always, ifnotexist  [default: ifnotexist]
  [--verbose]                             Turn on verbose output

  [--help, -h]                            Display this help text

Notes:
  * The export is done with an unencrypted json export!
  * Secure the secret/password files as well as the export file from unwanted access!
```

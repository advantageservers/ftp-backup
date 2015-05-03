#!/bin/bash

FROM='MULTICRAFT_SERVER_LOCATION'
TO=$(date +%m-%d-%Y-%H%M%S).tar.gz

tar czfv "$TO" "$FROM"

HOST='FTP_HOST'
USER='USERNAME'
PASSWD='PASSWORD'

ftp -in <<EOF
open $HOST
user $USER $PASSWD
put $TO
close
bye
EOF

rm $TO

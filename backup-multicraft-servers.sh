#!/bin/bash

FROM='MULTICRAFT_SERVERS_DIR'
DATE=$(date +%m-%d-%Y-%H%M%S).tar.gz
TO='MULTICRAFT_USER_HOME_DIR'$DATE

tar czf "$TO" "$FROM"

HOST=''
USER=''
PASSWD=''

ftp -in <<EOF
open $HOST
user $USER $PASSWD
lcd MULTICRAFT_USER_HOME_DIR
put $DATE
close
bye
EOF

rm $TO

#!/bin/bash

# get a list of files and dates from ftp and remove files older than ndays
ftpsite=""
ftpuser=""
ftppass=""
putdir="/"

ndays=2

# work out our cutoff date
MM=`date --date="$ndays days ago" +%b`
DD=`date --date="$ndays days ago" +%d`

echo removing files older than $MM $DD

# get directory listing from remote source
listing=`ftp -i -n $ftpsite <<EOMYF
user $ftpuser $ftppass
binary
cd $putdir
ls
quit
EOMYF
`
lista=( $listing )

# loop over our files
for ((FNO=0; FNO<${#lista[@]}; FNO+=9));do
  # month (element 5), day (element 6) and filename (element 8)
  #echo Date ${lista[`expr $FNO+5`]} ${lista[`expr $FNO+6`]}          File: ${lista[`expr $FNO+8`]}

  # check the date stamp
  if [ ${lista[`expr $FNO+5`]}=$MM ];
  then
    if [ ${lista[`expr $FNO+6`]} -lt $DD ];
    then
      # Remove this file
      echo "Removing ${lista[`expr $FNO+8`]}"
      ftp -i -n $ftpsite <<EOMYF2
      user $ftpuser $ftppass
      binary
      cd $putdir
      delete ${lista[`expr $FNO+8`]}
      quit
EOMYF2


    fi
  fi
done

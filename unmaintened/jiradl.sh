#!/bin/bash

rmdl () {

  RMDL_USER=''
  RMDL_PASS=''
  RMDL_URL=''
  RMDL_AUTH='https://projects.savoirfairelinux.com/login'
  RMDL_COOKIE=/tmp
  RMDL_AUTH_STRING="loggedas"


  # Argument detector
  for RMDL_ARG in "$@"
  do

    if [[ ${RMDL_ARG} =~ ^[a-zA-Z0-9]+$ ]]; then
      # This is an username
      RMDL_USER=$RMDL_ARG
    elif [[ ${RMDL_ARG} =~ ^https?.* ]]; then
      # This is an URL
      RMDL_URL=$RMDL_ARG
    fi

  done

  # Ask for missing arguments
  if [ -z "$RMDL_URL" ]; then
    read -p "URL to download:" RMDL_URL
  else 
    echo "URL: ${RMDL_URL}"
  fi
  if [ -z "$RMDL_USER" ]; then
    read -p "Redmine username:" RMDL_USER
  else
    echo "Redmine username: ${RMDL_USER}"
  fi

  # Ask for user password
  read -s -p "Redmine password: " RMDL_PASS
  echo ""

  # Do the magic
  RMDL_COOKIE=${RMDL_COOKIE}/rmdl-$( echo ${RMDL_USER} | md5sum | cut -c 1-4)

  echo "Authenticating ..."
  RMDL_AUTH_TEST=$(wget --save-cookies ${RMDL_COOKIE} -O - --post-data "username=${RMDL_USER}&password=${RMDL_PASS}&autologin=true" ${RMDL_AUTH} 2>/dev/null )

  # Test authentication
  echo $RMDL_AUTH_TEST | grep -o ${RMDL_AUTH_STRING} &> /dev/null
  if [ $? == 1 ]; then
    echo "Failed to authenticate :("
    exit 1
  fi

  # Download the file
  echo "Downloading ..."
  wget --load-cookies ${RMDL_COOKIE} ${RMDL_URL}
  rm ${RMDL_COOKIE} 2> /dev/null

  echo "Done :-)"

}


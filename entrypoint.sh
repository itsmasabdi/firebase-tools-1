#!/bin/bash

set -e

if [ -z "$FIREBASE_TOKEN" ] && [ -z "$GCP_SA_KEY" ]; then
  echo "Either FIREBASE_TOKEN or GCP_SA_KEY is required to run commands with the firebase cli"
  exit 126
fi

if [ -n "$GCP_SA_KEY" ]; then
  echo "Storing GCP_SA_KEY in /opt/gcp_key.json"
  echo "$GCP_SA_KEY" > /opt/gcp_key.json
  echo "Exporting GOOGLE_APPLICATION_CREDENTIALS=/opt/gcp_key.json"
  export GOOGLE_APPLICATION_CREDENTIALS=/opt/gcp_key.json
fi

if [ -n "$PROJECT_PATH" ]; then
  cd "$PROJECT_PATH"
fi

if [ -n "$PROJECT_ID" ]; then
    echo "setting firebase project to $PROJECT_ID"
    firebase use --add "$PROJECT_ID"
fi

# if the args starts with ./ we are running a script
case "$*" in
  ./*) script_name=${*#./}; script_name=${script_name%% *}; echo "$script_name"; chmod +x "$script_name" && sh -c "$*";;
  *) sh -c "firebase $*";;
esac

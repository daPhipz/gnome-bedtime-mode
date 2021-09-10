#!/bin/bash

source common-vars.sh "$@"

if [ -z ${skip_metadata_prompt+x} ]; then
  read  -n 1 -p "Did you prepare the metadata.json file? (y/n) " user_input
  echo
  if [[ $user_input == "n" ]]; then exit 0; fi
fi

echo "Removing ui temp files and old packages, if any..."
rm -rf "$PROJECT_ROOT"/src/ui/*/preferences.ui~
rm -rf "$PROJECT_ROOT"/"$PACKAGE_NAME_PREFIX"*.zip

echo "Packing the extension..."
gnome-extensions pack \
    --force \
    --extra-source=$PROJECT_ROOT/src/icons \
    --extra-source=$PROJECT_ROOT/src/modules \
    --extra-source=$PROJECT_ROOT/src/schemas \
    --extra-source=$PROJECT_ROOT/src/ui \
    --extra-source=$PROJECT_ROOT/src/config.js \
    --extra-source=$PROJECT_ROOT/src/utils.js \
    --podir=$PROJECT_ROOT/po/ \
    --gettext-domain=$EXTENSION_DOMAIN \
    --out-dir=$PROJECT_ROOT \
    $PROJECT_ROOT/src

mv "$PROJECT_ROOT"/"$EXTENSION_UUID".shell-extension.zip $PACKAGE_FILE

echo "Package created: $PACKAGE_FILE"

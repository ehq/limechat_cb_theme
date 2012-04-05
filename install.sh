#!/bin/bash

# Actions can be --soft or --hard
# --soft will create symbolic links to files, to frequently updates.
# --hard will copy all files.

# Set soft action as default
ACTION=${1:-"--soft"}
FAILURE=0


PREV_DIR=`pwd`
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $PREV_DIR

DIR1="$HOME/Library/Application Support/LimeChat"
DIR2="$HOME/Library/Application Support/net.limechat.LimeChat-AppStore"
DIR3="/Library/Application Support/LimeChat"
DIR4="/Library/Application Support/net.limechat.LimeChat-AppStore"

ads=("$DIR1" "$DIR2" "$DIR3" "$DIR4")
for a in "${ads[@]}"; do
  if [ -d "$a" ]; then
    if [ $ACTION == "--hard" ]; then
      echo "Proceed with HARD installation."
      echo "Copying theme files into $a."
      cp -r "$SOURCE/cb/." "$a/Themes/."
    else
      if [ $ACTION == "--soft" ]; then
        echo "Proceed with SOFT installation."
        echo "Creating symbolic links into $a."
        ln -s "$SOURCE/cb/"* "$a/Themes/."
      else
        echo "Installation '$ACTION' unknown. Please select '--soft' or '--hard'"
        FAILURE=1
      fi
    fi
    break;
  fi
done

if [ $FAILURE == 0 ]; then
  echo "You should restart LimeChat and select new theme in preferences panel."
fi

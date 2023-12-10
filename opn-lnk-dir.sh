#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# caja open link directory in new window
#
# something windows always had, now caja can do it
# caja will follow the link but it becomes part of the current directory
# this will open the link directory, the actual link source
#
# usage:
# File -> Scripts -> opn-lnk-dir.sh
# -or-
# right(left) click -> Scripts -> opn-lnk-dir.sh
#
# first caja script
#---------------------------------------------------------------- initialization
hdg="opn-lnk-dir"
cat="$HOME/.icons/EMOJI Fav/Cat.png"
notify-send -i "$cat" "caja" "open link directory"
#------------------------------------------------------------------ main program
while read src
do
   if [[ "$src" != "" ]]                              # ignore empty lines
   then
      pth=$(realpath "$src")                          # dereference
      if [[ "$pth" != "$src" ]]                       # same ?
      then                                            # link found
         mim=$(mimetype --output-format "%d" "$pth")  # check for filename
         if [[ "$mim" != "folder" ]]
         then
            pth=${pth%/*}                             # remove filename
         fi
         caja "$pth" &
      fi
   fi
done <<< $CAJA_SCRIPT_SELECTED_FILE_PATHS
#-------------------------------------------------------------------------------

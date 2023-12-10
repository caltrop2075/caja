#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# date re-tag the file
#
# FYI this script will also do the same as dte-tag.sh
# 2023-11-04 added single file command line processing
#---------------------------------------------------------------- initialization
hdg="dte-re-tag"
cat="$HOME/.icons/EMOJI Fav/Cat.png"
err="$HOME/.icons/EMOJI Fav/Cat.png"
dte=$(date +"%Y-%m-%d")
# notify-send -i "$cat" "caja" "date re-tag"
#---------------------------------------------------------------------- function
function fx_dte-re-tag ()
{
   dir=${src%/*}                                   # directory
   nam=${src##*/}                                  # name
   nam=${nam/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] }
   des="$dir/$dte $nam"                            # build destination
   mv -n "$src" "$des"                             #  move/rename
}
#------------------------------------------------------------------ main program
if [[ $CAJA_SCRIPT_SELECTED_FILE_PATHS == "" ]]
then                                               # single file
   if [[ $1 == "" ]]
   then
      notify-send -i "$err" "ERROR!" "nothing to process"
      exit 1
   fi
   # notify-send -i "$cat" "$hdg" "single file"
   src="$1"
   fx_$hdg
   echo "$des"
else                                               # scan files
   # notify-send -i "$cat" "$hdg" "caja"
   while read src
   do
      if [[ "$src" != "" ]]                        # ignore empty lines
      then
         fx_$hdg
      fi
   done <<< $CAJA_SCRIPT_SELECTED_FILE_PATHS
fi
#-------------------------------------------------------------------------------

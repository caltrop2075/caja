#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# date tag the file
#
# dte-re-tag.sh does the same thing in addition to re-tagging
# 2023-11-04 added single file command line processing
#---------------------------------------------------------------- initialization
hdg="dte-tag"
cat="$HOME/.icons/EMOJI Fav/Cat.png"
err="$HOME/.icons/EMOJI Fav/Cat.png"
dte=$(date +"%Y-%m-%d")
# notify-send -i "$cat" "caja" "date tag"
#---------------------------------------------------------------------- function
function fx_dte-tag ()
{
   dir=${src%/*}                                   # directory
   nam=${src##*/}                                  # name
   des="$dir/$dte $nam"                            # build destination
   mv -n "$src" "$des"                             # move/rename
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
echo "$des"

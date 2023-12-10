#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# date de-tag the file
# 2023-11-04 added single file command line processing
#---------------------------------------------------------------- initialization
hdg="dte-de-tag"
cat="$HOME/.icons/EMOJI Fav/Cat.png"
err="$HOME/.icons/EMOJI Fav/Skull And Crossbones.png"
# notify-send -i "$cat" "caja" "date de-tag"
#---------------------------------------------------------------------- function
function fx_dte-de-tag ()
{
   des=${src/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] }
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

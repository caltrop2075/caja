#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# caja re-space
# leading ' ' -> '_'
#---------------------------------------------------------------- initialization
hdg="spc-re"
cat="$HOME/.icons/EMOJI Fav/Cat.png"
err="$HOME/.icons/EMOJI Fav/Skull And Crossbones.png"
# notify-send -i "$HOME/.icons/EMOJI Fav/Cat.png" "caja" "$hdg"
#---------------------------------------------------------------------- function
function fx_spc ()
{
   dir=${src%/*}
   nam=${src##*/}
   nam=${nam//_/ }                                 # '_' -> ' '
   if [[ ${nam:0:1} == " " ]]                      # leading ' ' -> '_'
   then
      nam=${nam/ /_}
   fi
   des="$dir/$nam"
   # echo $src
   # echo $des
   # echo
   mv -n "$src" "$des"
}
#------------------------------------------------------------------ main program
if [[ $CAJA_SCRIPT_SELECTED_FILE_PATHS == "" ]]
then                                               # single file
   if [[ $1 == "" ]]
   then
      notify-send -i "$err" "ERROR!" "nothing to process"
      exit 1
   fi
   notify-send -i "$cat" "$hdg" "single file"
   src="$1"
   fx_spc
else                                               # scan files
   notify-send -i "$cat" "$hdg" "caja"
   while read src
   do
      if [[ "$src" != "" ]]                        # ignore empty lines
      then
         fx_spc
      fi
   done <<< $CAJA_SCRIPT_SELECTED_FILE_PATHS
fi
#-------------------------------------------------------------------------------

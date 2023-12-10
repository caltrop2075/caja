#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# garbage stripping
# comment/youtube tag etc...
#
# 2023-11-03 added emoji stripping, 2nd use of until loop
# 2023-11-04 added single file command line processing
# 2023-11-14 fixed duplicate removal glitch
# 2023-12-08 tweaked garbage removal
#---------------------------------------------------------------- initialization
hdg="garbage"
cat="$HOME/.icons/EMOJI Fav/Cat.png"
err="$HOME/.icons/EMOJI Fav/Skull And Crossbones.png"
rgx="[ -~]"                                        # standard chr range
# notify-send -i "$cat" "caja" "garbage removal"
#---------------------------------------------------------------------- function
function fx_garbage ()
{
   dir=${src%/*}                                   # directory
   nam=${src##*/}                                  # name
   nam=${nam// \[*\]}                              # strip [youtube] tag
   # nam=${nam// \(*\)}                              # strip (misc) tag
   nam=${nam//_/ }                                 # strip (misc) tag

   siz=${#nam}                                     # strip emoji etc
   bld=""
   for ((i=0;i<siz;i++))
   do
      chr="${nam:$i:1}"
      if [[ "$chr" =~ $rgx ]]                      # detect std chr
      then
         bld="$bld$chr"
      else
         bld="${bld} "                             # emoji causes multi ' '
      fi
   done

   until [[ "$bld" == "$tmp" ]]                    # reduce duplicate ' ' & '.'
   do
      tmp=$bld
      bld=${bld//  / }
      bld=${bld//../.}
   done

   bld=${bld# }                                    # strip lead spc
   bld=${bld// ./.}                                # fix ' .' -> '.'

   nam="$bld"                                      #  build destination & rename
   des="$dir/$nam"
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

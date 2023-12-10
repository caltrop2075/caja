#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# filename upper case
#
# 2023-11-01 added FAT function
# 2023-11-02 fixed extension detection
# 2023-11-04 added single file command line processing
#---------------------------------------------------------------- initialization
hdg="case-u"
cat="$HOME/.icons/EMOJI Fav/Cat.png"
err="$HOME/.icons/EMOJI Fav/Skull And Crossbones.png"
# notify-send -i "$cat" "caja" "upper case"
#---------------------------------------------------------------------- function
function fx_case-u ()
{
   dir=${src%/*}                                   # directory
   fil=${src##*/}                                  # filename
   nam=${fil%.*}                                   # name
   ext=${fil##*.}                                  # extension
   if [[ "$nam" == "$ext" ]]                       # no extension
   then
      ext=""
   else
      ext=${ext,,}                                 # -> lcase
   fi
   while read -a ary
   do
      siz=${#ary[*]}
      des="$dir/"
      for ((i=0;i<siz;i++))
      do
         tmp=${ary[$i]^^}                          # upper
         if ((i<(siz-1)))
         then
            des="$des$tmp "
         else
            des="$des$tmp"
         fi
      done
      if [[ "$ext" != "" ]]                        # no extension
      then
         des="$des.$ext"
      fi
      fst=$(findmnt -no "fstype" --target "$src")  # fat detection
      if [[ $fst == vfat ]]
      then
         tmp="$dir/temp"
         mv "$src" "$tmp"
         src="$tmp"
      fi
      mv -n "$src" "$des"                          # move/rename
   done <<< $nam
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

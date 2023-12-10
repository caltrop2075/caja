#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# filename title case
#
# 2023-11-01 rewrote title case
#     originally read into array but... there's ' -._'...
#     scan the string instead of using array
#     regex =~ is finicky, best to define a variable and use that
#     added FAT function
# 2023-11-02 fixed extension detection
# 2023-11-04 added single file command line processing
# 2023-11-05 added misc spelling corrections: case-t.dat
#     roman numerals up to 20
#     tag detection 'TAG:'
#---------------------------------------------------------------- initialization
hdg="case-t"
cat="$HOME/.icons/EMOJI Fav/Cat.png"
err="$HOME/.icons/EMOJI Fav/Skull And Crossbones.png"
# notify-send -i "$cat" "caja" "title case"
#----------------------------------------------------------- title case function
function fx_case-t ()
{
   fst=$(findmnt -no "fstype" --target "$src")     # get file system
   dir=${src%/*}                                   # directory
   des="$dir/"                                     # destination
   fil=${src##*/}                                  # filename
   ext=${fil##*.}                                  # extension
   nam=${fil%.*}                                   # name
   siz=${#nam}                                     # name length
   reg="[^0-9a-zA-Z]"                              # regex white space detect
   f=1                                             # ucase flag
   tag=${nam%%:*}                                  # tag detection
   pos=${#tag}
   if ((pos==siz))
   then                                            # no tag
      pos=0
   else                                            # tag
      des="$des$tag"
   fi

   if [[ "$nam" == "$ext" ]]                       # no extension
   then
      ext=""
   else
      ext=${ext,,}                                 # -> lcase
   fi

   for ((i=pos;i<siz;i++))                         # scan name
   do
      chr=${nam:$i:1}                              # get character
      if ((f))                                     # case ?
      then                                         # ucase
         des="$des${chr^}"                         # tcase
         f=0
      else                                         # lcase
         des="$des${chr,}"
      fi
      if [[ $chr =~ $reg ]]                        # white space detect
      then
         f=1
      fi
   done

while read lin                                     #  misc substitutions
do
   rpl=${lin^^}                                    # ucase substitution
   rgxb="^$lin "                                   # regex's
   rgxe=" $lin$"
   if [[ "$des" =~ $rgxb ]]
   then                                            # begin
      des=${des/$lin /$rpl }
   elif [[ "$des" =~ $rgxe ]]
   then                                            # end
      des=${des/ $lin/ $rpl}
   else                                            # middle
      des=${des// $lin / $rpl }
   fi
done < /home/caltrop/.config/caja/scripts/case-t.dat

   if [[ "$ext" != "" ]]                           # extension ?
   then
      des="$des.$ext"
   fi
   fst=$(findmnt -no "fstype" --target "$src")     # fat detection
   if [[ $fst == vfat ]]
   then
      tmp="$dir/temp"
      mv "$src" "$tmp"
      src="$tmp"
   fi
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
   # notify-send -i "$HOME/.icons/EMOJI Fav/Cat.png" "$hdg" "single file"
   src="$1"
   fx_$hdg
   echo "$des"
else                                               # scan files
   # notify-send -i "$HOME/.icons/EMOJI Fav/Cat.png" "$hdg" "caja"
   while read src
   do
      if [[ "$src" != "" ]]                        # ignore empty lines
      then
         fx_$hdg
      fi
   done <<< $CAJA_SCRIPT_SELECTED_FILE_PATHS
fi
#-------------------------------------------------------------------------------

#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# filename garbage & title case
#
# 2023-11-04 added single file command line processing
#     blank caja list so single file will process
#     single file processing returns the destination filename
#---------------------------------------------------------------- initialization
hdg="case-t+"
tmp=$CAJA_SCRIPT_SELECTED_FILE_PATHS               # transfer caja files
# export CAJA_SCRIPT_SELECTED_FILE_PATHS=""          # blank caja list
unset CAJA_SCRIPT_SELECTED_FILE_PATHS              # blank caja list
#------------------------------------------------------------------ main program
   while read src
   do
      if [[ "$src" != "" ]]                        # ignore empty lines
      then
         src=$($HOME/.config/caja/scripts/garbage.sh "$src")
         $HOME/.config/caja/scripts/case-t.sh "$src"
      fi
   done <<< $tmp
#-------------------------------------------------------------------------------

# caja
caja file manager scripts

if you're running (Mint) Mate the file manager is Caja
================================================================================
finally started doing caja scripts - never knew...

scripts go here:
$HOME/.config/caja/scripts

usage:
File -> Scripts -> scripts.sh
-or-
right(lefty) click -> Scripts -> scripts.sh

NOTICE! now works on FAT drives that are case insensitive

caja uses $CAJA_SCRIPT_SELECTED_FILE_PATHS to pass the script files
file_1\n
file_2\n
file_3\n
[when reading there will be a blank line]

all the scripts have blank line detection
--------------------------------------------------------------------------------
test script outside of caja

disable the action & add test output in the caja script
usually: mv "$src" "$des" -> echo mv "$src" "$des"
now you can see what's going on

then in a calling script...

test.sh:
#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By YOU                                 #
#------------------------------------------------------------------------------#
caja uses:
command line -- filename without directory, why...?
$CAJA_SCRIPT_SELECTED_FILE_PATHS -- complete list of filenames
================================================================================
CAJA SCRIPTS

all these scripts you can select multiple files

and you can use them with other scripts
set the caja variable to a list of files
or add a file as a command line argument
--------------------------------------------------------------------------------
EXAMPLES

                      tesT:😠thIs-😡&🤬tHat_💥STUFF💀$ (comment) [youtube].txt
case-t+.sh            Test: This- & That_ Stuff $.txt
case-t+.sh dte-tag.sh 2023-11-04 Test: This- & That_ Stuff $.txt
garbage.sh            tesT: thIs- & tHat_ STUFF $.txt
garbage.sh case-l.sh  test: this- & that_ stuff $.txt
garbage.sh case-t.sh  Test: This- & That_ Stuff $.txt
garbage.sh case-u.sh  TEST: THIS- & THAT_ STUFF $.txt
--------------------------------------------------------------------------------
_blank.sh

does nothing but display selection information
you can use this as a start for your script
--------------------------------------------------------------------------------
case-l.sh   case-t.sh   case-u.sh

change filename case: lower, title, upper
extension is changed to lower case
test file.TXT -> Test File.txt
--------------------------------------------------------------------------------
case-t+.sh

does garbage.sh & case-t.sh

unfortunately you can not call multiple scripts in the script
after the first script the file(s) have changed
but... I FIXED IT!
--------------------------------------------------------------------------------
dte-tag.sh  dte-de-tag.sh  dte-re-tag.sh

today's date

dte-re-tag.sh does the same thing as dte-tag.sh in addition to re-tagging

dte-tag     file.ext            -> yyyy-mm-dd file.txt
dte-de-tag  yyyy-mm-dd file.txt -> file.ext
dte-re-tag  yyyy-mm-dd file.txt -> yyyy-mm-dd file.ext
--------------------------------------------------------------------------------
garbage.sh

strip garbage stuff: emoji, (misc comment), [youtube]

run this then one of the case scripts and you should be set
except for maybe a date tag
--------------------------------------------------------------------------------
opn-lnk-dir.sh

something windows always had, now caja can do it

caja follows the link but it becomes part of the current directory
so when you copy & paste the file has the WRONG directory!

this will open the link directory, the actual link source
now whenyou copy & paste the file has the RIGHT directory!

WARNING! opens in a NEW window, but that's OK...
--------------------------------------------------------------------------------
spc-de.sh   spc-re.sh

de-space & re-space underscore
leading space is always '_'

_test - this & that.txt -> _test_this_&_that.txt -> _test this & that.txt
================================================================================

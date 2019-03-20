
:: The first parameter passed to the batch file(%1) is the project root directory
:: Enter into project root directory before starting the command
::ECHO %CD%
::PAUSE
:: CD %1

:: Create cscope.files
::SET IN_DIR=%CD%
::SET OUT_DIR=%CD%
::find  $IN_DIR                                                                   \
::	-path "$IN_DIR/arch/*" ! -path "$IN_DIR/arch/i386*" -prune -o               \
::	-path "$IN_DIR/include/asm-*" ! -path "$IN_DIR/include/asm-i386*" -prune -o \
::	-path "$IN_DIR/tmp*" -prune -o                                              \
::	-path "$IN_DIR/Documentation*" -prune -o                                    \
::	-path "$IN_DIR/scripts*" -prune -o                                          \
::	-path "$IN_DIR/drivers*" -prune -o                                          \
::    -name "*.[chxsS]"                                                           \
::	-print >$OUT_DIR/cscope.files

:: Create the new cscope tags file to project root folder
cscope.exe -b -q -k

:: Repace the tag file with the new tag file
:: DEL tags
:: RENAME tags.new tags


:: The first parameter passed to the batch file(%1) is the project root directory
:: Enter into project root directory before starting the command
:: ECHO %CD%
:: PAUSE
:: CD %1

:: Create the new Ctags file to project root folder(the current folder)
ctags.exe -R -o tags.new

:: Repace the tag file with the new tag file
DEL tags
RENAME tags.new tags

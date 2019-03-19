
:: The first parameter passed to the batch file(%1) is the project root directory
:: Enter into project root directory before starting the command
CD %1

:: Create the new Ctags file to project root folder
ctags.exe -R -o tags.new %1

:: Repace the tag file with the new tag file
DEL tags
RENAME tags.new tags

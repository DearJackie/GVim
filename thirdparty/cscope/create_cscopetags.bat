
@ECHO OFF
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

::Usage: cscope [-bcCdehklLqRTuUvV] [-f file] [-F file] [-i file] [-I dir] [-s dir]
::              [-p number] [-P path] [-[0-8] pattern] [source files]
::
::-b            Build the cross-reference only.
::-C            Ignore letter case when searching.
::-c            Use only ASCII characters in the cross-ref file (don't compress).
::-d            Do not update the cross-reference.
::-e            Suppress the <Ctrl>-e command prompt between files.
::-F symfile    Read symbol reference lines from symfile.
::-f reffile    Use reffile as cross-ref file name instead of cscope.out.
::-h            This help screen.
::-I incdir     Look in incdir for any #include files.
::-i namefile   Browse through files listed in namefile, instead of cscope.files
::-k            Kernel Mode - don't use /usr/include for #include files.
::-L            Do a single search with line-oriented output.
::-l            Line-oriented interface.
::-num pattern  Go to input field num (counting from 0) and find pattern.
::-P path       Prepend path to relative file names in pre-built cross-ref file.
::-p n          Display the last n file path components.
::-q            Build an inverted index for quick symbol searching.
::-R            Recurse directories for files.
::-s dir        Look in dir for additional source  files.
::-T            Use only the first eight characters to match against C symbols.
::-U            Check file time stamps.
::-u            Unconditionally build the cross-reference file.
::-v            Be more verbose in line mode.
::-V            Print the version number.
::
::Please see the manpage for more information.

@ECHO "Creating cscope tags ... "

@ECHO OFF

:: Create the new cscope tags file to project root folder:
IF EXIST cscope.out (
	ECHO "a"
    cscope.exe -R -b -q -k -f cscope_new.out
:: Rename the files to its original: cscope.out, cscope.in.out, cscope.po.out
    DEL cscope.out
	IF EXIST cscope.in.out DEL cscope.in.out
	IF EXIST cscope.po.out DEL cscope.po.out
	RENAME cscope_new.out     cscope.out
	RENAME cscope_new.out.in  cscope.in.out
	RENAME cscope_new.out.po  cscope.po.out
) ELSE (
    cscope.exe -R -b -q -k
	ECHO "b"
)

@ECHO "cscope tags created/updated!"

::PAUSE 

:: Exit the command window automatically when completes
EXIT



[2019/03/09]
1. Change git user name and email

[2019/03/09]
1. Add color scheme: Tomorrow-Night.vim
2. Customize based on default gvim _vimrc file
3. Add "gvim.bat" to run gvim in MAXMIZED window

[Misc Tips]
1. Useful environment vairables:
$HOME
$VIM
$VIMRUNTIME
$VIMRC
$MYVIMRC
&rtp
&runtimepath - $VIMRUNTIMEPATH is part of this variable

2. In windows system, to run external command without pending vim, using the following format:
:!start cmd /k "my app.exe"

3: Create tags for Linux kernel (using scripts\tags.sh):
make O=. ARCH=arm SUBARCH=omap2 COMPILED_SOURCE=1 cscope tags
make ARCH=x86 cscope tags

4. Clear the highlights temparorily after search by "/": ":noh"

5. When in command line mode, to navigate command history but not using arrow keys, you can use "ctrl-p" and "ctrl-n".

6. Build tags for new plugins: helptags ALL

7. Show command history in a window: "q:", you can edit command here; "ctrl-c" moves to command line from command history(ie, exit "q:" mode)

8. show all buffers including unlisted buffers: ":ls!" 

9. ctrl-^: toggle between "current file"(_%) and "alternate file"(_#) within a window(last edited/opened file in the window);
   [N]ctrl-^: switch between buffer list, "N" is the buffer number

10. Normal mode:
ctrl-o: cursor position back
ctrl-i: cursor position forward
ctrl-g: print the current file name with full path(:file) 

11. copy the current the file and rename: ":file {name}"

12. [CSCOPE Usage]
Add program "cscope.exe"(v16.0a by cscope --version), and its dependencies(curses2.dll, regex2.dll) to "vim81"
Download source: https://sourceforge.net/projects/mslk/files/Cscope/cscope-15.7/
 
To build the database, follow the steps:
1). Create the file list cscope will build database on: cscope.files
2)). Run "cscope -b -q -k" program to create a database for the listed source files, the generated database name
   is "cscope.out":
   -b: create database only, no GUI
   -q: created inverted index file
   -k: kernel mode, don't use /usr/include for #include files 
   -R: Recursive directories for files
   -s dir: Look in "dir" for additional source files
   -i namefile: browse through files listed in "namefile" instead of "cscope.files"
   -d: Don't update the cross-references
3). Add the database connection to Vim: ":cs add cscope.out", check the connection status using: ":cs show"
4). Once a scope connection is established, make queries to cscope in Vim: ":cs find <type> <symbol>". This can
   be mapped to shortcut keys("cscope_maps.vim" does this).
5). " Ctrl - T " to go back to previous one.


13. Search and replace in VIM:
a) To search, in NORMAL mode, type "/" followed by search key word for forward search, "?" for backward search
b) To replace, in EX mode: [range]s/search/replace/[gc]:
    range: optional, line numbers, if ommit, just search and replace current line
	g: optional, without "g", only replace the first occurrence
	c: optional, confirmation needed for replacement
	:%s/search/replace/: search the whole file
	enter VISUAL mode and type the command, to search in the selected range, note that DON'T delete the existing characters in EX line which indicating the ranges

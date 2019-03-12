
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

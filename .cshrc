set path = ( . $path)


#set path=($path /usr/local/bin /opt/local/bin /opt/local/sbin ~/bin)
#set prompt="$USER% "
set prompt='[%n@%m %c]$ '
set pushdsilent
set ignoreeof
set savehist=100
setenv LANG C
setenv LC_CTYPE ja_JP.UTF-8
setenv XDG_CONFIG_HOME ~/.config
setenv NVIM_PYTHON_LOG_FILE ~/.tmp
setenv NVIM_PYTHON_LOG_LEVEL DEBUG
setenv PYTHONPATH /Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Resources/Python
setenv GTAGSLABEL pygments
setenv GOPATH $HOME/go
setenv GOROOT /usr/local/opt/go/libexec
set path = ($path /usr/local/opt/go/libexec/bin)
set path = ($path $GOPATH/bin)
#setenv XMODIFIERS @im=uim
#setenv GTK_IM_MODULE uim
#setenv UIM_CANDWIN_PROG uim-cadwin-gtk
#setenv VISUAL /usr/bin/vi
#setenv PAGER /usr/bin/less
#setenv CVS_RSH ssh
alias ls 'ls -GFv'
alias la 'ls -a'
alias ll 'ls -l'
alias mv 'mv -i'
alias cp 'cp -i'
alias rm 'rm -i'
alias dirs 'dirs -v'
alias md 'mkdir'
alias vi 'nvim'
alias h  'history'
alias x  'xterm -geometry 100x30'
alias ag 'ag --nocolor' 
alias s "cd $GOPATH/src" 
alias d "cd $GOPATH/src/devel" 

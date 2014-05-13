#
# ~/.bashrc
#
# This is the initialization file for bash, and is read each time an instance of
# your shell executes. A shell starts up, for example, when you open a new xterm
# window, remotely log on to another machine, or type 'bash' or 'sh' to start a
# new shell explicitly.
#
# Refer to bash(1) for more information.
#
# The shell treats lines beginning with # as comments.
#
# EDIT THIS FILE to customize *only* shell-specific options for bash (e.g.
# prompt). All other shell options go in ~/.environment.
#

# Define the shell-independent environment commands. See hooks(7) for more
# information.
setenvvar () { eval $1=\"$2\"; export $1; }
setenvifnot () { if eval [ -z \"\$$1\" ]; then eval $1=\"$2\"; export $1; fi; }
pathappend () { if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1; then true; else eval $1=\$$1:$2; fi; }
pathappendifdir () { if [ -d "$2" ]; then pathappend $*; fi; }
pathprepend () { if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1; then true; else eval $1=$2:\$$1; fi; }
pathprependifdir () { if [ -d "$2" ]; then pathprepend $*; fi; }
shellcmd () { _cmd=$1; shift; eval "$_cmd () { command $* \"\$@\"; }"; }
sourcefile () { if [ -f "$1" ]; then . $1; fi; }

xw () {
	setsid xwrits typetime=5 breaktime=:30 title=Micro canceltime=5 after=2 maxhands=20 +multiply
	setsid xwrits typetime=55 breaktime=5 title=Macro canceltime=5 after=2 maxhands=20 +multiply
}

mycd () {
    cd "$@"
    echo `pwd`
    if [[ -r "README" ]]
    then
        col -b < README
    fi
    if [[ -r "TODO" ]]
    then
        col -b < TODO
    fi
    if pwd | grep -q "^/\(course\)\|\(pro\)\|\(admin\)\|\(contrib\)\|\(research\)"
    then
		if pwd | grep -q "\(www\)\|\(web\)"
		then
			umask 002
		elif pwd | grep -q "plt"
		then
			umask 002
		else
	        umask 007
		fi
    elif pwd | grep -q "compilers/rkt"
	then
        umask 026
	elif pwd | grep -q "\(public_html\)\|\(www\)\|\(web\)\|\(srv\)"
	then
		umask 022
	else
		umask 066
    fi
}
# Load personal environment settings.
sourcefile $HOME/.environment

# Run the coursehooks.
#sourcefile /u/system/hooks/sh/simple-hooks

sourcefile $HOME/.aliases

# If this is a non-interactive shell, exit. The rest of this file is loaded
# only for interactive shells.
if [[ -z "$PS1" ]]; then
	return
fi

# Set tty options.
stty sane

set -o vi

# Set the shell to prevent programs from dumping core.
ulimit -c 0

# Set the prompt.
PS1="\[`tput rev`\]\h\[`tput sgr0`\] \w \$ ";


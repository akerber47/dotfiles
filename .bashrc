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
#setenvifnot () { if eval [ -z \"\$$1\" ]; then eval $1=\"$2\"; export $1; fi; }
pathappend () { if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1; then true; else eval $1=\$$1:$2; fi; }
pathappendifdir () { if [ -d "$2" ]; then pathappend $*; fi; }
pathprepend () { if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1; then true; else eval $1=$2:\$$1; fi; }
pathprependifdir () { if [ -d "$2" ]; then pathprepend $*; fi; }
shellcmd () { _cmd=$1; shift; eval "$_cmd () { command $* \"\$@\"; }"; }
sourcefile () { if [ -f "$1" ]; then . $1; fi; }

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
}

# install rlwrap on vm
# Doesn't really work... pseudo-terminal + su password issues
rlwrap_install () {
    scp ~/Downloads/rlwrap-0.42.tar "$@":~
    ssh -t -t "$@" <<-EOF
      tar xvvf rlwrap-0.42.tar
      cd rlwrap-0.42
      ./configure
      make
      su -c 'make install' root
      cd ..
      rm -rf rlwrap-0.42 rlwrap-0.42.tar
      su -c '/sbin/shutdown -h now' root
EOF
}

# yay dcenter
sourcefile $HOME/.bashrc-dc

# Load personal environment settings.
sourcefile $HOME/.environment

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

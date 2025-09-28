# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=㉿
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
        prompt_color='\[\033[;94m\]'
        info_color='\[\033[1;31m\]'
        # Skull emoji for root terminal
        #prompt_symbol=💀
    fi
    case "$PROMPT_ALTERNATIVE" in
    twoline)
        PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '
        ;;
    oneline)
        PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\[\033[00m\]:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ '
        ;;
    backtrack)
        PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        ;;
    esac
    unset prompt_color
    unset info_color
    unset prompt_symbol
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'  # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'  # begin bold
    export LESS_TERMCAP_me=$'\E[0m'     # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m' # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'     # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'  # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'     # reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# PATH
export PYTHONPATH=/home/grwcha/grwna/usersettings/pyscripts
export PATH=/bin:/usr/bin:$PATH
export PATH=/home/grwcha/installed/MiniForge3/bin:$PATH

# ALIASES
alias add-ssh='source /usr/local/bin/init-ssh'                            # SSH for github
alias pwn-temp='cat ~/github/random-tools/code-templates/pwn-template.py' # Template for pwntools
alias fuzz-temp='cat ~/github/random-tools/code-templates/pwn-fuzzy-template.py'
alias shell-temp='cat ~/github/random-tools/code-templates/pwn-shell-template.s'
alias aslr-off='echo 0 | sudo tee /proc/sys/kernel/randomize_va_space'
alias aslr-on='echo 2 | sudo tee /proc/sys/kernel/randomize_va_space'
alias pwncol='ssh -i key hacker@pwn.college' # Run pwncollege locally
alias unzip-temp='cat /home/grwcha/grwna/usersettings/scripts/unzip_pass.sh'
alias zrm='rm *Zone.Identifier'
alias crm='rm core.*'
alias dwpwn="scp -r -i ~/grwna/learn/pwncollege/key hacker@pwn.college:/challenge ."
alias rappel='~/grwna/installed/rappel/bin/rappel'
alias ebs='nvim ~/.bashrc'
alias sbs='source ~/.bashrc'
alias csh='gcc -nostdlib -static shellcode.s -o shellcode'

# Ghidra
alias ghidra='cmd.exe /c "D:\RaFa\Main\Program\aaProgramming Language And Others\Ghidra\ghidra_11.1.2_PUBLIC\ghidraRun.bat"'
alias clear-ghidra='rm ~/file-ghidra/*'

function ghidra-file() {
    cp "$1" ~/file-ghidra
}

# StegSolve
alias stegsolve='cd ~/grwna/installed/steg-solve/bin ; /mnt/d/RaFa/Main/Program/aaProgramming\ Language\ And\ Others/Amazon\ Coretto\ 17/jdk17.0.12_7/bin/java.exe -jar stegsolve.jar; cd -'
function stegsolve-file() {
    cp "$1" ~/grwna/installed/steg-solve/bin
}
alias clear-stegsolve='find ~/grwna/installed/steg-solve/bin/ -type f ! -name "*.jar" -exec rm {} +'

# OpenStego
alias openstego='cd ~/grwna/installed/openstego/lib ; /mnt/d/RaFa/Main/Program/aaProgramming\ Language\ And\ Others/Amazon\ Coretto\ 17/jdk17.0.12_7/bin/java.exe -jar openstego.jar; cd -'
function openstego-file() {
    cp "$1" ~/grwna/installed/openstego/files
}
alias clear-openstego='rm ~/grwna/installed/openstego/files/'

# Shell Functions
function init-cdump {
    echo "echo '/tmp/core.%e.%p' | sudo tee /proc/sys/kernel/core_pattern"
}

function reset-cdump {
    echo "|/wsl-capture-crash %t %E %p %s" | sudo tee /proc/sys/kernel/core_pattern
}
hexi() {
    # Check if the first argument is the reverse flag '-r'
    if [ "$1" = "-r" ]; then
        # Hex to Decimal: Convert the second argument
        printf "%d\n" "0x$2"
    else
        # Decimal to Hex: Convert the first argument and add '0x' prefix
        printf "0x%x\n" "$1"
    fi
}

asc() {
    if [ "$1" = "-r" ] || [ "$1" = "--reverse" ]; then
        local input_numbers="$2"
        local result_string=""

        if [ -z "$input_numbers" ]; then
            echo "Error: No number string provided for reverse conversion." >&2
            return 1
        fi

        for ((i = 0; i < ${#input_numbers}; i += 2)); do
            local num_chunk="${input_numbers:$i:2}"

            if ! [[ "$num_chunk" =~ ^[0-9]+$ ]]; then
                echo "Warning: Skipping non-numeric chunk '$num_chunk' in input." >&2
                continue
            fi

            result_string+=$(printf \\$(printf '%03o' "$num_chunk"))
        done

        printf "%s\n" "$result_string"

    else
        local input_string="$1"
        local result_numbers=""

        if [ -z "$input_string" ]; then
            echo "Error: No string provided for conversion." >&2
            return 1
        fi

        for ((i = 0; i < ${#input_string}; i++)); do
            local char="${input_string:$i:1}"
            result_numbers+=$(printf "%d" "'$char")
        done

        printf "%s\n" "$result_numbers"
    fi
}

len() {
    echo "${#1}"
}
bat() {
    batcat "$1"
}

function office2john() {
    python3 ~/grwna/usersettings/pyscripts/random/office2john.py "$1"
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/grwcha/grwna/installed/miniforge3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/grwcha/grwna/installed/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/grwcha/grwna/installed/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/grwcha/grwna/installed/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/grwcha/grwna/installed/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/grwcha/grwna/installed/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
export PATH=$PATH:~/go/bin
export PATH_TO_FX="~/kuliah/pbo/javafx-sdk-21.0.2/lib"
export LC_ALL=C.UTF-8
. "$HOME/.cargo/env"

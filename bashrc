##########
# PROMPT #
##########

. ~/.git-prompt.sh

# 8 Bit Colors
# black="\[\e[0;30m\]"
# red="\[\e[0;31m\]"
# green="\[\e[0;32m\]"
# blue="\[\e[0;34m\]"

# 256 Bit Colors
black="\[\e[38;5;0m\]"
red="\[\e[38;5;1m\]"
green="\[\e[38;5;2m\]"
blue="\[\e[38;5;4m\]"
maroon="\[\e[38;5;88m\]"
orange="\[\e[38;5;214\]"
gold="\[\e[38;5;3m\]"
reset="\[\e[0m\]"

# Customize prompt
prompt_command() {
    local status="$?"
    local status_color=""
    if [ $status != 0 ]; then
        status_color=$red
    else
        status_color=$black
    fi
    export PS1="${status_color}[\u@\h: \w]${green}$(__git_ps1 '(%s)')${reset}${status_color}\$${reset} "
}

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export PROMPT_COMMAND=prompt_command

#############
# LS_COLORS #
#############

# di = directory
# fi = file
# ln = symbolic link
# pi = fifo file
# so = socket file
# bd = block (buffered) special file
# cd = character (unbuffered) special file
# or = symbolic link pointing to a non-existent file (orphan)
# mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
# ex = file which is executable (ie. has 'x' set in permissions).

# 0   = default colour
# 1   = bold
# 4   = underlined
# 5   = flashing text
# 7   = reverse field
# 31  = red
# 32  = green
# 33  = orange
# 34  = blue
# 35  = purple
# 36  = cyan
# 37  = grey
# 40  = black background
# 41  = red background
# 42  = green background
# 43  = orange background
# 44  = blue background
# 45  = purple background
# 46  = cyan background
# 47  = grey background
# 90  = dark grey
# 91  = light red
# 92  = light green
# 93  = yellow
# 94  = light blue
# 95  = light purple
# 96  = turquoise
# 100 = dark grey background
# 101 = light red background
# 102 = light green background
# 103 = yellow background
# 104 = light blue background
# 105 = light purple background
# 106 = turquoise background

LS_COLORS='no=00;32:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:cd=32:bd=40;33;01:ex=00;32:mi=05;41:'
export LS_COLORS

#############
# SSH AGENT #
#############

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -t 1 ]; then
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            start_agent;
        }
    else
        start_agent;
    fi
fi

###########
# ALIASES #
###########

alias vi="vim"
alias v="vim"
alias s="sudo"
alias upme="sudo apt-get update && sudo apt-get upgrade"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias whichpy='env | grep VIRTUAL_ENV'
alias k='kubectl'
alias ks='kubectl -n kube-system'
alias kr='kubectl -n rook-ceph'
alias kubeme='source ~/ksansible/bin/activate && ansible-playbook -i ~/ksinv/inventory.ini -e "helm_enabled=True" -e "cert_manager_enabled=True" -e "ingress_nginx_enabled=True" -e "calico_ipip_mode=Never" -e "registry_enabled=True" -b -v cluster.yml'
alias cgo="cargo"

########
# PATH #
########

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/go/bin:/usr/local/go/bin:$HOME/.cargo/bin:$HOME/zig-linux:/snap/bin:"

MANPATH="$MANPATH:/usr/share/bcc/man:/usr/local/share/bpftrace/tools"
export MANPATH

########
# MISC #
########

export EDITOR='vim'
export HISTSIZE=1000000

# zsh like autocomplete
if [ -t 1 ]; then
    bind 'set show-all-if-ambiguous on'
    bind 'set completion-ignore-case on'
    bind 'set show-all-if-unmodified on'
    bind 'set menu-complete-display-prefix on'
    bind 'TAB:menu-complete'
fi

function eh {
    sed -i $1d $HOME/.ssh/known_hosts
}

function color256 {
    for fgbg in 38 48 ; do #Foreground/Background
        for color in {0..256} ; do #Colors
            #Display the color
            echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
            #Display 10 colors per lines
            if [ $((($color + 1) % 10)) == 0 ] ; then
                echo #New line
            fi
        done
        echo #New line
    done
}

source "$HOME/.cargo/env"

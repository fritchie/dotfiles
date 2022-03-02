##########
# PROMPT #
##########

. ~/.git-prompt.sh

# 256 Color fg
# \e [ 38 ; 5 ; color m
# 256 Color bg
# \e [ 48 ; 5 ; color m
# Truecolor fg
# \e [ 38 ; 2 ; R ; G ; B ; m
# Truecolor bg
# \e [ 48 ; 2 ; R ; G ; B ; m

# 256 Colors
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

# palette
# 0  black          #000000 fg 30 bg 40  0;0;0
# 1  red            #CC0000 fg 31 bg 41  204;0;0
# 2  green          #4E9A06 fg 32 bg 42  78;154;6
# 3  yellow         #C4A006 fg 33 bg 43  196;160;6
# 4  blue           #3465A4 fg 34 bg 44  52;101;164
# 5  magenta        #75507B fg 35 bg 45  117;80;123
# 6  cyan           #06989A fg 36 bg 46  6;152;154
# 7  white          #D3D7CF fg 37 bg 47  211;215;207
# 8  black bright   #555753 fg 90 bg 100 85;87;83
# 9  red bright     #EF2929 fg 91 bg 101 239;41;41
# 10 green bright   #8AE234 fg 92 bg 102 138;226;52
# 11 yellow bright  #FCE94F fg 93 bg 103 252;233;79
# 12 blue bright    #729FCF fg 94 bg 104 114;159;207
# 13 magenta bright #AD7FA8 fg 95 bg 105 173;127;168
# 14 cyan bright    #34E2E2 fg 96 bg 106 52;226;226
# 15 white bright   #EEEEEC fg 97 bg 107 238;238;236

# no = normal (default)
# di = directory
# fi = file
# ln = symbolic link
# pi = fifo file
# so = socket file
# bd = block (buffered) special file
# cd = character (unbuffered) special file
# or = symbolic link pointing to a non-existent file (orphan)
# mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
# ex = file which is executable (ie. has 'x' set in permissions)
# su = setuid
# sg = setgid
# tw = sticky dir + other writable
# ow = other writable
# st = sticky
# *.extension = file extension

# 0 = default color (reset)
# 1 = bold
# 2 = faint
# 3 = italic
# 4 = underline
# 5 = slow blink
# 6 = fast blink
# 7 = reversed
# 8 = erase
# 9 = strikethrough

#LS_COLORS='no=00;32:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:cd=32:bd=40;33;01:ex=00;32:mi=05;41:'
LS_COLORS='no=0:fi=0:di=0;38;2;196;160;6:ln=4;38;2;6;152;154:pi=0;38;2;6;152;154;48;2;0;0;0:so=1;38;2;117;80;123:cd=4;38;2;78;154;6:bd=1;38;2;0;0;0;48;2;196;160;6:ex=0;38;2;78;154;6:mi=5;38;2;0;0;0;48;2;204;0;0:or=5;38;2;0;0;0;48;2;204;0;0:su=4;38;2;52;101;164:sg=1;38;2;52;101;164:ow=0;38;2;196;160;6;48;2;0;0;0:tw=1;38;2;196;160;6;48;2;0;0;0:*.gz=4;38;2;117;80;123:'
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
#alias kubeme="source ~/ksansible/bin/activate && ansible-playbook -i inventory/inventory.ini -b -v cluster.yml"
alias kubeme='source ~/ksansible/bin/activate && ansible-playbook -i ~/ksinv/inventory.ini -e "helm_enabled=True" -e "cert_manager_enabled=False" -e "ingress_nginx_enabled=True" -e "ingress_nginx_host_network=True" -e "calico_ipip_mode=Never" -e "calico_endpoint_to_host_action=ACCEPT" -e "registry_enabled=True" -b -v cluster.yml'
#alias kubeme='source ~/ksansible3/bin/activate && ansible-playbook -i ~/ksinv/inventory.ini -e "helm_enabled=True" -e "cert_manager_enabled=False" -e "ingress_nginx_enabled=True" -e "ingress_nginx_host_network=True" -e "kube_network_plugin=cilium" -e "cilium_enable_prometheus=true" -e "cilium_enable_hubble=true" -e "cilium_hubble_install=true" -e "cilium_hubble_tls_generate=true" -e "cilium_kube_proxy_replacement=strict" -e "cilium_tunnel_mode=disabled" -e "cilium_auto_direct_node_routes=True" -e "cilium_version=v1.10.3" -e "cilium_native_routing_cidr=10.233.0.0/17" -e "registry_enabled=True" -b -v cluster.yml'

########
# PATH #
########

export GOPATH=$HOME/go
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/go/bin:/usr/local/go/bin:$HOME/.cargo/bin:/usr/share/bcc/tools:"
export MANPATH="$MANPATH:/usr/share/bcc/man"

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

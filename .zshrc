# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/root/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# 使用自己喜欢的主题
ZSH_THEME="xiong-chiamiov"

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# rust 和 golang 路径 改成自己的路径
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.cargo/bin:$PATH"
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/GoPro
export PATH=$PATH:/root/GoPro/bin

# 常用操作别名

# 简单操作别名
alias ..="cd .."
alias ...="cd ..; cd .."
alias ax="chmod a+x"
alias c="clear"
alias cl="clear;ls;pwd"
alias d='date +%F'
alias dfc="df -hPT | column -t"
alias diff="colordiff"
alias grep='grep --color=auto'
alias vi="vim"
alias e="vim"
alias r="source ~/.zshrc"
alias g="git"
alias l.='ls -d .* --color=auto'
alias mkcd='foo(){ mkdir -p "$1"; cd "$1" }; foo '
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias now='date +"%T"'
alias hosts="vim /etc/hosts"
alias pi="pip install"
# 改成自己的城市
alias w='curl -H"Accept-Language: zh-CN" wttr.in/HangZhou'
alias game='/usr/bin/2048.sh'   # https://github.com/mydzor/bash2048/blob/master/bash2048.sh
# for fun
alias hello="/usr/bin/hello.py"
alias h="history"
alias serve-dir='python -m SimpleHTTPServer'
alias dotfiles="ls -a | grep '^\.' | grep --invert-match '\.DS_Store\|\.$'"
alias sgo='foo() {..; mkcd "$1"; vim "$1".go}; foo'
alias k9='foo() {kill -9 $1}; foo'
eval $(thefuck --alias)

# 重用按键绑定 {{{
# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char
# Make the `beginning/end` of line and `bck-i-search` commands work within tmux
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
# }}}

# 常用文件编辑
alias et="vim ~/.tmux.conf"
alias ez="vim ~/.zshrc"
alias ev="vim ~/.vimrc"

# 主机性能负载别名
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias cpuinfo='lscpu'
alias meminfo="free -m -l -t"

# 网络信息别名
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias yumy="yum install -y $@"
alias topnet="netstat -nat | awk '{print $5}' | awk -F ':' '{print $1}' | sort | uniq -c | sort -rn | head -n 10"

# git相关
alias ga="git add"
alias gd="git diff"
alias gs="git status"
alias gst="git stash"
alias gp="git push"
alias gstp="git stash pop"
# 其他杂项
alias pscpu10='ps auxf | sort -nr -k 3 | head -10' ## Get server cpu info ##
alias :x='sync && exit'


# tmux 函数
function tmuxopen() {
 tmux attach -t $1
}

function tmuxnew() {
 tmux new -s $1
}

# 其他函数

function precmd {
  # vcs_info
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"
  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function hostinfo {
  echo "主机名:"  $HOSTNAME
  cpuinfo=$(cat /proc/cpuinfo | grep name | cut -c 13-50 | head -n 1)
  echo "CPU型号:" "$cpuinfo"
  cpus=$(cat /proc/cpuinfo | grep name | cut -c 13-50 | wc -l)
  echo "CPU核数:" "$cpus"
  mem=$(cat /proc/meminfo | grep MemTotal)
  echo "$mem"
}

function showpath {
  for dir in `echo "$PATH" | tr ':' ' '`
  do
     echo "执行路径有: $dir"
  done
}

# 给man页面着色
function man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# 获取本机IP地址，可能需要修改网卡参数
function myip() {
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp4s0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}


    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig enp0s8 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}

    echo ""
    echo "WAN IP: $extIp"

}

function current_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

# Zshell的配置
setopt no_beep
setopt interactive_comments # Allow comments even in interactive shells (especially for Muness)

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
autoload colors; colors
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word # Allow completion from within a word/phrase

# 拼写检查

setopt correct # spelling correction for commands
setopt correctall # spelling correction for arguments

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l --group-directories-first'
alias la='ls -A --group-directories-first'

alias less='less -X'

alias clipboard='xclip -sel clip'

# curl aliases
alias postjson='curl -H "Content-Type: application/json" -XPOST '
alias postjsonl='curl -H "Content-Type: application/x-json-stream" -XPOST '
#jwtcurl='curl -H"$(jwtheader)" -H"Content-Type:application/json"'
#jwtgen='npm run --silent --prefix="/Users/Phil/src/ui/the-ui/server" jwtgen -- --cwd=$(pwd)'
#jwtheader='echo "Authorization: Bearer $(jwtgen generate --algorithm ES512 --pemfile /Users/Phil/.devconfig/etc/jwt/jwt-private.pem)"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#function cd {
#    builtin cd "$@" && ls
#}

function ro-version {
  cd ${HOME}/src/manifests
  git branch -a | grep "remotes/origin/release/" | xargs git grep -B1 -A3 "$@"
  cd -
}

# don't overwrite a file when using > if the file exists
set -o noclobber

export EDITOR="vi"

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time24h="\t"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

# This PS1 snippet was adopted from code for MAC/BSD I saw from:
# http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better
export PS1=$BWhite$Time24h$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$IGreen'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$IRed'"$(__git_ps1 " {%s}"); \
  fi) '$IYellow$PathShort$Color_Off'\$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo " '$IYellow$PathShort$Color_Off'\$ "; \
fi)'

export PATH=$PATH:\
"$HOME/.local/bin":\
"$HOME/src/manifests/util":\
"$HOME/src/gen-utils/bin":\
"$HOME/src/redtail":\
"$HOME/src/fds-utils/src/python"


export PYTHONPATH=$PYTHONPATH:\
$HOME/src/master-data-service/misc/python:\
$HOME/src/gen-utils:\
$HOME/src/gen-utils/bin:\


alias licecap='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/LICEcap/licecap.exe'

# automatic completion for aws CLI
complete -C aws_completer aws

# RedOwl

# pull all "master" branches of Forcepoint repos
function fba-get-master {
  other_repos=(
    ansible
    the-ui
    manifests
    gen-utils
  )
  for repo in ${other_repos[@]}; do
    echo Pulling ${repo} ...
    cd ${HOME}/src/${repo} && git checkout master && git pull
  done

  # in required build order
  java_repos=(
    reveal-public
    redowl-kafka-libs
    rose
#    redowl-minigator
    reveal-common
    master-data-service
    ueba-publisher-service
#    outbound-api
  )
  for repo in ${java_repos[@]}; do
    echo Pulling ${repo} ...
    cd ${HOME}/src/${repo} && git checkout master && git pull
  done

  cd ~ && pwd
}

function fba-build {
  # in required build order
  java_repos=(
    reveal-public
    redowl-kafka-libs
    rose
#    redowl-minigator
    reveal-common
    master-data-service
    ueba-publisher-service
#    outbound-api
  )
  for repo in ${java_repos[@]}; do
    echo Pulling ${repo} ...
    cd ${HOME}/src/${repo} && mvn clean install -DskipTests
  done

  cd ~ && pwd
}



# --- UI stuff ---
#export PATH=$HOME/.rbenv/bin:\
#$HOME/.rbenv/plugins/ruby-build/bin:\
#$HOME/src/ateam-code/src/python/scripts:\
#$PATH
#eval "$(rbenv init -)"

export RO_UI_DIR='/home/poirel/src/the-ui'

alias gitmaster='git checkout master && git pull'

export RO_LOGSTASH='/home/poirel/.local/src/logstash-5.4.1/bin/logstash'


alias nifi-start='/home/poirel/.local/src/HDF-1.2.0.1-1/nifi/bin/nifi.sh start'
alias nifi-stop='/home/poirel/.local/src/HDF-1.2.0.1-1/nifi/bin/nifi.sh stop'
alias nifi-log='tail -f /home/poirel/.local/src/HDF-1.2.0.1-1/nifi/logs/nifi-app.log'

export RO_CONFIG_DIR='/home/poirel/src/my-config/ro-config'
alias ro-config="cd ${RO_CONFIG_DIR}"

# Reveal sourcecode aliases
export PATH=${PATH}:${HOME}/src/ansible/devutils

alias mcid='mvn clean install -DskipTests'
alias mcidd='mvn clean install -Dmaven.test.skip -Dcheckstyle.skip=true'
alias mcit='mvn --update-snapshots -DforkCount=1 -DreuseForks=false -Dtestng.excludedGroups=UnderDevelopment,RemoteHadoop,AWSAccess,RequiresInternetConnectivity clean install'
#alias mcit='mvn clean install -Dtestng.excludedGroups=UnderDevelopment,RemoteHadoop,AWSAccess,RequiresInternetConnectivity'
alias old-mcit='mvn clean install -DforkMode=always -Dtestng.excludedGroups=UnderDevelopment,RemoteHadoop,AWSAccess,RequiresInternetConnectivity'

alias the-ui='cd /home/poirel/src/the-ui'

# ro-schema
alias ro-schema-ensure='cd ~/src/reveal-common && java -jar $(find reveal-schema-cli/target -name "reveal-schema-cli-*-uberjar.jar") ensure --cluster clp --host localhost'

# MDS Aliases
alias mds='cd /home/poirel/src/master-data-service'
alias mdstest='mds && mvn clean install -Dtestng.excludedGroups=UnderDevelopment,RemoteHadoop,AWSAccess,RequiresInternetConnectivity -DforkMode=always'
# 2.13.6
alias mdsrun-2.13.6='mds && java -Xms256m -Xmx2048m -cp $(find reference-data-service/target -name "reference-data-service-*.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.13.6.yml'
alias mdsdebug-2.13.6='mds && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xms256m -Xmx2048m -XX:PermSize=512m -cp $(find reference-data-service/target -name "reference-data-service-*.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.13.6.yml'
# 2.15.1
alias mdsrun-2.15.1='mds && java -Xms256m -Xmx2048m -cp $(find reference-data-service/target -name "reference-data-service-*.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.15.1.yml'
alias mdsdebug-2.15.1='mds && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xms256m -Xmx2048m -XX:PermSize=512m -cp $(find reference-data-service/target -name "reference-data-service-*.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.15.1.yml'
# 2.50.0
alias mdsrun-2.50.0='mds && java -Xms256m -Xmx2048m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.50.0.yml'
alias mdsdebug-2.50.0='mds && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xms256m -Xmx2048m -XX:PermSize=512m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.50.0.yml'
# 2.50.1
alias mdsrun-2.50.1='mds && java -Xms256m -Xmx2048m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.50.1.yml'
alias mdsdebug-2.50.1='mds && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xms256m -Xmx2048m -XX:PermSize=512m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.50.1.yml'
# 2.51.0
alias mdsrun-2.51.0='mds && java -Xms256m -Xmx2048m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.51.0.yml'
alias mdsdebug-2.51.0='mds && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xms256m -Xmx2048m -XX:PermSize=512m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.51.0.yml'
# 2.60.0
alias mdsrun-2.60.0='mds && java -Xms256m -Xmx2048m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.60.0.yml'
alias mdsdebug-2.60.0='mds && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xms256m -Xmx2048m -XX:PermSize=512m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.60.0.yml'
# 2.70.0
alias mdsrun-2.70.0='mds && java -Xms256m -Xmx2048m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.70.0.yml'
alias mdsdebug-2.70.0='mds && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xms256m -Xmx2048m -XX:PermSize=512m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.70.0.yml'
# 2.71.0
alias mdsrun-2.71.0='mds && java -Xms256m -Xmx2048m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.71.0.yml'
alias mdsdebug-2.71.0='mds && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -Xms256m -Xmx2048m -XX:PermSize=512m -cp $(find reference-data-service/target -name "reference-data-service-*-uberjar.jar" | grep -v sources) com.redowlanalytics.reference.ReferenceDataService server ~/src/my-config/ro-config/mds-server-config_2.71.0.yml'

alias reveal-common='cd /home/poirel/src/reveal-common'
alias reveal-public='cd /home/poirel/src/reveal-public'

# ROSE aliases
alias rose='cd /home/poirel/src/rose'
# 2.70
alias roserun-2.70='rose && java -jar $(find rose-service/target -name "rose-service-*-uberjar.jar") server '"${RO_CONFIG_DIR}/ro-rose_2.70.0.yml"
alias rosedebug-2.70='rose && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar $(find rose-service/target -name "rose-service-*-uberjar.jar") server '"${RO_CONFIG_DIR}/ro-rose_2.70.0.yml"
# 2.71
alias roserun-2.71='rose && java -jar $(find rose-service/target -name "rose-service-*-uberjar.jar") server '"${RO_CONFIG_DIR}/ro-rose_2.71.0.yml"
alias rosedebug-2.71='rose && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar $(find rose-service/target -name "rose-service-*-uberjar.jar") server '"${RO_CONFIG_DIR}/ro-rose_2.71.0.yml"

# Outbound API aliases
alias oapi='cd /home/poirel/src/outbound-api'
# 2.60
alias oapirun-2.60.0='oapi && java -jar $(find ./target -name "outbound-api-*-uberjar.jar" | grep -v sources) server ~/src/my-config/ro-config/outbound-api-server-config_2.60.0.yml'
alias oapidebug-2.60.0='oapi && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar $(find ./target -name "outbound-api-*-uberjar.jar" | grep -v sources) server ~/src/my-config/ro-config/outbound-api-server-config_2.60.0.yml'
# 2.71
alias oapirun-2.71.0='oapi && java -jar $(find ./target -name "outbound-api-*-uberjar.jar" | grep -v sources) server ~/src/my-config/ro-config/outbound-api-server-config_2.71.0.yml'
alias oapidebug-2.71.0='oapi && java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar $(find ./target -name "outbound-api-*-uberjar.jar" | grep -v sources) server ~/src/my-config/ro-config/outbound-api-server-config_2.71.0.yml'

# redowl-kafka-libs aliases
alias redowl-kafka-libs='cd /home/poirel/src/redowl-kafka-libs'


# runstack variants
alias runstack-no-ingest='runstack -s ro-api -s reveal-public-api-service -s reveal-content-service -s reveal-conversion-service -s reveal-queue-worker-service -s ueba-publisher-service services'

export PATH=$PATH:$HOME/.tmux-profiles

#export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/"
export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"
export PATH=$JAVA_HOME/bin:$PATH

export GROOVY_HOME="/home/poirel/.gvm/groovy/2.3.5/"


export PATH=$PATH:$HOME/src/reveal-common/util:\
$HOME/src/rose/rose-service/src/main/python

export ORACLE_HOME=/usr/lib/oracle/12.1/client64
export LD_LIBRARY_PATH=$ORACLE_HOME/lib

alias diff=colordiff

# RedOwl vagrant
#alias ro-ansible='cd /home/poirel/src/ansible'
#export VAGRANT_CWD="/home/poirel/src/ansible/vagrant_env/dev-standalone"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set the tab title like so from the command line:
#     $ tab-title "My Tab"
function tab-title {
  if [ -z "$1" ]
  then
    title=${PWD##*/} # current directory
  else
    title=$1 # first param
  fi
  echo -n -e "\033]0;$title\007"
}
source <(kubectl completion bash)

source $HOME/.bashrc.d/ueba-jwt-generator.sh

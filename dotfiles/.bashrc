# Only read if this is an interactive shell
if [[ -z "$PS1" ]] ; then
  return
fi

# PS colors
# Regular
txtblk='\e[0;30m' # Black
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White

# Bold
bldblk='\e[1;30m' # Black
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White

# Underline
unkblk='\e[4;30m' # Black
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White

# Background
bakblk='\e[40m'   # Black
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White

# PS1 used colors
COLOR1="\[${bldcyn}\]"
COLOR2="\[${bldblu}\]"
COLOR3="\[${txtpur}\]"
COLOR4="\[${bakcyn}\]"
RESET="\[\e[m\]"

# LS colors
DEFAULT="00"
BOLD="01"
UNDERLINED="04"
FLASHING="05"
REVERSED="07"
CONCEALED="08"
BLACK="30"
RED="31"
GREEN="32"
ORANGE="33"
BLUE="34"
PURPLE="35"
CYAN="36"
GREY="37"
BLACK_BG="40"
RED_BG="41"
GREEN_BG="42"
ORANGE_BG="43"
BLUE_BG="44"
PURPLE_BG="45"
CYAN_BG="46"
GREY_BG="47"

# LS variables
DIR="di=${GREEN}:"
FILE="fi=${DEFAULT}:"
LINK="ln=${RED}:"
PIPE="pi=${RED}:"
SOCK="so=${RED}:"
BLOCK="bd=${RED}:"
CHAR="cd=${RED}:"
ORPHAN="or=${FLASHING};${RED}:"
MISSING="mi=${DEFAULT}"
EXEC="ex=${PURPLE}"

# Set LS Colors
LS_COLORS="${DIR}${FILE}${LINK}${PIPE}${SOCK}${BLOCK}${CHAR}${ORPHAN}${MISSING}${EXEC}"
export CLICOLOR=1
export LS_COLORS

# Set PS1 depending on terminal type
case "$TERM" in
xterm*|rxvt*|eterm*|screen*)
    PS1="${COLOR1}\u${RESET}@${COLOR2}\H${COLOR3}\w ${COLOR4}(\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\$${RESET} "
    ;;
*)
    PS1="> "
    ;;
esac

# Configure shell
HISTCONTROL=ignorespace
shopt -s extglob

# Add bash aliases
if [[ -f ~/.bash_aliases ]] ; then
    source ~/.bash_aliases
fi

# Git autocomplete
source /usr/share/bash-completion/completions/git

# Notify .bashrc has loaded
echo "The $USER .bashrc file has loaded"

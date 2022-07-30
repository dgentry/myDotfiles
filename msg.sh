# "source" this from an executable shell script to get a "msg"
# function that is better than plain "echo."
#
# msg attributes the messages to the "calling" script, plus the
# messages are colorized on color terminals.
#
# It provides log level names in colored/emphasized text.  For example:
# msg "${info}Some useful info"

myname=$(basename "$0")

msg() {
    if [[ " "$SUPER_QUIET != True ]]; then
        printf "$bldblu${myname}: ${txtrst}$1${txtrst}\n"
    fi
}

msgn() {
    printf "$bldblu${myname}: ${txtrst}$1${txtrst}"
}

# Variables for colors/contrast
if [[ $TERM == *"color"* ]]; then
    txtund=$(tput sgr 0 1)          # Underline
    txtbld=$(tput bold)             # Bold
    bldred=${txtbld}$(tput setaf 1) #  red
    bldblu=${txtbld}$(tput setaf 4) #  blue
    bldwht=${txtbld}$(tput setaf 7) #  white
    txtrst=$(tput sgr0)             # Reset
else
    txtund="_"
    txtbld="*"
    bldred=""
    bldblu=""
    bldwht=""
    txtrst=""
fi
info="${bldwht}*${txtrst}"
pass="${bldblu}*${txtrst}"
warn="${bldred}*${txtrst}"
ques="${bldblu}?${txtrst}"

# Get shellcheck to shut up about these being unused
echo "$txtund $info $pass $warn $ques" >/dev/null

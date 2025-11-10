ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%F{boldgreen}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Hey activate, I'm talking to you!
#export VIRTUAL_ENV_DISABLE_PROMPT=1
#echo "VEDP is $VIRTUAL_ENV_DISABLE_PROMPT"

# No need for the above -- the virtualenv zsh plugin uses:
ZSH_THEME_VIRTUALENV_PREFIX='('
ZSH_THEME_VIRTUALENV_SUFFIX=')'

function root_char {
    if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

# Fast branch (handles detached HEAD gracefully)
function fast_git_branch() {
  command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  local b
  b=$(command git symbolic-ref --short -q HEAD 2>/dev/null) || b=$(command git rev-parse --short HEAD 2>/dev/null)
  [[ -n $b ]] && echo "$b"
}

# Fast dirty bit for tracked changes (staged or unstaged)
function fast_git_dirty() {
  command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

  # Staged changes?
  command git diff-index --quiet --cached HEAD -- || { echo "%{$fg[red]%}⚡%{$reset_color%}"; return; }

  # Unstaged changes?
  command git diff-files --quiet || { echo "%{$fg[red]%}⚡%{$reset_color%}"; return; }
}


PROMPT='%(?, ,%{$fg[yellow]%}Status: $?%{$reset_color%}
)
%{$fg[green]%}$(virtualenv_prompt_info)%{$reset_color%}%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg[white]%}%3~ $fg_bold[green]$(fast_git_branch)%{$reset_color%}$(fast_git_dirty)
$(root_char) '

# I want time up a line
_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'

# Add time
# 219 is pale purple
RPS1="%{${_lineup}%}[%D{%m/%d} %F{219}%D{%L:%M:%S}]%{${_linedown}%}%f"

# Short right side info
# RPS1='%{$fg[white]%}%2~$(git_prompt_info) %{$fg_bold[blue]%}%m%{$reset_color%}'

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}("
#ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN=""
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ⚡%{$fg[yellow]%}"

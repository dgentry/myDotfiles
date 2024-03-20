ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Hey activate, I'm talking to you!
export VIRTUAL_ENV_DISABLE_PROMPT=0
#echo "VEDP is $VIRTUAL_ENV_DISABLE_PROMPT"

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

PROMPT='%{$fg[green]%}$(virtualenv_prompt_info)%{$reset_color%}%'

PROMPT='%(?, ,%{$fg[yellow]%}Status: $?%{$reset_color%}
)
%{$fg[green]%}$(virtualenv_prompt_info)%{$reset_color%}%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)
$(prompt_char) '

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Powerlevel10k theme
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# bin path
export PATH="$HOME/.local/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Python 3.13 configuration
export PATH="/opt/homebrew/opt/python@3.13/bin:$PATH"
alias python3="python3.13"
alias python="python3.13"
alias pip="pip3.13"
alias pip3="pip3.13"

# eza
alias ls='eza'
alias ll='eza -l'
alias la='eza -a'

# trash
alias rm='trash'
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# git
fpath=(~/.zsh/completions $fpath)
zstyle ':completion:*' menu select
setopt MENU_COMPLETE
autoload -Uz compinit
compinit

# Case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} m:{A-Z}={a-z}'

# Powerlevel10k config
[[ ! -f ~/.config/powerlevel10k/p10k.zsh ]] || source ~/.config/powerlevel10k/p10k.zsh

# BEGIN organic_analysis command-path hook
function _organic_analysis_chpwd() {
  case $PWD in
    /Users/kasparavicius/repos/organic_analysis|/Users/kasparavicius/repos/organic_analysis/*)
      zstyle ':completion:*' command-path '/Users/kasparavicius/.zsh/organic_analysis_bin'
      zstyle ':completion:*:-command-:*' tag-order 'commands'
      ;;
    *)
      zstyle -d ':completion:*' command-path
      zstyle -d ':completion:*:-command-:*' tag-order
      ;;
  esac
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _organic_analysis_chpwd
_organic_analysis_chpwd
# END organic_analysis command-path hook

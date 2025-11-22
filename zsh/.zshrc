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

# Powerlevel10k config
[[ ! -f ~/.config/powerlevel10k/p10k.zsh ]] || source ~/.config/powerlevel10k/p10k.zsh

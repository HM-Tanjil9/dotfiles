# =============================================================================
# ZSH CONFIGURATION FOR ARCH LINUX + HYPRLAND
# =============================================================================

# Pokemon colorscripts (if installed)
if command -v pokemon-colorscripts &> /dev/null; then
    pokemon-colorscripts -r
fi

# TV (terminal viewer) - check if installed
if command -v tv &> /dev/null; then
    eval "$(tv init zsh)"
fi

# zoxide (directory jumper)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Starship prompt (make sure it's installed: paru -S starship)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
    export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
fi

# Enable autocomplete
autoload -U compinit && compinit
autoload bashcompinit && bashcompinit

# Enable autosuggestions (install: paru -S zsh-autosuggestions)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# FZF (install: paru -S fzf)
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
fi

# Atuin shell history (install: paru -S atuin)
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)"
fi

# Direnv (install: paru -S direnv)
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

# =============================================================================
# BASIC ZSH OPTIONS
# =============================================================================
setopt autocd
setopt extendedglob
setopt interactivecomments
setopt prompt_subst
setopt histignorealldups
setopt histignorespace
setopt sharehistory

# =============================================================================
# HISTORY SETTINGS
# =============================================================================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# =============================================================================
# PATH CONFIGURATION
# =============================================================================
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/go/bin

# =============================================================================
# EDITOR CONFIGURATION
# =============================================================================
export EDITOR=nvim
export VISUAL=nvim

# =============================================================================
# KEY BINDINGS
# =============================================================================
# VI Mode
bindkey -v
bindkey 'jj' vi-cmd-mode

# Custom key bindings (if zsh-autosuggestions is installed)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] || [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    bindkey '^w' autosuggest-execute
    bindkey '^e' autosuggest-accept
    bindkey '^u' autosuggest-toggle
fi

# Navigation bindings
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# =============================================================================
# LANGUAGE
# =============================================================================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# =============================================================================
# ALIASES
# =============================================================================

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# List files (install eza: paru -S eza)
if command -v eza &> /dev/null; then
    alias l="eza -l --icons --git -a"
    alias la="eza -a"
    alias lt="eza --tree --level=2 --long --icons --git"
    alias ltree="eza --tree --level=2 --icons --git"
else
    alias l="ls -lah"
    alias la="ls -a"
    alias lt="ls -la"
fi

# Tree (install tree: paru -S tree)
alias tree="tree -a"

# Cat replacement (install bat: paru -S bat)
if command -v bat &> /dev/null; then
    alias cat="bat"
fi

# Clear
alias cl="clear"
alias cls="clear"

# =============================================================================
# GIT ALIASES
# =============================================================================
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gadd="git add"
alias ga="git add -p"
alias gcoall="git checkout -- ."
alias gr="git remote"
alias gre="git reset"
alias gs="git status"

# =============================================================================
# DOCKER/PODMAN ALIASES
# =============================================================================
if command -v docker &> /dev/null; then
    alias dco="docker compose"
    alias dps="docker ps"
    alias dpa="docker ps -a"
    alias dl="docker ps -l -q"
    alias dx="docker exec -it"
elif command -v podman &> /dev/null; then
    alias dco="podman compose"
    alias dps="podman ps"
    alias dpa="podman ps -a"
    alias dl="podman ps -l -q"
    alias dx="podman exec -it"
fi

# =============================================================================
# KUBERNETES ALIASES
# =============================================================================
if command -v kubectl &> /dev/null; then
    export KUBECONFIG=~/.kube/config
    alias k="kubectl"
    alias ka="kubectl apply -f"
    alias kg="kubectl get"
    alias kd="kubectl describe"
    alias kdel="kubectl delete"
    alias kl="kubectl logs -f"
    alias kgpo="kubectl get pod"
    alias kgd="kubectl get deployments"
    alias ke="kubectl exec -it"
    alias kcns='kubectl config set-context --current --namespace'

    # kubectx and kubens (install: paru -S kubectx)
    if command -v kubectx &> /dev/null; then
        alias kc="kubectx"
    fi
    if command -v kubens &> /dev/null; then
        alias kns="kubens"
    fi
fi

# =============================================================================
# NPM/YARN ALIASES
# =============================================================================
# Development servers
alias nd="npm run dev"
alias ns="npm start"
alias nb="npm run build"
alias nt="npm test"
alias ntw="npm run test:watch"
alias nl="npm run lint"
alias nf="npm run format"

# Installation
alias ni="npm install"
alias nci="npm ci"
alias nu="npm update"
alias nrm="npm remove"

# Yarn alternatives
if command -v yarn &> /dev/null; then
    alias yd="yarn dev"
    alias ys="yarn start"
    alias yb="yarn build"
    alias yt="yarn test"
    alias yi="yarn install"
    alias ya="yarn add"
    alias yrm="yarn remove"
fi

# =============================================================================
# GO
# =============================================================================
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# =============================================================================
# NIX
# =============================================================================
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
export NIX_CONF_DIR="$HOME/.config/nix"

# =============================================================================
# XDG CONFIGURATION
# =============================================================================
export XDG_CONFIG_HOME="$HOME/.config"

# =============================================================================
# CUSTOM FUNCTIONS
# =============================================================================

# Ranger file manager with cd on exit
function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )

    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}
alias rr='ranger'

# Navigation with ls after cd
cx() { cd "$@" && l; }

# Find and cd to directory
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }

# Find and copy file path to clipboard
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | xclip -selection clipboard 2>/dev/null || pbcopy; }

# Find and edit file with nvim
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)"; }

# =============================================================================
# SECURITY/TOOLS ALIASES (if tools are installed)
# =============================================================================
if command -v nmap &> /dev/null; then
    alias nm="nmap -sC -sV -oN nmap"
fi

if command -v gobuster &> /dev/null; then
    alias gobust='gobuster dir --wordlist ~/security/wordlists/diccnoext.txt --wildcard --url'
fi

if command -v ffuf &> /dev/null; then
    alias fuzz='ffuf -w ~/hacking/SecLists/content_discovery_all.txt -mc all -u'
fi

if command -v python &> /dev/null; then
    alias server='python -m http.server 4445'
fi

# =============================================================================
# HTTP CLIENT
# =============================================================================
if command -v xh &> /dev/null; then
    alias http="xh"
fi

# =============================================================================
# TMUX INTEGRATION (without auto-start)
# =============================================================================
if command -v tmux &> /dev/null; then
    # Save current directory for new windows
    precmd() {
        if [[ -n "$TMUX" ]]; then
            echo "$PWD" > ~/.tmux/last_dir 2>/dev/null
        fi
    }

    # Create new tmux window in current directory
    tn() {
        if [[ -n "$TMUX" ]]; then
            tmux new-window -c "$PWD" -n "$(basename "$PWD")"
            echo "Created new tmux window in: $PWD"
        else
            echo "Not in tmux session"
        fi
    }

    # Split horizontally
    th() {
        if [[ -n "$TMUX" ]]; then
            tmux split-window -h -c "$PWD"
            echo "Created horizontal split in: $PWD"
        else
            echo "Not in tmux session"
        fi
    }

    # Split vertically - renamed to tvs to avoid conflict with TV command
    tvs() {
        if [[ -n "$TMUX" ]]; then
            tmux split-window -v -c "$PWD"
            echo "Created vertical split in: $PWD"
        else
            echo "Not in tmux session"
        fi
    }

    # Tmux session management
    alias tls="tmux ls"
    alias trn='tmux rename-window'

    ta() {
        if [[ -n "$1" ]]; then
            tmux attach-session -t "$1"
        else
            tmux attach-session -t main 2>/dev/null || tmux new-session -s main
        fi
    }

    tkill() {
        if [[ -n "$1" ]]; then
            tmux kill-session -t "$1"
            echo "Killed session: $1"
        else
            echo "Usage: tkill <session-name>"
            tmux ls
        fi
    }

    mkdir -p ~/.tmux 2>/dev/null
fi

# =============================================================================
# MICROSERVICE MANAGEMENT (adjust paths for Arch)
# =============================================================================
export SERVICES_PATH="$HOME/Developer"  # Change this to your projects directory

# Quick navigation to services
alias rd="cd $SERVICES_PATH"

# Quick service starter
rd-go() {
    local service=$1
    if [[ -d "$SERVICES_PATH/$service" ]]; then
        cd "$SERVICES_PATH/$service"
        if [[ -n "$TMUX" ]]; then
            tmux rename-window "$service"
        fi
        echo "Now in: $service"
    else
        echo "Service not found: $service"
    fi
}

# Autocomplete for rd-go
_rd-go() {
    compadd $(ls "$SERVICES_PATH" 2>/dev/null)
}
compdef _rd-go rd-go

# =============================================================================
# FINAL CHECKS
# =============================================================================

# Welcome message for tmux sessions
if [[ -n "$TMUX" ]]; then
    echo "🌟 Welcome back to tmux session: $(tmux display-message -p '#S')"
fi

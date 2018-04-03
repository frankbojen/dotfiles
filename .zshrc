# Frank Bojen

# Functions {{{
# =========
_has() {
    which $1>/dev/null 2>&1
}
# }}}

# Environment {{{
# ===========
# Set a cache dir.
export ZSH_CACHE_DIR=$HOME/.zsh/cache

# Ensure we're using the correct locale.
if grep ^en_GB.UTF-8 /etc/locale.gen 1>/dev/null; then
    export LANG=en_GB.UTF-8
elif grep ^en_US.UTF-8 /etc/locale.gen 1>/dev/null; then
    export LANG=en_US.UTF-8
fi

# 10ms for key sequences
export KEYTIMEOUT=1

# Ensure editor is Vim
export EDITOR=nvim

# Ensure Vim and others use 256 colours.
if [[ "$TERM" != "screen"* && "$TERM" != "tmux"* ]]; then
    export TERM=xterm-256color
fi

# Don't clear the screen when leaving man.
export MANPAGER='less -X'

# Enable persistent REPL history for node.
export NODE_REPL_HISTORY="$HOME/.node_history"

# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy'

# }}}

# History {{{
# =======
# Keep 10000000 lines of history within the shell and save it to ~/.zsh_history:
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt NO_SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
# }}}

# Path {{{
# ====
# In zsh, the $PATH variable is tied to the $path variable.
# This makes the $path variable act like a set.
typeset -U path

# Add our directories.
path=("$HOME/bin" $path)
path=("$HOME/.cargo/bin" $path)
path=("$HOME/.go/bin" $path)
path=("$HOME/.local/bin" $path)
path=("/opt/puppetlabs/bin" $path)
path=("$HOME/.fzf/bin" $path)
path=("$HOME/.gem/ruby/2.5.0/bin" $path)

# Using the (N-/) glob qualifier we can remove paths that do not exist.
path=($^path(N-/))
# }}}

# Completion {{{
# ==========
# Use modern completion system.
autoload -Uz compinit; compinit -i

# Add any completions.
#fpath+=~/.yadm/completions

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# tmuxinator completion.
#source ~/.yadm/completions/tmuxinator.zsh

# npm completion
if _has npm; then
    source <(npm completion)
fi
# }}}

# Aliases {{{
# =======
# Load our aliases.
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
# }}}

# antibody {{{
# =======
if _has antibody; then
    # If plugins have not been downloaded, then download and static load in future.
    if [[ ! -e "$HOME/.zsh_plugins.sh" ]]; then
        # Fetch plugins.
        antibody bundle < "$HOME/.antibody_bundle" > "$HOME/.zsh_plugins.sh"
    fi

    # Load plugins.
    source "$HOME/.zsh_plugins.sh"
fi
# }}}

# fzf {{{
# ===
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi
# }}}


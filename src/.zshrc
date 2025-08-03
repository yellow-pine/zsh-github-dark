# ----------------------------------------
# ⚡ Dev .zshrc (Optimized for macOS ARM + Homebrew Installs + GitHub Dark Terminal)
#
# Prerequisites (brew install):
#   brew install coreutils lsd bc pyenv nvm poetry
#
# Additional Manual Setup:
# 1. Set default shell to zsh for yourself (if not already):
#      chsh -s /bin/zsh
#
# 2. Set zsh as root's shell (to fix sudo su - being bash):
#      sudo chsh -s /bin/zsh root
#
# 3. Create NVM working directory (if missing):
#      mkdir -p ~/.nvm
#
# 4. Homebrew pyenv installs to ~/.pyenv; no further manual action needed.
#
# 5. Poetry installed via Homebrew; no virtualenv setup needed except optional:
#      export POETRY_VIRTUALENVS_IN_PROJECT=true
#
# This .zshrc includes:
#  - Dynamic prompt (timing, git branch, dirty state, error highlighting)
#  - lsd colorized directory listings
#  - Simplified LS_COLORS tuned for dev work (python, ts, html, config, archives, media)
#  - Full pyenv, nvm, and poetry integration
#  - Colors tuned for GitHub Dark Terminal Profile
# ----------------------------------------

# 🛠️ Core Setup
export PATH="/opt/homebrew/bin:$PATH"
if [ -d "/opt/homebrew/opt/coreutils/libexec/gnubin" ]; then
  export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
fi
zmodload zsh/datetime

# 📁 Better history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# 🖼️ LSD Aliases (Directory Listings)
alias ls='lsd --group-dirs=first --icon never'
alias ll='lsd -l --group-dirs=first --icon never'
alias la='lsd -la --group-dirs=first --icon never'
alias l='lsd --group-dirs=first --icon never'
alias dir='lsd --group-dirs=first --icon never'
alias vdir='lsd -l --group-dirs=first --icon never'

# ⚡ Dynamic Prompt Setup (timing, git, errors)
local RESET="%f%k"
local USER_COLOR_OK="%F{cyan}"
local USER_COLOR_FAIL="%F{1}" # soft red
local AT_COLOR="%F{default}"
local HOST_COLOR="%F{3}" # soft yellow
local DIR_COLOR="%F{green}"
local PROMPT_COLOR="%F{242}"
local BRANCH_COLOR="%F{5}" # soft purple
local TIME_COLOR="%F{blue}"

typeset -g __TIMER_START=0
typeset -g __TIMER_END=0
typeset -g __GIT_BRANCH=""
typeset -g __GIT_BRANCH_PWD=""

preexec() {
  __TIMER_START=$EPOCHREALTIME
  # Clear git cache if running a git command
  if [[ "$1" == git* ]]; then
    __GIT_BRANCH=""
    __GIT_BRANCH_PWD=""
  fi
}
precmd() {
  __TIMER_END=$EPOCHREALTIME
}

_git_branch() {
  # Use cached value if we're in the same directory
  if [[ "$PWD" == "$__GIT_BRANCH_PWD" && -n "$__GIT_BRANCH_PWD" ]]; then
    echo "$__GIT_BRANCH"
    return
  fi

  # Check if we're in a git repository
  if ! command git rev-parse --git-dir &>/dev/null; then
    __GIT_BRANCH=""
    __GIT_BRANCH_PWD=""
    return
  fi

  # Update cache
  __GIT_BRANCH_PWD="$PWD"

  local branch=$(command git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    if ! git diff --quiet --ignore-submodules HEAD 2>/dev/null; then
      __GIT_BRANCH="${branch}*"
    else
      __GIT_BRANCH="$branch"
    fi
  else
    __GIT_BRANCH=""
  fi

  echo "$__GIT_BRANCH"
}

build_prompt() {
  local EXIT=$?
  local USER_COLOR="$USER_COLOR_OK"

  if [[ $EXIT -ne 0 ]]; then
    USER_COLOR="$USER_COLOR_FAIL"
  fi

  if [[ $EUID -eq 0 ]]; then
    USER_COLOR="%F{red}%B"
    HOST_COLOR="%F{red}%B"
    DIR_COLOR="%F{red}%B"
  fi

  local TIME_DIFF=""
  if [[ -n $__TIMER_START && -n $__TIMER_END ]]; then
    if [[ $__TIMER_START != 0 && $__TIMER_END != 0 ]]; then
      # Use zsh's built-in floating point arithmetic
      local delta=$((__TIMER_END - __TIMER_START))
      if ((delta > 5)); then
        # Format to 2 decimal places
        local seconds=$(printf "%.2f" $delta)
        TIME_DIFF=" ${TIME_COLOR}(took ${seconds}s)"
      fi
    fi
  fi

  local BRANCH=$(_git_branch)
  if [[ -n $BRANCH ]]; then
    BRANCH=" ${BRANCH_COLOR}[$BRANCH]"
  fi

  PROMPT="${USER_COLOR}%n${AT_COLOR}@${HOST_COLOR}%m ${DIR_COLOR}%~${BRANCH}${TIME_DIFF}
${PROMPT_COLOR}%# ${RESET}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd build_prompt

# 🎨 LS_COLORS (Enhanced for Dev Workflow)
LS_COLORS='
di=38;5;33:
ln=38;5;44:
so=38;5;166:
pi=38;5;166:
ex=38;5;40:
bd=38;5;124:
cd=38;5;124:

*.zip=38;5;202:*.tar=38;5;202:*.gz=38;5;202:*.bz2=38;5;202:*.xz=38;5;202:*.7z=38;5;202:
*.jpg=38;5;213:*.jpeg=38;5;213:*.png=38;5;213:*.gif=38;5;213:*.webp=38;5;213:*.tiff=38;5;213:
*.mp4=38;5;141:*.mkv=38;5;141:*.avi=38;5;141:
*.mp3=38;5;137:*.flac=38;5;137:*.wav=38;5;137:
*.html=38;5;215:*.htm=38;5;215:
*.c=38;5;81:*.cpp=38;5;81:*.h=38;5;81:*.hpp=38;5;81:
*.py=38;5;41:*.ts=38;5;81:*.tsx=38;5;81:*.rs=38;5;81:*.go=38;5;81:*.java=38;5;81:*.sh=38;5;172:
*.json=38;5;178:*.yaml=38;5;178:*.yml=38;5;178:*.toml=38;5;178:*.ini=38;5;178:*.md=38;5;184:*.txt=38;5;253:*.pdf=38;5;141:*.po=38;5;180:*.lock=38;5;242:
'
export LS_COLORS

# 🐍 Python, Node, Poetry Integration (Homebrew paths)
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

if command -v poetry 1>/dev/null 2>&1; then
  export POETRY_VIRTUALENVS_IN_PROJECT=true
fi

# ⌨️ Key bindings
bindkey '^[[A' history-search-backward # Up arrow
bindkey '^[[B' history-search-forward  # Down arrow
bindkey '^R' history-incremental-search-backward

# 🧹 Final Touch
autoload -Uz compinit

# Speed up startup by skipping security checks on trusted systems
# Use -C flag if ZSH_DISABLE_COMPFIX is set (indicating a trusted environment)
if [[ -n "$ZSH_DISABLE_COMPFIX" ]]; then
  compinit -C
else
  compinit
fi

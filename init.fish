# Add cabal to PATH
set -x PATH "$HOME/.cabal/bin/" $PATH

# Add pyenv
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH "$PYENV_ROOT/bin" $PATH
status --is-interactive; and . (pyenv init -|psub)

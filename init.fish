# Disable creation of  python .pyc files
# https://docs.python.org/2/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE
set -gx PYTHONDONTWRITEBYTECODE 1

# Add pyenv
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH "$PYENV_ROOT/bin" $PATH
status --is-interactive; and . (pyenv init -|psub)

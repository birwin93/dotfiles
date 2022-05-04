if [[ $OSTYPE == darwin* ]]; then
  export OSX=true
fi

# Set the path to include:
#  - $HOME/.bin       for local tools
#  - $HOME/.local/bin for haskell tools installed by stack
#  - $HOME/.cargo/bin for rust tools installed by cargo
#  - $BREW_PREFIX/bin for Homebrew on Apple Silicon, or duplicates the /usr/local/bin path
#  - /usr/local/bin
#  - /usr/local/sbin
#  - /usr/bin         for system executables
#  - /usr/sbin
#  - /bin
#  - /sbin
export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/.cargo/bin:$BREW_PREFIX/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

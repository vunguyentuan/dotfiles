### Dotfiles

Install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install packages & apps with this cmd
```
brew bundle
```

In dotfiles dir, run 

```
stow --verbose --target=$HOME */
```

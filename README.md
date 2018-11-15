# Setup new machine
Install normal dev tools, git, vim, nvm, rvm, etc...

## Clone repo to home directory
```bash
cd ~
git clone git@github.com:bmb330/dotfiles.git
```

## Link to dotfiles
```bash
ln -s dotfiles/bashrc .bashrc
ln -s dotfiles/vimrc .vim/vimrc
```

## Sets up Git with your name
```bash
git config --global user.name "<Your-Full-Name>"
```

## Sets up Git with your email
```bash
git config --global user.email "<your-email-address>"
```

## Makes sure that Git output is colored
```bash
git config --global color.ui auto
```

## Displays the original state in a conflict
```bash
git config --global merge.conflictstyle diff3
```

## Set Git editor to vim
```bash
git config --global core.editor vim
```

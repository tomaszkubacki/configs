# My provision configuration

!!! TODO
- create just command for basic provision any machine for dev instead of pure files
- copy just necessary files (not all confis for neovim eg)
- create just command installing default software
- use imports


my various configs

## sway configuration

basic sway config with waybar
in .config/sway and .config/waybar

## vim configuration

vimrc_light - light version of vimrc used with Plug NerdTree

vimrc_ide - all from vimrc_light plus coc for rustlang developemnt (autocompletion)

## vim with plugins

1) Install Plug Vim 

Install instructions:
https://github.com/junegunn/vim-plug

2) Install nodejs and npm

nodejs is required by coc.nvim plugin used for autocompletion

3) copy .vimrc to home dir

4) afer vim open install plugins

invoke

```
:PlugInstall

```

### Additional color schemas

See installation instructions at:

https://github.com/flazz/vim-colorschemes/tree/master

## Rust setup

1) install rust
Instructions on rustlang website

### Install tools for Rust edit in Vim



1) install rust analyzer
rustup component add rust-analyzer

2) install coc-rust-analyzer

Assuming installed .vimrc from this repo and have vim plug installed,
open vim and invoke:

```
:CocInstall coc-rust-analyzer
```




# Configurations

My various configurations

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




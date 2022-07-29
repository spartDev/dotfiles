
# DOTFILES_DIR := $(shell echo $(HOME)/dotfiles)
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL        := /bin/sh
UNAME_M      := $(shell uname -m)
UNAME_S      := $(shell uname -s)
USER         := $(shell whoami)

BASE         := macos
BREWFILE     := macos/.Brewfile
BREW_PREFIX  := /usr/local

.PHONY: all install

all: install

install: $(BASE)
	@printf "Installation complete.\\n"

.PHONY: help usage
.SILENT: help usage

help: usage

usage:
	printf "\\n\
	\\033[1mDOTFILES\\033[0m\\n\
	\\n\
	Custom settings and configurations for Unix-like environments.\\n\
	See README.md for detailed usage information.\\n\
	\\n\
	\\033[1mUSAGE:\\033[0m make [target]\\n\
	\\n\
	  make         Install all configurations and applications.\\n\
	  make link    Symlink only Bash and Vim configurations to the home directory.\\n\
	  make unlink  Remove symlinks created by \`make link\`.\\n\
	\\n\
	"

.PHONY: macos link unlink

macos: sudo brew stow
	bash $(DOTFILES_DIR)/macos/defaults.sh
	$(BREW_PREFIX)/bin/stow macos
	echo $(BREW_PREFIX)/bin/bash | sudo tee -a /etc/shells
	chsh -s $(BREW_PREFIX)/bin/bash
	ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	softwareupdate -aiR

link:
	ln -fs $(DOTFILES_DIR)/shell/bash/.bash_profile $(HOME)/.bash_profile
	ln -fs $(DOTFILES_DIR)/shell/bash/.bashrc $(HOME)/.bashrc
	ln -fs $(DOTFILES_DIR)/shell/bash/.curlrc $(HOME)/.curlrc
	ln -fs $(DOTFILES_DIR)/shell/bash/.inputrc $(HOME)/.inputrc
	ln -fs $(DOTFILES_DIR)/shell/bash/.aliases $(HOME)/.aliases
	ln -fs $(DOTFILES_DIR)/shell/bash/.bash_functions $(HOME)/.bash_functions
	ln -fs $(DOTFILES_DIR)/shell/bash/.bash_prompt $(HOME)/.bash_prompt
	ln -fs $(DOTFILES_DIR)/shell/bash/.exports $(HOME)/.exports
	ln -fs $(DOTFILES_DIR)/editors/visual-studio-code/settings.json $(HOME)/Library/Application Support/Code/User/settings.json

unlink:
	unlink $(HOME)/.bash_profile
	unlink $(HOME)/.bashrc
	unlink $(HOME)/.curlrc
	unlink $(HOME)/.inputrc
	unlink $(HOME)/.aliases
	unlink $(HOME)/.bash_functions
	unlink $(HOME)/.bash_prompt
	unlink $(HOME)/.exports
	unlink $(HOME)/Library/Application Support/Code/User/settings.json
	@printf "\\033[32m✓\\033[0m Symlinks removed. Manually remove ~/dotfiles directory if needed.\\n"

.PHONY: brew stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

brew:
ifeq ($(shell which brew),)
	@printf "Homebrew not detected; running install script\\n"
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@printf "Homebrew already installed; skipping installation\\n"
endif
	$(BREW_PREFIX)/bin/brew bundle --file=$(DOTFILES_DIR)/$(BREWFILE)
	$(BREW_PREFIX)/bin/brew analytics off
  # for EXT in $$(cat $(DOTFILES_DIR)/editors/visual-studio-code/Codefile); do code --install-extension $$EXT; done

stow:
	[ -f ~/.bash_profile ] && [ ! -L ~/.bash_profile ] && mv ~/.bash_profile ~/.bash_profile.bak
	[ -f ~/.bashrc ] && [ ! -L ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
	$(BREW_PREFIX)/bin/stow bash
	$(BREW_PREFIX)/bin/stow git

# node-packages: npm
# 	eval $$(fnm env); npm install -g $(shell cat install/npmfile)

# restart:
# 	bash $(DOTFILES_DIR)/bin/restart.sh

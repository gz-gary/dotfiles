DOTFILES := .tmux.conf .vimrc .gitconfig .zshrc
PWD := $(shell pwd)

.PHONY: list clean install install-vim-plugins install-zsh-plugins

list: $(DOTFILES)
	@for file in $(DOTFILES); do \
		echo "$$file"; \
	done

clean: $(DOTFILES)
	@for file in $(DOTFILES); do \
		echo "Removing origin $(HOME)/$$file"; \
		rm -rf $(HOME)/$$file; \
	done
	
install: install-vim-plugins clean $(DOTFILES)
	@for file in $(DOTFILES); do \
		echo "Installing $(HOME)/$$file"; \
		ln -s "$(PWD)/$$file" "$(HOME)/$$file"; \
	done
	
install-vim-plugins:
	@echo "Installing vim plugins"
	@rm -rf "$(HOME)/.vim"
	@ln -s "$(PWD)/.vim" "$(HOME)/.vim"

install-ssh-client-config:
	@echo "Installing ssh configuration"
	@rm -rf "$(HOME)/.ssh/config"
	@ln -s "$(PWD)/.ssh/config" "$(HOME)/.ssh/config"
	
install-zsh-plugins:
	@echo "Installing zsh plugins"
	@ln -s "$(PWD)/.oh-my-zsh/plugins/zsh-autosuggestions" "$(HOME)/.oh-my-zsh/plugins/zsh-autosuggestions"
	@ln -s "$(PWD)/.oh-my-zsh/plugins/zsh-syntax-highlighting" "$(HOME)/.oh-my-zsh/plugins/zsh-syntax-highlighting"

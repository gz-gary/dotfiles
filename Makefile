DOTFILES := .tmux.conf .vimrc .gitconfig .zshrc
PWD := $(shell pwd)

.PHONY: list clean fetch-deps install install-vim-plugins install-zsh-plugins

list: $(DOTFILES)
	@for file in $(DOTFILES); do \
		echo "$$file"; \
	done

clean: $(DOTFILES)
	@for file in $(DOTFILES); do \
		echo "Removing origin $(HOME)/$$file"; \
		rm -rf $(HOME)/$$file; \
	done

fetch-deps:
	@echo "Cloning plugins..."
	@echo "Cloning Vim plugins..."
	@echo "Cloning nerdtree..."
	@cd .vim/pack/plugins/start && git clone https://github.com/preservim/nerdtree.git
	@echo "Cloning ctrlp..."
	@cd .vim/pack/plugins/start && git clone https://github.com/ctrlpvim/ctrlp.vim.git
	@echo "Cloning vim-airline..."
	@cd .vim/pack/plugins/start && git clone https://github.com/vim-airline/vim-airline.git
	@echo "Cloning gruvbox..."
	@cd .vim/pack/plugins/start && git clone https://github.com/morhetz/gruvbox
	@echo "Cloning zsh plugins..."
	@echo "Cloning zsh-syntax-highlighting..."
	@cd .oh-my-zsh/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	@echo "Cloning zsh-autosuggestions..."
	@cd .oh-my-zsh/plugins && git clone https://github.com/zsh-users/zsh-autosuggestions.git
	@echo "Completed!"

install-dotfiles-only: $(DOTFILES) clean
	@for file in $(DOTFILES); do \
		echo "Installing $(HOME)/$$file"; \
		ln -s "$(PWD)/$$file" "$(HOME)/$$file"; \
	done

install: $(DOTFILES) clean fetch-deps install-vim-plugins install-zsh-plugins
	@for file in $(DOTFILES); do \
		echo "Installing $(HOME)/$$file"; \
		ln -s "$(PWD)/$$file" "$(HOME)/$$file"; \
	done
	
install-vim-plugins:
	@echo "Installing vim plugins..."
	@rm -rf "$(HOME)/.vim"
	@ln -s "$(PWD)/.vim" "$(HOME)/.vim"
	@echo "Completed!"

install-ssh-client-config:
	@echo "Installing ssh configuration"
	@rm -rf "$(HOME)/.ssh/config"
	@ln -s "$(PWD)/.ssh/config" "$(HOME)/.ssh/config"
	
install-zsh-plugins:
	@echo "Installing zsh plugins..."
	@ln -s "$(PWD)/.oh-my-zsh/plugins/zsh-autosuggestions" "$(HOME)/.oh-my-zsh/plugins/zsh-autosuggestions"
	@ln -s "$(PWD)/.oh-my-zsh/plugins/zsh-syntax-highlighting" "$(HOME)/.oh-my-zsh/plugins/zsh-syntax-highlighting"
	@echo "Completed!"

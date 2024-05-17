DOTFILES := .tmux.conf .vimrc .gitconfig .zshrc
PWD := $(shell pwd)

.PHONY: list clean install

list: $(DOTFILES)
	@for file in $(DOTFILES); do \
		echo "$$file"; \
	done

clean: $(DOTFILES)
	@for file in $(DOTFILES); do \
		echo "Removing origin $(HOME)/$$file"; \
		rm -rf $(HOME)/$$file; \
	done
	
install: clean $(DOTFILES)
	@for file in $(DOTFILES); do \
		echo "Installing $(HOME)/$$file"; \
		ln -s "$(PWD)/$$file" "$(HOME)/$$file"; \
	done

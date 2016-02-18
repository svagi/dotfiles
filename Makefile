all: dotfiles

# Add symlinks for dotfiles
dotfiles:
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".git" -not -name ".DS_Store"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done

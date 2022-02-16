SRC = .bashrc .xinitrc .xsession .Xresources .Xkbmap
SCRIPTS = video-dl audio-dl

install: 
	$(foreach file,$(SRC),cp $(file) ~/$(file);)
	mkdir -p ~/.local/bin
	$(foreach file,$(SCRIPTS),cp $(file) ~/.local/bin/$(file);)

windows:
	cp windows.bashrc ~/.bashrc
	@echo If access to System32 is denied, execute the Makefile on an elevated shell.
	$(foreach file,$(SCRIPTS),cp $(file) C:/WINDOWS/system32/$(file);)

root:
	$(foreach file,$(SRC),sudo cp $(file) /root/$(file);)
	sudo mkdir -p /root/.local/bin
	$(foreach file,$(SCRIPTS),sudo cp $(file) /root/.local/bin/$(file);)

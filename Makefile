SRC = .bashrc .xinitrc .xsession .Xresources .Xkbmap

install: 
	$(foreach file,$(SRC),cp $(file) ~/$(file);)

windows:
	cp windows.bashrc ~/.bashrc

root:
	$(foreach file,$(SRC),sudo cp $(file) /root/$(file);)
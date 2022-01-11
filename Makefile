SRC = .bashrc .xinitrc .xsession .Xresources .Xkbmap

install: 
	$(foreach file,$(SRC),cp $(file) ~/$(file);)

root:
	$(foreach file,$(SRC),sudo cp $(file) /root/$(file);)
SRCFILES:=*.as info.toml

default:
	zip OnScreenImage.zip $(SRCFILES)
	mv OnScreenImage.zip OnScreenImage.op
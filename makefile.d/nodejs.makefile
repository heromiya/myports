node-v8.9.4.tar.xz:
#	wget https://nodejs.org/dist/v10.15.1/$@
	wget https://nodejs.org/dist/v8.9.4/$@

nodejs.installed: node-v8.9.4.tar.xz
	$(call compile)

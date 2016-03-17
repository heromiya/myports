dash-0.5.8.tar.gz:
	wget http://gondor.apana.org.au/~herbert/dash/files/$@
dash.installed: dash-0.5.8.tar.gz
	$(call compile)

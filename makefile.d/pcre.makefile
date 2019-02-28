pcre-$(pcre_ver).tar.bz2:
	wget -q http://ftp.pcre.org/pub/pcre/$@
pcre.installed: pcre-$(pcre_ver).tar.bz2
	$(call compile)

readline_ver = 6.0

readline-$(readline_ver).tar.gz:
	wget -q ftp://ftp.cwru.edu/pub/bash/$@
readline.installed: readline-$(readline_ver).tar.gz
	$(call compile,--disable-shared)

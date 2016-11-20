readline_ver = 6.3

readline-$(readline_ver).tar.gz:
	wget -q ftp://ftp.cwru.edu/pub/bash/$@
readline.installed lib/libreadline.a: readline-$(readline_ver).tar.gz
	$(call compile,--disable-shared)

readline_ver = 6.3

readline-$(readline_ver).tar.gz:
	wget -q ftp://ftp.cwru.edu/pub/bash/$@
lib/libreadline.a: readline-$(readline_ver).tar.gz ncurses.installed
	$(call compile,--disable-shared)

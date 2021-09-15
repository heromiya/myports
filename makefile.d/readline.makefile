readline-$(readline_ver).tar.gz:
	wget -q http://ftp.gnu.org/gnu/readline/$@
readline.installed: readline-$(readline_ver).tar.gz ncurses.installed
	$(call compile,--disable-shared)

ncurses_ver = 6.1
ncurses-$(ncurses_ver).tar.gz:
	wget -q http://ftp.gnu.org/gnu/ncurses/$@
ncurses.installed: ncurses-$(ncurses_ver).tar.gz
	$(call compile)

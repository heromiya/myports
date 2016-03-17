ncurses_ver = 6.0
ncurses-$(ncurses_ver).tar.gz:
	wget -q http://ftp.gnu.org/gnu/ncurses/$@
ncurses.installed lib/libncurses.a: ncurses-$(ncurses_ver).tar.gz
	$(call compile)

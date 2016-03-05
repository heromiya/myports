ncurses-6.0.tar.gz:
	wget -q http://ftp.gnu.org/gnu/ncurses/$@
ncurses.installed: ncurses-6.0.tar.gz
	$(call compile)

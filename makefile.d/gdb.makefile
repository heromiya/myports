gdb-7.11.tar.xz:
	wget -q  ftp://ftp.gnu.org/gnu/gdb/$@
gdb.installed: gdb-7.11.tar.xz
	$(call compile)

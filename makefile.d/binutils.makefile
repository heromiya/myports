binutils_ver = 2.25.1

binutils-$(binutils_ver).tar.bz2:
	wget -q  http://ftp.gnu.org/gnu/binutils/binutils-$(binutils_ver).tar.bz2 
binutils.installed: binutils-$(binutils_ver).tar.bz2
	$(call compile) && touch ../$@

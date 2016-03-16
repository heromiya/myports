sqlite_ver = 3110100
sqlite-autoconf-$(sqlite_ver).tar.gz:
	wget -nc -q  http://www.sqlite.org/2016/$@
libsqlite3.so sqlite.installed: sqlite-autoconf-$(sqlite_ver).tar.gz
	$(call compile,\
	CFLAGS="$(CFLAGS)   -I$(INSTALL_DIR)/glibc-2.15/include" \
	CXXFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include" \
	CPPFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include" \
	LDFLAGS="-L$(INSTALL_DIR)/glibc-2.15/lib -L$(INSTALL_DIR)/lib") && touch ../$@
#-static -static-libgcc -pthread
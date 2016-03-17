sqlite_ver = 3110100
sqlite-autoconf-$(sqlite_ver).tar.gz:
	wget -nc -q  http://www.sqlite.org/2016/$@
libsqlite3.so sqlite.installed: sqlite-autoconf-$(sqlite_ver).tar.gz
	$(call compile,\
	CFLAGS="$(CFLAGS)   -I$(INSTALL_DIR)/glibc-2.15/include" \
	CXXFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include" \
	CPPFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include" \
	LIBS="-static $(INSTALL_DIR)/glibc-2.15/lib/libc.a $(INSTALL_DIR)/glibc-2.15/lib/libpthread.a  $(INSTALL_DIR)/glibc-2.15/lib/libdl.a")

#	LDFLAGS="-L$(INSTALL_DIR)/glibc-2.15/lib $(LDFLAGS)" \
# -static -static-libgcc -pthread
#-static $(INSTALL_DIR)/glibc-2.15/lib/libm.a -static $(INSTALL_DIR)/glibc-2.15/lib/libc.a -static $(INSTALL_DIR)/glibc-2.15/lib/libdl.a -pthread

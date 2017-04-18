libxml2_ver = 2.9.3
libxml2-$(libxml2_ver).tar.gz:
	wget -nc -q  http://xmlsoft.org/sources/libxml2-$(libxml2_ver).tar.gz
libxml2.installed lib/libxml2.so: libxml2-$(libxml2_ver).tar.gz zlib.installed xz.installed
	$(call compile,LIBS="$(INSTALL_DIR)/lib/libz.a $(INSTALL_DIR)/lib/liblzma.a" CFLAGS="$(CFLAGS) -static")

#python.installed

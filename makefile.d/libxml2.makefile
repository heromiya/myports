libxml2_ver = 2.9.3
libxml2-$(libxml2_ver).tar.gz:
	wget -nc -q  http://xmlsoft.org/sources/libxml2-$(libxml2_ver).tar.gz
libxml2.installed lib/libxml2.so: libxml2-$(libxml2_ver).tar.gz zlib.installed
	$(call compile,LIBS=$(INSTALL_DIR)/lib/libz.a)

#python.installed
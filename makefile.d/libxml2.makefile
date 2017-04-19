libxml2_ver = 2.9.3
libxml2-$(libxml2_ver).tar.gz:
	wget -nc -q  http://xmlsoft.org/sources/libxml2-$(libxml2_ver).tar.gz
libxml2.installed: libxml2-$(libxml2_ver).tar.gz xz.installed zlib.installed
	$(call compile,--without-lzma --with-zlib=$(INSTALL_DIR) )
#	$(call compile,--with-lzma=$(INSTALL_DIR) --with-zlib=$(INSTALL_DIR) LZMA_CFLAGS="-L$(INSTALL_DIR)/lib -llzma -static" LZMA_LIBS="-L$(INSTALL_DIR)/lib -llzma"  )

#python.installed

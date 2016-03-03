tiff-4.0.6.tar.gz:
	wget http://download.osgeo.org/libtiff/$@
libtiff.installed: tiff-4.0.6.tar.gz
	$(call compile,\
	--with-zlib-include-dir=$(INSTALL_DIR)/include \
	--with-zlib-lib-dir=$(INSTALL_DIR)/lib \
	--with-jpeg-include-dir=$(INSTALL_DIR)/include \
	--with-jpeg-lib-dir=$(INSTALL_DIR)/lib \
	--with-lzma-include-dir=$(INSTALL_DIR)/include \
	--with-lzma-lib-dir=$(INSTALL_DIR)/lib)

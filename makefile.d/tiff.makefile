tiff_ver = 3.9.7
tiff-$(tiff_ver).tar.gz:
	wget -q  http://download.osgeo.org/libtiff/$@
tiff.installed: tiff-$(tiff_ver).tar.gz jpeg.installed
	$(call compile,\
	--with-zlib-include-dir=$(INSTALL_DIR)/include \
	--with-zlib-lib-dir=$(INSTALL_DIR)/lib \
	--with-jpeg-include-dir=$(INSTALL_DIR)/include \
	--with-jpeg-lib-dir=$(INSTALL_DIR)/lib \
	--with-lzma-include-dir=$(INSTALL_DIR)/include \
	--with-lzma-lib-dir=$(INSTALL_DIR)/lib)

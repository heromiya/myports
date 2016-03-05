boost_1_60_0.tar.gz:
	wget -q  --no-check-certificate http://sourceforge.net/projects/boost/files/boost/1.60.0/$@
boost.installed: boost_1_60_0.tar.gz bzip2.installed
	tar xaf $< && cd boost_1_60_0 && \
	./bootstrap.sh --prefix=$(INSTALL_DIR) && \
	./b2 --prefix=$(INSTALL_DIR) install && touch ../$@

#	echo "BZIP2_INCLUDE = $(INSTALL_DIR)/include ;" >> boost-build.jam && \
	echo "BZIP2_LIBPATH = $(INSTALL_DIR)/lib ;" >> boost-build.jam && \
	echo "ZLIB_INCLUDE = $(INSTALL_DIR)/include ;" >> boost-build.jam && \
	echo "ZLIB_LIBPATH = $(INSTALL_DIR)/lib ;" >> boost-build.jam && \

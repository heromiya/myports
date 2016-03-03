Python-2.6.9.tar.xz:
	wget --no-check-certificate https://www.python.org/ftp/python/2.6.9/$@

python-2.6.installed: Python-2.6.9.tar.xz
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=gcc-4.8 && \
	export CXX=g++-4.8 && \
	export CFLAGS="-fPIC" && \
	export CPPFLAGS="-fPIC" && \
	export LDFLAGS="-L/usr/lib" && \
	export LIBS="-lcrypto -lssl" && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	./configure --prefix=$(INSTALL_DIR) \
	--with-system-ffi 2>&1 | tee python-2.6.config.log && \
	$(MAKE) && $(MAKE) install && cd .. && touch $@
#	--enable-shared 

openssl-$(openssl_ver).tar.gz:
	wget -q  http://www.openssl.org/source/openssl-$(openssl_ver).tar.gz

openssl.installed: openssl-$(openssl_ver).tar.gz zlib.installed
	tar xaf  openssl-$(openssl_ver).tar.gz && \
	cd $(basename $(basename $<)) && \
	export CFLAG="$(CFLAGS) -L$(INSTALL_DIR)/lib" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS) -L$(CONDA_PREFIX)/lib -lz " && \
	./config --prefix=$(INSTALL_DIR) zlib shared && \
	make && make install && touch ../$@

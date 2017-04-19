openssl_ver = 1.0.2g
openssl-$(openssl_ver).tar.gz:
	wget -q  http://www.openssl.org/source/openssl-$(openssl_ver).tar.gz

openssl.installed: openssl-$(openssl_ver).tar.gz libz.so
	tar xaf  openssl-$(openssl_ver).tar.gz && \
	cd $(basename $(basename $<)) && \
	export CFLAG="$(CFLAGS) -L$(INSTALL_DIR)/lib" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS)" && \
	./config --prefix=$(INSTALL_DIR) zlib no-shared && \
	make && make install && touch ../$@

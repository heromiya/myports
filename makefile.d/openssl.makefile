openssl_ver = 1.0.2g
#openssl-$(openssl_ver).tar.gz:
libssl.so: libz.so
	wget -q  http://www.openssl.org/source/openssl-$(openssl_ver).tar.gz
	tar xaf  openssl-$(openssl_ver).tar.gz && \
	cd $(basename $(basename $<)) && \
	export CFLAG="$(CFLAGS) -L$(INSTALL_DIR)/lib" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS)" && \
	./config --prefix=$(INSTALL_DIR) zlib shared && \
	make && make install

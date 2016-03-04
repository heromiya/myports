openssl_ver = 1.0.2g
openssl-$(openssl_ver).tar.gz:
	wget http://www.openssl.org/source/$@
openssl.installed: openssl-$(openssl_ver).tar.gz zlib.installed
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CFLAG="$(CFLAGS) -L$(INSTALL_DIR)/lib" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS)" && \
	./Configure linux-x86_64 shared zlib -L$(INSTALL_DIR)/lib --prefix=$(INSTALL_DIR) && \
	make && make install && cd .. && touch $@

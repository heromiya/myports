openssl_ver = 1.0.2g
openssl-$(openssl_ver).tar.gz:
	wget -q  http://www.openssl.org/source/$@
openssl.installed: openssl-$(openssl_ver).tar.gz zlib.installed
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CFLAG="$(CFLAGS) -L$(INSTALL_DIR)/lib" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS)" && \
	./config --prefix=$(INSTALL_DIR) zlib shared && \
	make && make install && cd .. && touch $@

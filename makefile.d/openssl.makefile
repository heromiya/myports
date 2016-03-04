openssl_ver = 1.0.2g
openssl-$(openssl_ver).tar.gz:
	wget http://www.openssl.org/source/$@
openssl.installed: openssl-$(openssl_ver).tar.gz
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CFLAGS="$(CFLAGS)" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	./Configure linux-x86_64 shared zlib --prefix=$(INSTALL_DIR) && \
	make && make install && cd .. && touch $@

readline-6.3.tar.gz:
	wget ftp://ftp.cwru.edu/pub/bash/readline-6.3.tar.gz
readline.installed: readline-6.3.tar.gz
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=gcc-4.8 && \
	export CXX=g++ && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	export LDFLAGS="$(LDFLAGS)" && \
	export CFLAGS="$(CFLAGS)" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export F77=gfortran && \
	export FFLAGS="$(CFLAGS)" && \
	./configure --prefix=$(INSTALL_DIR) --disable-shared && \
	$(MAKE) $(LIBTOOL) && \
	$(MAKE) install && cd .. && touch $@

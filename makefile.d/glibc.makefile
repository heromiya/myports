glibc_ver = 2.15
glibc-$(glibc_ver).tar.gz:
	wget http://ftp.gnu.org/gnu/glibc/glibc-$(glibc_ver).tar.gz
glibc.installed: glibc-$(glibc_ver).tar.gz
	tar xaf $< && \
	cd glibc-$(glibc_ver) && \
	mkdir -p build && cd build && \
	export CFLAGS="-O2 $(CFLAGS)" && export CXXFLAGS="-O2 $(CFLAGS)" && export CPPFLAGS="-O2 $(CFLAGS)" && export LDFLAGS="$(LDFLAGS)" && export FFLAGS="-O2 $(CFLAGS)" && \
	../configure --enable-static --prefix=$(INSTALL_DIR)/glibc-$(glibc_ver) && \
	make && make install && touch ../../$@

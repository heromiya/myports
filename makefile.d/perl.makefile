perl_ver = 5.22.1

perl-$(perl_ver).tar.gz:
	wget -q -nc http://www.cpan.org/src/5.0/$@
perl.installed: perl-$(perl_ver).tar.gz
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=gcc && \
	export CXX=g++ && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	export LDFLAGS="$(LDFLAGS)" && \
	export CFLAGS="$(CFLAGS)" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export F77=gfortran && \
	export FFLAGS="$(CFLAGS)" && \
	./configure.gnu --prefix=$(INSTALL_DIR) $1 && \
	$(MAKE) uninstall; $(MAKE) $(LIBTOOL) &&  $(MAKE) install && cd .. && touch $@

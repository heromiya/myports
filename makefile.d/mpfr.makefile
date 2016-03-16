mpfr_ver = 3.1.3

mpfr-$(mpfr_ver).tar.bz2:
	wget -q  http://www.mpfr.org/mpfr-$(mpfr_ver)/mpfr-$(mpfr_ver).tar.bz2
mpfr.installed: mpfr-$(mpfr_ver).tar.bz2
	$(call compile,--enable-shared)

#	tar xaf $< && cd $(basename $(basename $<)) && ./configure --prefix=$(INSTALL_DIR) --with-mpfr=$(INSTALL_DIR) --with-gmp=$(INSTALL_DIR) CC=/usr/bin/gcc && $(MAKE) uninstall; $(MAKE) $(LIBTOOL) && $(MAKE) install && cd .. && touch $@

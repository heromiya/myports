tar_ver =  1.28

tar-$(tar_ver).tar.gz:
	wget -q  http://ftp.gnu.org/gnu/tar/$@
tar.installed: tar-$(tar_ver).tar.gz
	tar xzf $< && \
	cd $(basename $(basename $<)) && \
	./configure -q -C --prefix=$(INSTALL_DIR) && \
	$(MAKE) uninstall; $(MAKE) && $(MAKE) install && cd .. && touch $@

#	PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig:$(INSTALL_DIR)/share/pkgconfig \
#	LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64" \
#	CFLAGS="$(CFLAGS)" \
#	CXXFLAGS="$(CFLAGS)" \
#	CPPFLAGS="$(CFLAGS)" \
#	F77=gfortran \
#	FFLAGS="$(CFLAGS)" \

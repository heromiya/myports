
xz-$(xz_ver).tar.bz2:
	wget $(wget_opt) http://tukaani.org/xz/$@
xz.installed: xz-$(xz_ver).tar.bz2
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	./configure --prefix=$(INSTALL_DIR) && $(MAKE) uninstall; $(MAKE) && $(MAKE) install && touch ../$@

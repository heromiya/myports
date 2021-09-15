wine_ver = 1.7.55

wine-$(wine_ver).tar.bz2:
	wget -q https://dl.winehq.org/wine/source/1.7/$@
wine.installed: wine-$(wine_ver).tar.bz2 libpng.installed
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	./configure --prefix=$(INSTALL_DIR) --with-png --without-x --without-freetype && $(MAKE) uninstall; $(MAKE) && $(MAKE) install && touch ../$@
#	export PNG_CFLAGS="-L$(INSTALL_DIR)/lib -lpng" && \
	export PNG_LIBS="-L$(INSTALL_DIR)/lib -lpng" && \

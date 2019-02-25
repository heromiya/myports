wine_ver = 1.7.55

wine-$(wine_ver).tar.bz2:
	wget -q https://dl.winehq.org/wine/source/1.7/$@
wine.installed: wine-$(wine_ver).tar.bz2
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	./configure --prefix=$(INSTALL_DIR)  --without-x --without-freetype  && $(MAKE) uninstall; $(MAKE) && $(MAKE) install && touch ../$@

jpeg_ver = 9b

jpegsrc.v$(jpeg_ver).tar.gz:
	wget http://www.ijg.org/files/jpegsrc.v$(jpeg_ver).tar.gz
jpeg.installed: jpegsrc.v$(jpeg_ver).tar.gz
	tar xaf $< && cd jpeg-$(jpeg_ver) && ./configure --prefix=$(INSTALL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" && make && make install && cd .. && touch $@

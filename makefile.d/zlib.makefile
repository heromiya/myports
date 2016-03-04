zlib_ver = 1.2.8
zlib-$(zlib_ver).tar.gz:
	wget http://zlib.net/zlib-$(zlib_ver).tar.gz
zlib.installed: zlib-$(zlib_ver).tar.gz
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	./configure --prefix=$(INSTALL_DIR) && \
	make && make install && cd .. && touch $@


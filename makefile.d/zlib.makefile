zlib_ver = 1.2.8
zlib-$(zlib_ver).tar.gz:
	wget -N -q  http://zlib.net/zlib-$(zlib_ver).tar.gz
zlib.installed libz.so: zlib-$(zlib_ver).tar.gz
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	cmake -G "Unix Makefiles" \
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_C_FLAGS="-fPIC -I$(INSTALL_DIR)/include" \
	-DCMAKE_CXX_FLAGS="-fPIC -I$(INSTALL_DIR)/include" . && \
	$(MAKE) && $(MAKE) install && touch ../$@

#	./configure --prefix=$(INSTALL_DIR) && 

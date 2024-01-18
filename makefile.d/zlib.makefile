zlib-$(zlib_ver).tar.gz:
	wget -N $(wget_opt)  http://zlib.net/zlib-$(zlib_ver).tar.gz
zlib.installed: zlib-$(zlib_ver).tar.gz
	tar xaf $< && \
	export CFLAGS="$(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS)" && \
	cd $(basename $(basename $<)) && \
	./configure --prefix=$(INSTALL_DIR) && \
	$(MAKE) && $(MAKE) install && touch ../$@
#tar xaf $< && cd zlib-$(zlib_ver) && \
	$(call cmake)

#	$(call compile)
#	cmake -G "Unix Makefiles" \
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_C_FLAGS="-fPIC -I$(INSTALL_DIR)/include" \
	-DCMAKE_CXX_FLAGS="-fPIC -I$(INSTALL_DIR)/include" . && \


# && 

# python.installed
geos-$(geos_ver).tar.bz2:
	wget -q  http://download.osgeo.org/geos/geos-$(geos_ver).tar.bz2
geos.installed: geos-$(geos_ver).tar.bz2 proj4.installed
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	./configure --prefix=$(INSTALL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"  && $(MAKE) uninstall; $(MAKE) && $(MAKE) install && touch ../$@

# --enable-shared 
#	tar xaf $< && cd geos-$(geos_ver) && $(call cmake,\
	-DCMAKE_C_COMPILER=/usr/bin/gcc \
	-DCMAKE_CXX_COMPILER=/usr/bin/g++ \
	) && touch ../../$

#	$(call compile,--enable-static --enable-shared LDFLAGS=-L$(INSTALL_DIR)/lib LIBS="-lgeos -lgeos_c")

#	-DCMAKE_SHARED_LINKER_FLAGS="/usr/lib/gcc/i586-linux-gnu/4.8/libstdc++.a" 
#	-DCMAKE_STATIC_LINKER_FLAGS="/usr/lib/gcc/i586-linux-gnu/4.8/libstdc++.a" 

#	$(call compile,--enable-static \
	LIBS="-static $(INSTALL_DIR)/lib64/libstdc++.a $(INSTALL_DIR)/lib/libproj.a $(INSTALL_DIR)/lib/libsqlite3.a $(INSTALL_DIR)/glibc-2.15/lib/libpthread.a $(INSTALL_DIR)/glibc-2.15/lib/libdl.a $(INSTALL_DIR)/glibc-2.15/lib/libc.a")
# --enable-python
#	LIBS="$(INSTALL_DIR)/lib64/libstdc++.a")


#	

GLIBCINC= -I$(INSTALL_DIR)/glibc-2.15/include
libspatialite-$(libspatialite_ver).tar.gz:
	wget -q  http://www.gaia-gis.it/gaia-sins/libspatialite-sources/$@
libspatialite.installed: libspatialite-$(libspatialite_ver).tar.gz libsqlite3.so freexl.installed geos.installed # zlib.installed
	rm -rf $(INSTALL_DIR)/lib/libspatialite.* $(INSTALL_DIR)/include/spatialite $(INSTALL_DIR)/include/spatialite.h
	$(call compile,\
	--with-geosconfig=$(INSTALL_DIR)/bin/geos-config \
	--disable-examples --disable-freexl LIBXML2_LIBS="-lxml2" \
	CC=gcc \
	CXX=g++ \
	LIBXML2_CFLAGS="-I$(INSTALL_DIR)/include/libxml2 -I$(CONDA_PREFIX)/include/libxml2 -I/usr/include/libxml2 $(LDFLAGS)" \
	CFLAGS="   $(CFLAGS) -I$(INSTALL_DIR)/include/geos " \
	CXXFLAGS=" $(CFLAGS) -I$(INSTALL_DIR)/include/geos " \
	CPPFLAGS=" $(CFLAGS) -I$(INSTALL_DIR)/include/geos " \
	LDFLAGS=" -L$(INSTALL_DIR)/lib $(LDFLAGS) " \
	SQLITE3_CFLAGS=" $(CFLAGS) $(LDFLAGS) " \
    SQLITE3_LIBS="   $(CFLAGS) $(LDFLAGS) " \
    )

#   LIBS="-lproj -lsqlite3 -ldl -lgeos -lgeos_c -lc -lpthread -lm"  
#	LDFLAGS=" -lproj -lsqlite3 -ldl" 
#   -static -pthread  -lpthread  -lpthread -L$(INSTALL_DIR)/glibc-2.15/lib
#$(INSTALL_DIR)/glibc-2.15/lib/libc.a 

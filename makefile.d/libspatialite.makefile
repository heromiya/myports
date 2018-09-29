GLIBCINC= -I$(INSTALL_DIR)/glibc-2.15/include
libspatialite-$(libspatialite_ver).tar.gz:
	wget -q  http://www.gaia-gis.it/gaia-sins/libspatialite-sources/$@
libspatialite.installed: libspatialite-$(libspatialite_ver).tar.gz libsqlite3.so freexl.installed geos.installed
	rm -rf $(INSTALL_DIR)/lib/libspatialite.* $(INSTALL_DIR)/include/spatialite $(INSTALL_DIR)/include/spatialite.h
	$(call compile,\
	--with-geosconfig=$(INSTALL_DIR)/bin/geos-config \
	--disable-examples LIBXML2_LIBS="-lxml2" \
	CC=gcc \
	CXX=g++ \
	LIBXML2_CFLAGS="-I$(INSTALL_DIR)/include/libxml2 -I/usr/include/libxml2" \
	CFLAGS=" $(CFLAGS)   -std=gnu99 -I$(INSTALL_DIR)/include/geos" \
	CXXFLAGS=" $(CFLAGS) -std=gnu99  -I$(INSTALL_DIR)/include/geos" \
	CPPFLAGS=" $(CFLAGS) -std=gnu99  -I$(INSTALL_DIR)/include/geos" \
	LDFLAGS="-L$(INSTALL_DIR)/lib" \
	LIBS="-lproj -lsqlite3 -ldl -lgeos -lgeos_c -lc -lpthread -lm")

#    
#	LDFLAGS=" -lproj -lsqlite3 -ldl" \
#   -static -pthread  -lpthread  -lpthread -L$(INSTALL_DIR)/glibc-2.15/lib
#$(INSTALL_DIR)/glibc-2.15/lib/libc.a 

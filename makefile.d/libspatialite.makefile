libspatialite_ver = 4.3.0a
libspatialite-$(libspatialite_ver).tar.gz:
	wget -q  http://www.gaia-gis.it/gaia-sins/libspatialite-sources/$@
libspatialite.installed: libspatialite-$(libspatialite_ver).tar.gz libsqlite3.so freexl.installed geos.installed
	rm -rf $(INSTALL_DIR)/lib/libspatialite.* $(INSTALL_DIR)/include/spatialite $(INSTALL_DIR)/include/spatialite.h
	$(call compile,\
	--with-geosconfig=$(INSTALL_DIR)/bin/geos-config \
	--disable-examples LIBXML2_LIBS="-lxml2" \
	LIBXML2_CFLAGS="-I$(INSTALL_DIR)/include/libxml2 -I/usr/include/libxml2 -L$(INSTALL_DIR)/lib -lxml2" \
	CFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include -I$(INSTALL_DIR)/include/geos" \
	CXXFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include -I$(INSTALL_DIR)/include/geos" \
	CPPFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include -I$(INSTALL_DIR)/include/geos" \
	LDFLAGS="-L$(INSTALL_DIR)/lib -lproj -lsqlite3 -ldl" LIBS="-lproj -lsqlite3 -ldl")

#   -static -pthread  -lpthread  -lpthread -L$(INSTALL_DIR)/glibc-2.15/lib
#$(INSTALL_DIR)/glibc-2.15/lib/libc.a 
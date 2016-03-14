libspatialite_ver = 4.3.0
libspatialite-$(libspatialite_ver).tar.gz:
	wget -q  http://www.gaia-gis.it/gaia-sins/libspatialite-sources/$@
libspatialite.installed: libspatialite-$(libspatialite_ver).tar.gz sqlite.installed freexl.installed geos.installed
	rm -rf $(INSTALL_DIR)/lib/libspatialite.* $(INSTALL_DIR)/include/spatialite $(INSTALL_DIR)/include/spatialite.h
	$(call compile,\
	--with-geosconfig=$(INSTALL_DIR)/bin/geos-config \
	--disable-examples LIBXML2_LIBS="-lxml2" \
	LIBXML2_CFLAGS="-I$(INSTALL_DIR)/include/libxml2 -L$(INSTALL_DIR)/lib -lxml2" \
	CFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/geos" \
	CXXFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/geos" \
	CPPFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/geos" \
	LDFLAGS="$(LDFLAGS)"\
	LIBS="-lsqlite3")

#--disable-mathsql 

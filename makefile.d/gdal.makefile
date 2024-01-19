gdal_ver = 3.8.3

gdal-$(gdal_ver).tar.gz:
	wget -q  http://download.osgeo.org/gdal/$(gdal_ver)/$@
gdal.installed: gdal-$(gdal_ver).tar.gz sqlite.installed expat.installed proj4.installed geos.installed openjpeg.installed libspatialite.installed curl.installed freexl.installed pcre.installed epsilon.installed postgresql.installed tiff.installed xz.installed hdf5.installed libspatialite.installed libiconv.installed proj4.installed
	tar xa --skip-old-files -f $< && cd $(basename $(basename $<)) && \
    $(call cmake, \
    -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
    -DGDAL_BUILD_OPTIONAL_DRIVERS=OFF -DOGR_BUILD_OPTIONAL_DRIVERS=OFF \
    -DGDAL_USE_INTERNAL_LIBS=WHEN_NO_EXTERNAL \
    -DGDAL_USE_LIBKML=ON \
    -DGDAL_ENABLE_DRIVER_JPEG=ON \
    -DGDAL_ENABLE_DRIVER_PNG=ON \
    -DGDAL_USE_GEOTIFF_INTERNAL=OFF \
    -DGDAL_USE_TIFF_INTERNAL=OFF \
    -DOGR_ENABLE_DRIVER_KML=ON \
    -DOGR_ENABLE_DRIVER_LIBKML=ON \
    -DOGR_ENABLE_DRIVER_GML=ON \
    -DOGR_ENABLE_DRIVER_SQLITE=ON \
    -DOGR_ENABLE_DRIVER_GPKG=ON \
    -DPROJ_DIR=$(INSTALL_DIR)/lib/cmake/proj \
    -DACCEPT_MISSING_SQLITE3_MUTEX_ALLOC:BOOL=ON \
    -DACCEPT_MISSING_SQLITE3_RTREE:BOOL=ON \
    -DCMAKE_SHARED_LINKER_FLAGS="$(LDFLAGS) -L$(INSTALL_DIR)/lib" \
    -DCMAKE_C_FLAGS="$(CFLAGS) -L$(INSTALL_DIR)/lib" \
    -DCMAKE_CXX_FLAGS="$(CFLAGS) -L$(INSTALL_DIR)/lib" \
    -DSPATIALITE_INCLUDE_DIR=$(INSTALL_DIR)/include \
    -DSPATIALITE_LIBRARY=$(INSTALL_DIR)/lib/libspatialite.so \
    -DSQLite3_INCLUDE_DIR=$(INSTALL_DIR)/include \
    -DSQLite3_LIBRARY=$(INSTALL_DIR)/lib/libsqlite3.so \
    -DOPENSSL_CRYPTO_LIBRARY=$(INSTALL_DIR)/lib/libcrypto.so \
    -DOPENSSL_INCLUDE_DIR=$(INSTALL_DIR)/include \
    -DOPENSSL_SSL_LIBRARY=$(INSTALL_DIR)/lib/libssl.so \
    -DIconv_INCLUDE_DIR=$(INSTALL_DIR)/include \
    -DIconv_CHARSET_LIBRARY=$(INSTALL_DIR)/lib/libcharset.so \
    -DIconv_LIBRARY=$(INSTALL_DIR)/lib/libiconv.so \
    )

#.. && $(MAKE) && $(MAKE) install && touch ../../$@

# hdf4.shared.installed 
# libkml.installed  python.installed libxml2.installed 
# tar xaf $< &&  libgeotiff.installed
#     mkdir -p build && cd build && cmake -G "Unix Makefiles" \

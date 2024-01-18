# hdf4.shared.installed 
gdal-$(gdal_ver).tar.gz:
	wget -q  http://download.osgeo.org/gdal/$(gdal_ver)/$@
# libkml.installed  python.installed libxml2.installed 
# tar xaf $< &&  libgeotiff.installed
gdal.installed: gdal-$(gdal_ver).tar.gz sqlite.installed expat.installed proj4.installed geos.installed openjpeg.installed libspatialite.installed curl.installed freexl.installed pcre.installed epsilon.installed postgresql.installed tiff.installed xz.installed hdf5.installed libspatialite.installed libiconv.installed proj4.installed
	cd $(basename $(basename $<)) && $(call cmake,\
	-DGDAL_USE_GEOTIFF_INTERNAL=ON \
    -DGDAL_USE_GIF_INTERNAL=ON \
    -DGDAL_USE_JPEG12_INTERNAL=ON \
    -DGDAL_USE_JPEG_INTERNAL=ON \
    -DGDAL_USE_JSONC_INTERNAL=ON \
    -DGDAL_USE_LERC_INTERNAL=ON \
    -DGDAL_USE_PNG_INTERNAL=ON \
    -DGDAL_USE_TIFF_INTERNAL=ON \
    -DGDAL_USE_ZLIB_INTERNAL=ON \
    -DGDAL_ENABLE_DRIVER_KEA=OFF \
    -DGDAL_ENABLE_DRIVER_HDF4=OFF \
    -DOGR_ENABLE_DRIVER_GMLAS=OFF \
    -DOGR_ENABLE_DRIVER_NAS=OFF \
    -DGDAL_ENABLE_DRIVER_PDF=OFF \
    -DGDAL_ENABLE_DRIVER_KMLSUPEROVERLAY=OFF \
    -DGDAL_USE_LIBKML=OFF \
    -DOGR_ENABLE_DRIVER_KML=OFF \
    -DOGR_ENABLE_DRIVER_LIBKML=OFF \
    -DGDAL_ENABLE_DRIVER_NETCDF=OFF \
    -DOGR_ENABLE_DRIVER_ILI=OFF \
    -DGDAL_USE_XERCESC=OFF \
    -DGDAL_ENABLE_DRIVER_TILEDB=OFF \
    -DGDAL_ENABLE_DRIVER_RASTERLITE=OFF \
    -DPROJ_DIR=$(INSTALL_DIR)/lib/cmake/proj \
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

#$(call compile,\
	--with-pg=$(INSTALL_DIR)/bin/pg_config \
	--with-proj4=$(INSTALL_DIR)/lib \
	--with-geos=$(INSTALL_DIR)/bin/geos-config \
	--with-python \
	--with-hdf4=$(INSTALL_DIR) \
	--with-expat=$(INSTALL_DIR) \
	--with-openjpeg=$(INSTALL_DIR) \
	--with-liblzma \
	--with-curl=$(INSTALL_DIR)/bin \
	--with-freexl=$(INSTALL_DIR) \
	--with-libkml=$(INSTALL_DIR) \
	--with-xml2 \
	--with-jpeg=internal \
	--with-gif=internal \
	--with-libz=internal \
	--with-png=internal \
	--with-spatialite=$(INSTALL_DIR) \
	--with-sqlite3=$(INSTALL_DIR) \
	--with-hdf4 \
	--with-hdf5 \
	--with-libtiff=internal \
	--with-geotiff=internal \
	--without-jasper \
	--without-pcraster \
	--without-pcidsk \
	--without-libgrass \
	--without-epsilon \
	--without-grass \
	--without-ecw \
	--without-netcdf \
	--without-poppler \
	--without-podofo \
	CFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/libxml2" \
	CXXFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/libxml2" \
	CPPFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/libxml2" \
	LDFLAGS="-L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib" \
	LIBS="-lgeos -lstdc++ -lproj -lm -lsqlite3 -lxml2 -lz -lfreexl -lm -lgeos_c -llzma" \
	) && \
	mkdir -p $(INSTALL_DIR)/include/gdal && \
	cd $(INSTALL_DIR)/include/gdal && \
	ls ../gdal*.h | xargs -n 1 ln -sf && \
	ls ../ogr*.h | xargs -n 1 ln -sf && \
	ls ../cpl*.h | xargs -n 1 ln -sf

#	LIBS="-static $(INSTALL_DIR)/lib/libgeos_c.a $(INSTALL_DIR)/lib/libgeos.a $(INSTALL_DIR)/lib64/libstdc++.a $(INSTALL_DIR)/lib/libproj.a $(INSTALL_DIR)/glibc-2.15/lib/libm.a $(INSTALL_DIR)/lib/libsqlite3.a $(INSTALL_DIR)/lib/libxml2.a $(INSTALL_DIR)/lib/libz.a $(INSTALL_DIR)/lib/libfreexl.a $(INSTALL_DIR)/glibc-2.15/lib/libm.a $(INSTALL_DIR)/lib/libgeos_c.a $(INSTALL_DIR)/lib/liblzma.a $(INSTALL_DIR)/glibc-2.15/lib/libpthread.a $(INSTALL_DIR)/glibc-2.15/lib/libdl.a $(INSTALL_DIR)/glibc-2.15/lib/libc.a")
#$(INSTALL_DIR)/lib/libz.so.1 $(INSTALL_DIR)/glibc-2.15/lib/libc-2.15.so
#	--with-libtiff=$(INSTALL_DIR) \
#	--with-geotiff=$(INSTALL_DIR) \
#	LDFLAGS="$(LDFLAGS)" \
#	LIBS="-lc  -lcrypto -lpthread -ldl" \
#	LDFLAGS="$(LDFLAGS) -L$(INSTALL_DIR)/lib $(INSTALL_DIR)/lib/libspatialite.so  -L/dias/users/miyazaki.h.u-tokyo/apps/lib -lxml2 $(INSTALL_DIR)/lib/libxml2.so  $(INSTALL_DIR)/lib/libxml2.a -lsqlite3" 
#$(INSTALL_DIR)/lib/libsqlite3.so
# $(INSTALL_DIR)/lib/libsqlite3.a $(INSTALL_DIR)/lib/libgeos.a $(INSTALL_DIR)/lib64/libstdc++.a $(INSTALL_DIR)/lib/libspatialite.a
#-L$(INSTALL_DIR)/lib -lsqlite3 -L$(INSTALL_DIR)/lib  -l $(INSTALL_DIR)/lib/libspatialite.so
#	rm -rf $(INSTALL_DIR)/include/gdal*.h $(INSTALL_DIR)/include/ogr_*.h $(INSTALL_DIR)/include/cpl_*.h $(INSTALL_DIR)/include/gdal*.h $(INSTALL_DIR)/include/ogrsf_frmts.h $(INSTALL_DIR)/lib/libgdal* 

libLAS-1.8.0.tar.bz2:
	wget http://download.osgeo.org/liblas/$@
#liblas.installed: libLAS-1.8.0.tar.bz2
#	$(call compile)

#liblas:
#	git clone git://github.com/libLAS/libLAS.git liblas
liblas.installed: libLAS-1.8.0 laszip.installed proj4.installed gdal.installed
	cd $< && $(call cmake,\
	-DWITH_LASZIP=ON \
	-DWITH_GDAL=ON \
	-DWITH_GEOTIFF=ON \
	-DWITH_PKGCONFIG=ON \
	-DLASzip_DIR=$(INSTALL_DIR) \
	-DLASZIP_INCLUDE_DIR=$(INSTALL_DIR)/include \
	-DTIFF_DIR=$(INSTALL_DIR) \
	-DTIFF_INCLUDE_DIR=$(INSTALL_DIR)/include \
	-DZLIB_DIR=$(INSTALL_DIR))

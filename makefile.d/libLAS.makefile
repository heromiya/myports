#libLAS-1.8.0.tar.bz2:
#	wget http://download.osgeo.org/liblas/$@
liblas:
	git clone git://github.com/libLAS/libLAS.git liblas
liblas.installed: liblas laszip.installed proj4.installed
	cd liblas && $(call cmake,-DWITH_LASZIP=ON -DWITH_GDAL=OFF -DWITH_GEOTIFF=OFF)

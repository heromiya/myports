libgeotiff-1.4.1.tar.gz:
	wget http://download.osgeo.org/geotiff/libgeotiff/libgeotiff-1.4.1.tar.gz
libgeotiff.installed: libgeotiff-1.4.1.tar.gz jpeg.installed zlib.installed proj.installed tiff.installed
	$(call compile,\
	--with-proj=$(INSTALL_DIR) \
	--with-zlib \
	--with-jpeg=$(INSTALL_DIR) \
	--with-libtiff=$(INSTALL_DIR))

#LIBS="-L/home/heromiya/apps/lib -lproj -L/home/heromiya/apps/lib -ljpeg -lz -lm -L/home/heromiya/apps/lib -ltiff"

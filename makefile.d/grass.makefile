grass-$(grass_ver).tar.gz:
	wget -q  http://grass.osgeo.org/grass78/source/grass-$(grass_ver).tar.gz
grass.installed: grass-$(grass_ver).tar.gz gdal.installed postgresql.installed sqlite.installed fftw.installed geos.installed proj4.installed
	$(call compile, \
	--with-cxx \
	--with-postgres \
	--with-sqlite \
	--with-blas \
	--with-lapack \
	--with-fftw \
	--with-fftw-includes=$(INSTALL_DIR)/include \
	--with-fftw-libs=$(INSTALL_DIR)/lib \
	--with-geos \
	--with-cairo \
	--with-gdal=$(INSTALL_DIR)/bin/gdal-config \
	--with-proj-includes=$(INSTALL_DIR)/include \
	--with-proj-libs=$(INSTALL_DIR)/lib \
	--with-proj-share=$(INSTALL_DIR)/share/proj \
	--with-postgres-includes=$(INSTALL_DIR)/include \
	--with-postgres-libs=$(INSTALL_DIR)/lib \
	--without-tcltk \
	--without-wxwidgets \
	--enable-largefile \
	--with-python \
	--without-wxwidgets \
	CC=/usr/bin/gcc \
	CXX=/usr/bin/g++)

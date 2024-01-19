grass-$(grass_ver).tar.gz:
	wget -q  http://grass.osgeo.org/grass78/source/grass-$(grass_ver).tar.gz

# First configure, then edit include/Make/Compile.make to add "-L$(HOME)/apps/lib -liconv" to the function "linker"
grass.installed: grass-$(grass_ver).tar.gz gdal.installed postgresql.installed sqlite.installed fftw.installed geos.installed proj4.installed
	$(call compile, \
    --with-libs=$(INSTALL_DIR)/lib \
	--with-cxx \
	--with-postgres \
	--with-sqlite \
	--with-blas \
	--with-lapack \
	--with-fftw \
	--with-fftw-includes=$(INSTALL_DIR)/include \
	--with-fftw-libs=$(INSTALL_DIR)/lib \
	--with-geos \
	--without-cairo \
	--with-gdal=$(INSTALL_DIR)/bin/gdal-config \
	--with-proj-includes=$(INSTALL_DIR)/include \
	--with-proj-libs=$(INSTALL_DIR)/lib \
	--with-proj-share=$(INSTALL_DIR)/share/proj \
	--with-postgres-includes=$(INSTALL_DIR)/include \
	--with-postgres-libs=$(INSTALL_DIR)/lib \
	--without-tcltk \
    --without-opengl \
    --without-freetype \
	--without-wxwidgets \
	--enable-largefile \
	--without-python \
    LIBS="-L$(INSTALL_DIR)/lib -liconv" \
    )

# 	CC=/usr/bin/gcc \
	CXX=/usr/bin/g++ \
    LDFLAGS="$(LDFLAGS) -L$(INSTALL_DIR)/lib -liconv" \
    CFLAGS="$(CFLAGS) -L$(INSTALL_DIR)/lib -liconv" \
    CXXFLAGS="$(CFLAGS) -L$(INSTALL_DIR)/lib -liconv" \
    LIBS="-L$(INSTALL_DIR)/lib -liconv"

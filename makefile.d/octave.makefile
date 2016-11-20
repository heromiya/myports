octave_ver = 3.8.2

octave-$(octave_ver).tar.gz:
	wget ftp://ftp.gnu.org/gnu/octave/octave-$(octave_ver).tar.gz
octave.installed: octave-$(octave_ver).tar.gz graphicmagick.installed lib/libsuitesparseconfig.so lib/libreadline.a gnuplot.installed
	$(call compile,\
	--disable-gui \
	--disable-static \
	--disable-openmp \
	--with-magick=GraphicsMagick \
	--with-blas=/usr/lib/libblas.so \
	--with-lapack=/usr/lib/liblapack.so \
	--with-amd-includedir=$(INSTALL_DIR)/include \
	--with-amd-libdir=$(INSTALL_DIR)/lib \
	--with-camd-includedir=$(INSTALL_DIR)/include \
	--with-camd-libdir=$(INSTALL_DIR)/lib \
	--with-colamd-includedir=$(INSTALL_DIR)/include \
	--with-colamd-libdir=$(INSTALL_DIR)/lib \
	--with-ccolamd-includedir=$(INSTALL_DIR)/include \
	--with-ccolamd-libdir=$(INSTALL_DIR)/lib \
	--with-cxsparse-includedir=$(INSTALL_DIR)/include \
	--with-cxsparse-libdir=$(INSTALL_DIR)/lib \
	--with-umfpack-includedir=$(INSTALL_DIR)/include \
	--with-umfpack-libdir=$(INSTALL_DIR)/lib \
	--with-cholmod-includedir=$(INSTALL_DIR)/include \
	--with-cholmod-libdir=$(INSTALL_DIR)/lib \
	CC=gcc \
	CXX=g++ \
	BUILD_CC=gcc \
	BUILD_CXX=g++ \
	LDFLAGS="-L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib -L/usr/lib64 -L/usr/lib" \
	BUILD_LDFLAGS="-L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib -L/usr/lib64 -L/usr/lib")
#	CFLAGS="-m64" CXXFLAGS="-m64"   BUILD_CFLAGS="-m64"  BUILD_CXXFLAGS="-m64" BUILD_LDFLAGS="-L$(INSTALL_DIR)/lib64" ")
#CC=/usr/bin/gcc CXX=/usr/bin/g++ BUILD_CC=/usr/bin/gcc BUILD_CXX=/usr/bin/g++ 
#	LIBS="-lGraphicsMagick -lGraphicsMagick++ -lGraphicsMagickWand" 
#=$(INSTALL_DIR)/lib/libGraphicsMagick++.so	  \
#-L$(INSTALL_DIR)/gcc-4.9.3/lib64 -L$(INSTALL_DIR)/gcc-4.9.3/lib
#$(INSTALL_DIR)/gcc-4.9.3/bin/

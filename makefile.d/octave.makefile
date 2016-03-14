octave_ver = 3.8.2

octave-$(octave_ver).tar.bz2:
	wget ftp://ftp.gnu.org/gnu/octave/octave-$(octave_ver).tar.bz2
octave.installed: octave-$(octave_ver).tar.bz2 lib/libGraphicsMagick.so lib/libsuitesparseconfig.so lib/libreadline.a gnuplot.installed
	$(call compile,\
	--disable-gui \
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
	--with-cholmod-libdir=$(INSTALL_DIR)/lib)

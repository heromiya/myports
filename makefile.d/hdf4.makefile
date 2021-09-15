
hdf-$(hdf4_ver).tar.gz:
	wget $(wget_opt)  http://www.hdfgroup.org/ftp/HDF/releases/HDF$(hdf4_ver)/src/hdf-$(hdf4_ver).tar.gz
hdf4.static.installed: hdf-$(hdf4_ver).tar.gz szip.installed jpeg.installed zlib.installed
	tar xaf $< && cd $(basename $(basename $<)) && export CC=gcc && export CXX=g++ && export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && export LDFLAGS="$(LDFLAGS)" && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && export F77=gfortran && export FFLAGS="$(CFLAGS)" && ./configure  --enable-static --enable-netcdf --enable-static-exec --with-zlib --with-szlib=$(INSTALL_DIR) --with-jpeg=$(INSTALL_DIR) --prefix=$(INSTALL_DIR)/hdf4-static && $(MAKE) $(LIBTOOL) &&  $(MAKE) install && cd .. && touch $@

hdf4.shared.installed: hdf-$(hdf4_ver).tar.gz szip.installed jpeg.installed zlib.installed bison.installed flex.installed
	tar xaf $< && cd $(basename $(basename $<)) && export CC=gcc && export CXX=g++ && export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && export LDFLAGS="$(LDFLAGS)" && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && export F77=gfortran && export FFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) --enable-shared --enable-netcdf --with-zlib=$(INSTALL_DIR) --with-szlib=$(INSTALL_DIR) --with-jpeg=$(INSTALL_DIR) --disable-fortran && $(MAKE) $(LIBTOOL) &&  $(MAKE) install && cd .. && touch $@

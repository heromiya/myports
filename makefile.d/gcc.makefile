gcc_ver = 4.9.3
gcc-$(gcc_ver).tar.bz2:
	wget -q  http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-$(gcc_ver)/gcc-$(gcc_ver).tar.bz2
gcc.installed: gcc-$(gcc_ver).tar.bz2 tar.installed gmp.installed mpfr.installed mpc.installed cloog.installed isl.installed binutils.installed
	tar xaf $< && \
	export CC=/usr/bin/gcc && \
	export CXX=/usr/bin/g++ && \
	export F77=$(F77) && \
	export LD=$(INSTALL_DIR)/bin/ld && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	export LDFLAGS="$(m64_FLAG) -L$(INSTALL_DIR)/lib" && \
	mkdir -p gcc-build && \
	cd gcc-build && \
	../gcc-$(gcc_ver)/configure \
	--prefix=$(INSTALL_DIR) \
	--with-gmp=$(INSTALL_DIR) \
	--with-gmp-lib=$(INSTALL_DIR)/lib \
	--with-gmp-include=$(INSTALL_DIR)/include \
	--with-mpfr=$(INSTALL_DIR) \
	--with-mpfr-lib=$(INSTALL_DIR)/lib \
	--with-mpfr-include=$(INSTALL_DIR)/include \
	--with-mpc=$(INSTALL_DIR) \
	--with-mpc-lib=$(INSTALL_DIR)/lib \
	--with-mpc-include=$(INSTALL_DIR)/include \
	--with-cloog=$(INSTALL_DIR) \
	--with-cloog-lib=$(INSTALL_DIR)/lib \
	--with-cloog-include=$(INSTALL_DIR)/include \
	--with-isl=$(INSTALL_DIR) \
	--with-isl-lib=$(INSTALL_DIR)/lib \
	--with-isl-include=$(INSTALL_DIR)/include \
	--disable-libjava && \
	$(MAKE) && \
	$(MAKE) install && \
	touch ../$@
#$(CFLAGS) 
#	--enable-libada \
#	--enable-libssp \
#	--enable-libquadmath \

#	/bin/rm -rf gcc-build && 
#	export CFLAGS="-std=gnu99" && \
#	export CXXFLAGS="-std=gnu99" && \
#	export CPPFLAGS="-std=gnu99" && \
#	export FFLAGS="-std=gnu99" && \

#	../$(basename $(basename $<))/contrib/download_prerequisites && \
#	$(subst ./configure,,$(subst tar xaf $< && cd $(basename $(basename $<)),tar xaf $< && ,$(call compile,)))

# ppl.installedgmp.installed 

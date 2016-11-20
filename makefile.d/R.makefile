R_version = 3.2.3
R-$(R_version).tar.gz:
	wget -q  https://cran.r-project.org/src/base/R-3/$@

R.installed: R-$(R_version).tar.gz libiconv.installed
	tar xaf $< && cd $(basename $(basename $<)) && \
	./configure --prefix=$(INSTALL_DIR) --without-readline --with-blas --with-lapack && \
	$(MAKE) && $(MAKE) install && touch ../$@



#	$(call compile,\
#	--without-x  --disable-nls --with-included-gettext \
#	LDFLAGS="-L/usr/lib64 -L$(INSTALL_DIR)/lib  -L$(INSTALL_DIR)/lib64 -L/usr/lib" \
#	CFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include -static" \
#	FFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include -static" \
#	CXXFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/glibc-2.15/include -static" \
#	LIBS="$(INSTALL_DIR)/glibc-2.15/lib/libc.a $(INSTALL_DIR)/lib/libiconv.a $(INSTALL_DIR)/lib/libmpfr.a" \
#	LDFLAGS="-L$(INSTALL_DIR)/glibc-2.15/lib $(LDFLAGS)" \
#	)


#
#	LIBS="$(INSTALL_DIR)/glibc-2.15/lib/libc.a $(INSTALL_DIR)/lib/libiconv.a" \
#	CXXFLAGS="-I$(INSTALL_DIR)/glibc-2.15/include $(CFLAGS) -static" \
#	LIBS="/usr/lib/libc.a $(INSTALL_DIR)/lib/libiconv.a" \
#	CC=/usr/bin/gcc \
#	CXX=/usr/bin/g++ )
#	 \
#	

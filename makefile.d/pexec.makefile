pexec-1.0rc8.tar.gz:
	wget -q -nc http://ftp.gnu.org/gnu/pexec/$@
pexec.installed: pexec-1.0rc8.tar.gz
	tar xaf $< && cd pexec-1.0rc8 && export CC=$(CC) && export CXX=$(CXX) && export F77=$(F77) && export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && export LDFLAGS="$(LDFLAGS)" && export FFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) && make && cp src/pexec $(INSTALL_DIR)/bin && touch ../$@
#	$(call compile)

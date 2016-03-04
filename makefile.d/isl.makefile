isl_ver = 0.12.2

isl-$(isl_ver).tar.bz2:
	wget http://isl.gforge.inria.fr/$@
isl.installed: isl-$(isl_ver).tar.bz2 gmp.installed
	$(call compile,CFLAGS=-I$(INSTALL_DIR)/include CXXFLAGS=-I$(INSTALL_DIR)/include CPPFLAGS=-I$(INSTALL_DIR)/include LDFLAGS=-L$(INSTALL_DIR)/lib)

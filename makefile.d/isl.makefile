isl_ver = 0.12.2

isl-$(isl_ver).tar.bz2:
	wget -q  http://isl.gforge.inria.fr/$@
isl.installed: isl-$(isl_ver).tar.bz2 gmp.installed
	export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) && \
	$(call compile,--with-gmp-prefix=$(INSTALL_DIR))
#CFLAGS=-I$(INSTALL_DIR)/include CXXFLAGS=-I$(INSTALL_DIR)/include CPPFLAGS=-I$(INSTALL_DIR)/include 

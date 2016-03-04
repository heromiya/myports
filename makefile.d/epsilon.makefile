epsilon-0.9.2.tar.gz:
	wget http://sourceforge.net/projects/epsilon-project/files/epsilon/0.9.2/epsilon-0.9.2.tar.gz
epsilon.installed: epsilon-0.9.2.tar.gz popt.installed
	$(call compile,CFLAGS=-I$(INSTALL_DIR)/include CXXFLAGS=-I$(INSTALL_DIR)/include LDFLAGS=-L$(INSTALL_DIR)/lib)

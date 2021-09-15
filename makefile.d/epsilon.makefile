epsilon-0.9.2.tar.gz:
	wget -q http://master.dl.sourceforge.net/project/epsilon-project/epsilon/0.9.2/$@
epsilon.installed: epsilon-0.9.2.tar.gz popt.installed
	$(call compile,CFLAGS=-I$(INSTALL_DIR)/include CXXFLAGS=-I$(INSTALL_DIR)/include LDFLAGS=-L$(INSTALL_DIR)/lib)

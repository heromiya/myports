v2.3.0.tar.gz:
	wget -q https://github.com/uclouvain/openjpeg/archive/$@
#	svn checkout http://openjpeg.googlecode.com/svn/tags/version.2.0.1 openjpeg-read-only
openjpeg.installed: v2.3.0.tar.gz tiff.installed
	tar xaf $< && \
	cd openjpeg-2.3.0 && \
	cmake -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_C_FLAGS=-I$(INSTALL_DIR)/include \
	-DCMAKE_CXX_FLAGS=-I$(INSTALL_DIR)/include && \
	make && make install && cd .. && touch $@

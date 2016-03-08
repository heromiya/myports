openjpeg-read-only:
	svn checkout http://openjpeg.googlecode.com/svn/tags/version.2.0.1 openjpeg-read-only
openjpeg.installed: openjpeg-read-only tiff.installed
	cd openjpeg-read-only && \
	cmake -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_C_FLAGS=-I$(INSTALL_DIR)/include \
	-DCMAKE_CXX_FLAGS=-I$(INSTALL_DIR)/include && \
	make && make install && cd .. && touch $@

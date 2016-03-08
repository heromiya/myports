flann-1.8.4-src.zip:
	wget -q  http://www.cs.ubc.ca/research/flann/uploads/FLANN/$@

flann.installed:flann-1.8.4-src.zip hdf5.installed
	unzip -qq -o $< && \
	mkdir -p flann-1.8.4-src/build && \
	cd flann-1.8.4-src/build && \
	cmake .. \
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ && \
	make && make install && touch ../../$@


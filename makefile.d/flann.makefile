flann-1.8.4-src.zip:
	wget -q  http://www.cs.ubc.ca/research/flann/uploads/FLANN/$@

flann.installed:flann-1.8.4-src.zip hdf5.installed
	unzip -qq -o $< && cd flann-1.8.4-src && \
	$(call cmake)

#mkdir -p build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ && make && make install && cd ../.. && touch $@

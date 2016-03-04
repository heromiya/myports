points2grid: 
	git clone https://github.com/CRREL/points2grid.git

#1.3.0.tar.gz:
#	wget https://github.com/CRREL/points2grid/archive/$@

points2grid.installed: points2grid boost.installed
	mkdir -p points2grid/build && \
	cd points2grid/build && \
	export CMAKE_PREFIX_PATH=$(INSTALL_DIR) && \
	cmake .. \
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DBoost_INCLUDE_DIR=$(INSTALL_DIR)/myports/boost_1_60_0 \
	-DCMAKE_C_COMPILER=gcc-4.8 \
	-DCMAKE_CXX_COMPILER=g++-4.8 \
	-DCMAKE_C_FLAGS= \
	-DCMAKE_CXX_FLAGS= && \
	make && make install && cd ../.. && touch $@


#	tar xaf $< && \
	mkdir -p points2grid-1.3.0/build && \
	cd points2grid-1.3.0/build && \

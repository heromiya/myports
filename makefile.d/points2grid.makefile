points2grid: 
	git clone https://github.com/CRREL/points2grid.git

#1.3.0.tar.gz:
#	wget -q  https://github.com/CRREL/points2grid/archive/$@

points2grid.installed: points2grid boost.installed
	mkdir -p points2grid/build && \
	cd points2grid/build && \
	export CMAKE_PREFIX_PATH=$(INSTALL_DIR) && \
	cmake .. \
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DBoost_INCLUDE_DIR=$(INSTALL_DIR)/include \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_C_FLAGS= \
	-DCMAKE_CXX_FLAGS= && \
	make && make install && cd ../.. && touch $@


#	tar xaf $< && \
	mkdir -p points2grid-1.3.0/build && \
	cd points2grid-1.3.0/build && \

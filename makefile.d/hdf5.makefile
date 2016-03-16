hdf5.installed lib/libhdf5.so:
	wget -q -nc https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/src/hdf5-1.8.16.tar.bz2 && \
	tar xaf hdf5-1.8.16.tar.bz2 && \
	mkdir -p hdf5-1.8.16/build  && \
	cd hdf5-1.8.16/build && \
	cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) $1 .. && \
	$(MAKE) && $(MAKE) install && touch ../../$@ && \
	cd $(INSTALL_DIR)/lib && \
	for FILE in libhdf5*; do mv -f $$FILE `echo $$FILE | sed 's/-shared//; s/-static//'`; done
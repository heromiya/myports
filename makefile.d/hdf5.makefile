
hdf5.installed:
	wget -q -nc https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.3/src/hdf5-1.10.3.tar.bz2 && \
	tar xaf hdf5-1.10.3.tar.bz2 && \
	mkdir -p hdf5-1.10.3/build  && \
	cd hdf5-1.10.3/build && \
	cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) $1 .. && \
	$(MAKE) && $(MAKE) install  && \
	cd $(INSTALL_DIR)/lib && \
	for FILE in libhdf5*; do mv -f $$FILE `echo $$FILE | sed 's/-shared//; s/-static//'`; done

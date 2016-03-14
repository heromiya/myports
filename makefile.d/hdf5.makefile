hdf5-1.8.16.tar.bz2:
	wget -q  https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/src/$@
hdf5.installed: hdf5-1.8.16.tar.bz2
	tar xaf $< && \
	mkdir -p hdf5-1.8.16/build  && \
	cd hdf5-1.8.16/build && \
	cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) $1 .. && \
	$(MAKE) && $(MAKE) install && touch ../../$@ && \
	cd $(INSTALL_DIR)/lib && \
	for FILE in libhdf5*; do ln -s $FILE `echo $FILE | sed 's/-shared//; s/-static//'`; done

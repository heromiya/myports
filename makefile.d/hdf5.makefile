
hdf5.installed:
	wget $(wget_opt) https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-$(hdf5_ver)/src/hdf5-$(hdf5_ver).tar.bz2 && \
	tar xaf hdf5-$(hdf5_ver).tar.bz2 && \
	mkdir -p hdf5-$(hdf5_ver)/build  && \
	cd hdf5-$(hdf5_ver)/build && \
	cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) $1 .. && \
	$(MAKE) && $(MAKE) install  && \
	cd $(INSTALL_DIR)/lib && \
	for FILE in libhdf5*; do mv -f $$FILE `echo $$FILE | sed 's/-shared//; s/-static//'`; done

hdf5-1.8.16.tar.bz2:
	wget https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/src/$@
hdf5.installed: hdf5-1.8.16.tar.bz2
	tar xaf $< && cd hdf5-1.8.16 && $(call cmake)

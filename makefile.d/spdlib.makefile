spdlib:
	hg clone https://bitbucket.org/petebunting/spdlib spdlib
spdlib.installed: spdlib boost.installed gdal.installed hdf5.installed
	cd spdlib && $(call cmake,-DBOOST_INCLUDE_DIR=$(INSTALL_DIR)/include -DBOOST_LIB_PATH=$(INSTALL_DIR)/lib -DGDAL_INCLUDE_DIR=$(INSTALL_DIR)/include/ -DGDAL_LIB_PATH=$(INSTALL_DIR)/lib)

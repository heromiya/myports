FLAGS = -L$(INSTALL_DIR)/lib -llas -L$(INSTALL_DIR)/lib -llas_c
spdlib:
	hg clone https://bitbucket.org/petebunting/spdlib spdlib
spdlib.installed: spdlib boost.installed gdal.installed hdf5.installed cgal.installed liblas.installed
	cd spdlib && $(call cmake,-DBOOST_INCLUDE_DIR=$(INSTALL_DIR)/include -DBOOST_LIB_PATH=$(INSTALL_DIR)/lib -DGDAL_INCLUDE_DIR=$(INSTALL_DIR)/include/ -DGDAL_LIB_PATH=$(INSTALL_DIR)/lib -DHDF5_INCLUDE_DIR=$(INSTALL_DIR)/include -DHDF5_LIB_PATH=$(INSTALL_DIR)/lib -DLIBLAS_INCLUDE_DIR=$(INSTALL_DIR)/include -DLIBLAS_LIB_PATH=$(INSTALL_DIR)/lib -DCMAKE_CXX_COMPILER=g++-4.8 -DCMAKE_C_COMPILER=gcc-4.8 -DCMAKE_CXX_FLAGS="$(FLAGS)" -DCMAKE_C_FLAGS="$(FLAGS)")

# Needs a correction in include/liblas/point.hpp
#107c107
#<     // Point();
#---
#>     Point();

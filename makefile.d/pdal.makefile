#pdal:
#	git clone https://github.com/PDAL/PDAL.git pdal && cd pdal && git checkout tags/1.0.1
pdal_ver = 1.0.1
PDAL-$(pdal_ver)-src.tar.gz:
	wget -q  http://download.osgeo.org/pdal/$@
pdal.installed: PDAL-$(pdal_ver)-src.tar.gz cmake.installed numpy.installed boost.installed pcl.installed laszip.installed gdal.installed libgeotiff.installed proj4.installed points2grid.installed
	tar xaf $< && \
	sed -i 's/#include <pdal\/Options.hpp>/#include <pdal\/Options.hpp>\n#include <sys\/types.h>\n#include <sys\/stat.h>\n#include <fcntl.h>/g' \
	PDAL-$(pdal_ver)-src/include/pdal/PDALUtils.hpp && \
	mkdir -p PDAL-$(pdal_ver)-src/build && \
	cd PDAL-$(pdal_ver)-src/build && \
	cmake -G "Unix Makefiles" \
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DGDAL_CONFIG=$(INSTALL_DIR)/bin/gdal-config \
	-DGDAL_INCLUDE_DIR=$(INSTALL_DIR)/include \
	-DGDAL_LIBRARY=$(INSTALL_DIR)/lib/libgdal.so \
	-DGEOTIFF_INCLUDE_DIR=$(INSTALL_DIR)/include \
	-DGEOTIFF_LIBRARY=$(INSTALL_DIR)/lib/libgeotiff.so \
	-DBUILD_PLUGIN_PCL=ON \
	-DBUILD_PLUGIN_P2G=ON \
	-DBUILD_PLUGIN_PYTHON=ON \
	-DPDAL_HAVE_GEOS=YES \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DBoost_DIR=$(INSTALL_DIR) \
	-DBOOST_ROOT=$(INSTALL_DIR) \
	-DBoost_INCLUDE_DIR=$(INSTALL_DIR)/include \
	-DBoost_LIBRARY_DIR=$(INSTALL_DIR)/lib \
	-DLASZIP_INCLUDE_DIR=$(INSTALL_DIR)/include .. && \
	make && make install && cd ../../ && touch $@

#mkdir -p build && cd build && cmake -G "Unix Makefiles" ../  && make && make install && cd ../../ && touch $@
#-DBoost_DIR=$(INSTALL_DIR)/myports/boost_1_60_0/boost
#gdal.installed

# include/pdal/PDALUtils.hpp needs correction
# #include <sys/types.h>
# #include <sys/stat.h>
# #include <fcntl.h>

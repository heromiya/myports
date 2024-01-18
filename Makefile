INSTALL_DIR = $(HOME)/apps
VPATH = .:$(HOME)/apps:/usr:/usr/lib:/usr/lib64

STATIC_FLAGS= -static -static-libgcc -static-libstdc++

UNAME_A = $(shell uname -a)
ifeq ($(findstring x86_64,$(UNAME_A)),x86_64)
m64_FLAG = -m64  -L$(INSTALL_DIR)/lib64
LDFLAGS= $(m64_FLAG) -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib -L$(CONDA_PREFIX)/lib -L/usr/lib -L/usr/lib64
else
m64_FLAG = -m32
LDFLAGS= $(m64_FLAG) -L$(INSTALL_DIR)/lib -L/usr/lib -L$(CONDA_PREFIX)/lib
endif

CC = gcc
CXX = g++
F77 = gfortran

ifneq (`which make`,)
MAKE = make -j3
else
MAKE = gmake
endif

CFLAGS = -fPIC $(m64_FLAG) -I$(INSTALL_DIR)/include -I$(CONDA_PREFIX)/include -I/usr/include -L$(INSTALL_DIR)/lib -L$(CONDA_PREFIX)/lib

compile = tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=$(CC) && \
	export CXX=$(CXX) && \
	export F77=$(F77) && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	export CFLAGS="$(CFLAGS)" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export LDFLAGS="$(LDFLAGS)" && \
	export FFLAGS="$(CFLAGS)" && \
	./configure --prefix=$(INSTALL_DIR) $1 && $(MAKE) uninstall; $(MAKE) && $(MAKE) install && touch ../$@

compile_no_touch = tar xaf $< && cd $(basename $(basename $<)) && export CC=$(CC) && export CXX=$(CXX) && export F77=$(F77) && export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && export LDFLAGS="$(LDFLAGS)" && export FFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) $1 && $(MAKE) uninstall; $(MAKE) && $(MAKE) install

cmake = mkdir -p build && cd build && cmake -G "Unix Makefiles" \
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=/usr/bin/gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_C_FLAGS="$(CFLAGS)"\
	-DCMAKE_CXX_FLAGS="$(CFLAGS)" \
	-DCMAKE_SHARED_LINKER_FLAGS="$(LDFLAGS)" \
	-DCMAKE_STATIC_LINKER_FLAGS="$(LDFLAGS)" \
	-DCMAKE_EXE_LINKER_FLAGS="$(LDFLAGS)" \
	-DCMAKE_SKIP_INSTALL_RPATH=TRUE \
	-DINSTALL_RPATH= \
	-DCMAKE_SKIP_RPATH=TRUE \
	$1 .. && $(MAKE) && $(MAKE) install && touch ../../$@

gdal_ver = 3.8.3
geos_ver = 3.11.3
libspatialite_ver = 5.1.0

expat_ver = 2.1.0
grass_ver = 7.8.8
fftw_ver = 3.3.4
icewm_ver = 1.3.3
qgis_ver = 2.6.1
pyqt_version = 4.11.3
sip_version = 4.16.4
gsl_version = 1.16
qiv_version = 2.3.1
qwt_ver = 6.0.2
ossim_ver = 1.8.16
libxslt_ver = 1.1.28
freexl_ver = 2.0.0
ITK_ver = 3.12.0
OpenSceneGraph_ver = 2.8.5
R_ver = 3.1.3
laszip_ver = 2.2.0
tiff_ver = 4.0.9
jpeg_ver = 9c
szip_ver=2.1.1
hdf4_ver = 4.2.14
hdf5_ver = 1.10.1
sqlite_ver = 3450000

libssh2_ver = 1.8.0
openssl_ver = 1.1.1w
python_ver = 3.5.6

pcre_ver = 10.42
readline_ver = 6.3
xz_ver = 5.4.5
zlib_ver = 1.3
flex_ver = 2.5.39
cmake_ver = 3.10.3



wget_opt = -q --no-check-certificate

include utils.makefile
include makefile.d/*.makefile

all:

pcl:
	git clone https://github.com/PointCloudLibrary/pcl.git
pcl.installed: pcl flann.installed eigen.installed boost.installed
	cd pcl && mkdir -p build && cd build && git fetch origin --tags && git checkout tags/pcl-1.7.2 && cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) -DBUILD_outofcore:BOOL=OFF -DWITH_QT:BOOL=ON -DWITH_VTK:BOOL=ON -DWITH_OPENNI:BOOL=OFF -DWITH_CUDA:BOOL=OFF -DWITH_LIBUSB:BOOL=OFF -DBUILD_people:BOOL=OFF -DBUILD_surface:BOOL=ON -DBUILD_tools:BOOL=ON -DBUILD_visualization:BOOL=ON -DBUILD_sample_consensus:BOOL=ON -DBUILD_tracking:BOOL=OFF -DBUILD_stereo:BOOL=OFF -DBUILD_keypoints:BOOL=OFF -DBUILD_pipeline:BOOL=ON -DCMAKE_CXX_FLAGS="-std=c++11" -DBUILD_io:BOOL=ON -DBUILD_octree:BOOL=ON -DBUILD_segmentation:BOOL=ON -DBUILD_search:BOOL=ON -DBUILD_geometry:BOOL=ON -DBUILD_filters:BOOL=ON -DBUILD_features:BOOL=ON -DBUILD_kdtree:BOOL=ON -DBUILD_common:BOOL=ON -DBUILD_ml:BOOL=ON -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DBoost_INCLUDE_DIR=$(INSTALL_DIR)/myports/boost_1_60_0 && make && make install && cd ../.. && touch $@

eigen.3.2.8.tar.bz2:
	wget --no-check-certificate http://bitbucket.org/eigen/eigen/get/3.2.8.tar.bz2 -O $@
eigen.installed: eigen.3.2.8.tar.bz2
	tar xaf $< && cd eigen-* && mkdir -p build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) && make && make install && cd ../.. && touch $@

pixman-$(pixman_ver).tar.gz:
	wget http://cairographics.org/releases/$@
pixman.installed:pixman-$(pixman_ver).tar.gz
	$(call compile)
cairo-$(cairo_ver).tar.xz:
	wget  http://cairographics.org/releases/$@
cairo.installed: cairo-$(cairo_ver).tar.xz pixman.installed
	$(call compile)
libwebp-$(webp_ver).tar.gz:
	wget --no-check-certificate https://storage.googleapis.com/downloads.webmproject.org/releases/webp/$@
libwebp.installed:libwebp-$(webp_ver).tar.gz
	$(call compile)
librasterlite2-$(librasterlite_ver).tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/$@
librasterlite2.installed: librasterlite2-$(librasterlite_ver).tar.gz libwebp.installed tiff.installed cairo.installed
	$(call compile,CFLAGS="$(CFLAGS) -lcairo")

OpenSceneGraph-2.8.5.zip:
	wget -q  http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-2.8.5/source/OpenSceneGraph-2.8.5.zip
OpenSceneGraph.installed: OpenSceneGraph-2.8.5.zip
	unzip $< && cd OpenSceneGraph-2.8.5 && ./configure --prefix=$(INSTALL_DIR) CC=gcc PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib"  && $(MAKE) uninstall; $(MAKE) && ln -sf `which libtool` . && $(MAKE) install && cd .. && touch $@

ossim-$(ossim_ver).tar.gz:
	wget -q  http://download.osgeo.org/ossim/source/ossim-$(ossim_ver)/ossim-$(ossim_ver).tar.gz
ossim.installed: ossim-$(ossim_ver).tar.gz
	$(call compile,--with-libtiff=$(INSTALL_DIR) --with-geotiff=$(INSTALL_DIR) --with-openthreads=$(INSTALL_DIR))
#	tar xaf $< && cd ossim-1.8.16/ossim && ./configure --prefix=$(INSTALL_DIR) --enable-sharedOssimLibraries --enable-staticOssimLibraries --enable-singleSharedOssimLibrary --enable-singleStaticOssimLibrary --enable-staticOssimApps --with-libtiff=$(INSTALL_DIR) --with-geotiff=$(INSTALL_DIR) --with-openthreads=$(INSTALL_DIR) CC=gcc PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib"  CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" CPPFLAGS="$(CFLAGS)" F77=gfortran FFLAGS="$(CFLAGS)" && gmake uninstall; gmake -j20 && ln -sf `which libtool` . && gmake install && cd .. && touch $@


dropbear-2016.72.tar.bz2:
	wget -q  http://matt.ucc.asn.au/dropbear/releases/$@
dropbear.installed: dropbear-2016.72.tar.bz2
	$(call compile)
openssh-$(openssh_ver).tar.gz:
	wget -q  http://www.ftp.ne.jp/OpenBSD/OpenSSH/portable/openssh-$(openssh_ver).tar.gz
openssh.installed: openssh-$(openssh_ver).tar.gz openssl.installed
	$(call compile,--with-shared --with-libs --with-pie)

gnuplot-4.6.7.tar.gz:
	wget http://sourceforge.net/projects/gnuplot/files/gnuplot/4.6.7/$@
gnuplot.installed: gnuplot-4.6.7.tar.gz
	$(call compile)
sip-$(sip_version).tar.gz:
	wget -q  http://sourceforge.net/projects/pyqt/files/sip/sip-$(sip_version)/sip-$(sip_version).tar.gz
sip.installed: sip-$(sip_version).tar.gz
	tar xaf $< && cd $(basename $(basename $<)) && python configure.py && make && make install && cd .. && touch $@
PyQt-x11-gpl-$(pyqt_version).tar.gz:
	wget -q  http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-$(pyqt_version)/PyQt-x11-gpl-$(pyqt_version).tar.gz
pyqt.installed: PyQt-x11-gpl-$(pyqt_version).tar.gz sip.installed
	tar xaf $< && cd $(basename $(basename $<)) && python configure.py && make && make install && cd .. && touch $@
QScintilla-gpl-2.8.4.tar.gz:
	wget -q  http://sourceforge.net/projects/pyqt/files/QScintilla2/QScintilla-2.8.4/QScintilla-gpl-2.8.4.tar.gz
QScintilla.installed: QScintilla-gpl-2.8.4.tar.gz sip.installed
	tar xaf $< && cd $(basename $(basename $<))/Qt4Qt5 && qmake qscintilla.pro && make && make install && cd ../Python && python configure.py && make && make install && cd ../../ && touch $@

qwt-$(qwt_ver).tar.bz2:
	wget -q  http://sourceforge.net/projects/qwt/files/qwt/$(qwt_ver)/qwt-$(qwt_ver).tar.bz2
qwt.installed: qwt-$(qwt_ver).tar.bz2
	tar xaf $< && cd $(basename $(basename $<)) && sed -i 's#QWT_INSTALL_PREFIX *= .*#QWT_INSTALL_PREFIX = $(INSTALL_DIR)#g' qwtconfig.pri && qmake qwt.pro && make && make install && cd $$OLDPWD && touch $@

gsl-$(gsl_version).tar.gz:
	wget -q  http://ftp.yzu.edu.tw/gnu/gsl/gsl-$(gsl_version).tar.gz
gsl.installed: gsl-$(gsl_version).tar.gz
	$(call compile)
spatialindex-src-1.8.5.tar.gz:
	wget -q  http://download.osgeo.org/libspatialindex/spatialindex-src-1.8.5.tar.gz
spatialindex.installed: spatialindex-src-1.8.5.tar.gz
	tar xaf $< && cd $(basename $(basename $<)) && \
	export CFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -I$(INSTALL_DIR)/include/libxml2/libxml -L$(INSTALL_DIR)/lib64" && \
	export CXXFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include  -I$(INSTALL_DIR)/include/libxml2/libxml -L$(INSTALL_DIR)/lib64" && export CPPFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib64" && export LDFLAGS="-L$(INSTALL_DIR)/lib64" && ./configure --prefix=$(INSTALL_DIR) $1 && make && make install && cd .. && touch $@
qgis-$(qgis_ver).tar.bz2:
	wget -q  http://qgis.org/downloads/qgis-$(qgis_ver).tar.bz2
0001-Fix-build-failure-with-gcc-4.4-bug-10762.patch:
	wget -q  http://hub.qgis.org/attachments/download/7755/0001-Fix-build-failure-with-gcc-4.4-bug-10762.patch
qgis.installed: qgis-$(qgis_ver).tar.bz2 qt.installed pyqt.installed gsl.installed QScintilla.installed qwt.installed spatialindex.installed bison.installed flex.installed gdal.installed 0001-Fix-build-failure-with-gcc-4.4-bug-10762.patch
	tar xaf $< && cd $(basename $(basename $<)) && patch -p1 < ../0001-Fix-build-failure-with-gcc-4.4-bug-10762.patch && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && cmake -DSQLITE3_INCLUDE_DIR=/dias/users/miyazaki.h.u-tokyo/apps/include -DSQLITE3_LIBRARY=/dias/users/miyazaki.h.u-tokyo/apps/lib/libsqlite3.so -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) . && make && make install

qt-everywhere-opensource-src-4.7.4.tar.gz:
	wget -q  http://download.qt-project.org/archive/qt/4.7/qt-everywhere-opensource-src-4.7.4.tar.gz
qt.installed: qt-everywhere-opensource-src-4.7.4.tar.gz
	$(call compile,-opensource)
icewm-$(icewm_ver).tar.gz:
	wget -q  http://downloads.sourceforge.net/project/icewm/icewm-1.3/$(icewm_ver)/icewm-$(icewm_ver).tar.gz
icewm.installed: icewm-$(icewm_ver).tar.gz
	$(call compile)
libxslt-$(libxslt_ver).tar.gz:
	wget -q  http://xmlsoft.org/sources/libxslt-$(libxslt_ver).tar.gz
libxslt.installed: libxslt-$(libxslt_ver).tar.gz
	$(call compile)
fftw-$(fftw_ver).tar.gz:
	wget -q  http://www.fftw.org/fftw-$(fftw_ver).tar.gz
fftw.installed: fftw-$(fftw_ver).tar.gz
	$(call compile)

freexl-$(freexl_ver).tar.gz:
	wget -q  http://www.gaia-gis.it/gaia-sins/freexl-sources/$@
freexl.installed: freexl-$(freexl_ver).tar.gz
	$(call compile)
readosm-1.1.0a.tar.gz:
	wget -q  http://www.gaia-gis.it/gaia-sins/readosm-sources/$@
readosm.installed: readosm-1.1.0a.tar.gz
	$(call compile)


#	$(call compile, --enable-static --enable-static-exec --with-zlib=$(INSTALL_DIR) --with-szlib=$(INSTALL_DIR) --with-jpeg=$(INSTALL_DIR) --prefix=$(INSTALL_DIR)/hdf4-static CFLAGS="-static $(CFLAGS)" CXXFLAGS="-static $(CFLAGS)")



#	$(call compile, --prefix=$(INSTALL_DIR) --enable-shared --enable-netcdf --with-szlib=$(INSTALL_DIR) --with-jpeg=$(INSTALL_DIR))
# && cp -rf hdf-$(hdf4_ver)/hdf4/* ~/apps/
# --disable-fortran

jasper-1.900.1.zip:
	wget -q  http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip
jasper-1.900.1.uuid.tar.gz:
	wget -q  ftp://ftp.remotesensing.org/gdal/jasper-1.900.1.uuid.tar.gz
jasper.installed: jasper-1.900.1.uuid.tar.gz
	$(call compile)
popt-1.19.tar.gz:
	wget -q  https://ftp.osuosl.org/pub/rpm/popt/releases/popt-1.x/popt-1.19.tar.gz
popt.installed: popt-1.19.tar.gz
	$(call compile)
gctpc20.tar.Z:
	wget -q  http://www.nco.ncep.noaa.gov/pmb/codes/nwprod/util/sorc/wgrib2.cd/grib2/gctpc20.tar.Z
gctpc20.installed: gctpc20.tar.Z
	tar xaf $< && cd gctpc/source && make && \
	mv geolib.a $(INSTALL_DIR)/lib/libgctp.a && \
	gcc -shared -fPIC -o libgctp.so *.c && \
	mv libgctp.so $(INSTALL_DIR)/lib/ && \
	mkdir -p $(INSTALL_DIR)/include/gctp && \
	cp *.h  $(INSTALL_DIR)/include/gctp/ && \
	cd $$OLDPWD && touch $@
#	cp cproj.h  $(INSTALL_DIR)/include/gctp/ && 

HDF-EOS2.19v1.00.tar.Z:
	wget -nc ftp://edhs1.gsfc.nasa.gov/edhs/hdfeos/latest_release/HDF-EOS2.19v1.00.tar.Z
HDF-EOS2.installed: HDF-EOS2.19v1.00.tar.Z szip.installed hdf4.static.installed hdf4.shared.installed
	 tar xaf $< && cd hdfeos && ./configure CC=$(INSTALL_DIR)/bin/h4cc LDFLAGS=-L$(INSTALL_DIR)/lib --with-szlib=$(INSTALL_DIR) --with-hdf4=$(INSTALL_DIR)/hdf4-static --prefix=$(INSTALL_DIR) && make && make install && cd .. && touch $@
#
#	ranlib $(INSTALL_DIR)/lib/libmfhdf.a
product_formatter_v1.5.1:
	wget -q -nc https://github.com/USGS-EROS/espa-product-formatter/archive/$@
#	git clone https://github.com/USGS-EROS/espa-product-formatter.git
espa-product-formatter.installed: product_formatter_v1.5.1 jbigkit.installed gctpc20.installed libxml2.installed HDF-EOS2.installed
	tar xaf $< && cd espa-product-formatter-product_formatter_v1.5.1 && export PREFIX=$(INSTALL_DIR) && \
	export HDFEOS_GCTPINC=$(INSTALL_DIR)/include && \
	export HDFEOS_GCTPLIB=$(INSTALL_DIR)/lib && \
	export TIFFINC=$(INSTALL_DIR)/include && \
	export TIFFLIB=$(INSTALL_DIR)/lib && \
	export GEOTIFF_INC=$(INSTALL_DIR)/include && \
	export GEOTIFF_LIB=$(INSTALL_DIR)/lib && \
	export HDFINC=$(INSTALL_DIR)/include && \
	export HDFLIB=$(INSTALL_DIR)/lib && \
	export HDFEOS_INC=$(INSTALL_DIR)/include/hdfeos && \
	export HDFEOS_LIB=$(INSTALL_DIR)/lib && \
	export JPEGINC=$(INSTALL_DIR)/include && \
	export JPEGLIB=$(INSTALL_DIR)/lib && \
	export XML2INC=$(INSTALL_DIR)/include/libxml2 && \
	export XML2LIB=$(INSTALL_DIR)/lib && \
	export JBIGINC=$(INSTALL_DIR)/include && \
	export JBIGLIB=$(INSTALL_DIR)/lib && \
	export ZLIBINC=$(INSTALL_DIR)/include && \
	export ZLIBLIB=$(INSTALL_DIR)/lib && \
	export ESPAINC=$(INSTALL_DIR)/include && \
	export ESPALIB=$(INSTALL_DIR)/lib && \
	export CFLAGS="$(CFLAGS) -m64" && make && make install && cd .. && touch $@

jbigkit-2.1.tar.gz:
	wget http://www.cl.cam.ac.uk/%7Emgk25/jbigkit/download/jbigkit-2.1.tar.gz

jbigkit.installed: jbigkit-2.1.tar.gz
	tar xaf $< && cd jbigkit-2.1 && make && cp libjbig/libjbig.a libjbig/libjbig85.a $(INSTALL_DIR)/lib/ && cp libjbig/*.h  $(INSTALL_DIR)/include/ && cd .. && touch $@

netcdf_ver = 4.3.3.1
netcdf-$(netcdf_ver).tar.gz:
#	wget --no-check-certificate https://github.com/Unidata/netcdf-c/archive/$@
	wget ftp://ftp.unidata.ucar.edu/pub/netcdf/$@
netcdf.installed: netcdf-$(netcdf_ver).tar.gz hdf5.installed
	$(call compile,--enable-mmap --enable-jna --enable-hdf4)

ledaps_v2.4.0:
	wget -q -nc https://github.com/USGS-EROS/espa-surface-reflectance/archive/$@
#	git clone -b ledaps_v2.3.1 https://github.com/USGS-EROS/espa-surface-reflectance.git

new.ledaps.installed: ledaps_v2.4.0 espa-product-formatter.installed libgeotiff.installed gctpc20.installed hdf4.shared.installed HDF-EOS2.installed szip.installed netcdf.installed jbigkit.installed
	cd espa-surface-reflectance-ledaps_v2.4.0/ledaps/ledapsSrc/src && export INSTALL_DIR="$(INSTALL_DIR)" && export CFLAGS="$(CFLAGS)" && ../../../../ledaps.install.sh && touch ../../../../$@
#	export BUILD_STATIC=yes && 

ledapsAnc.installed: new.ledaps.installed netcdf.installed
	ln -sf $(INSTALL_DIR)/include/netcdf.h $(INSTALL_DIR)/include/hdf4_netcdf.h && \
	cd espa-surface-reflectance/ledaps/ledapsAncSrc && \
	export PREFIX=$(INSTALL_DIR) && \
	export NCDF4INC=$(INSTALL_DIR)/include && \
	export NCDF4LIB=$(INSTALL_DIR)/lib && \
	export HDF5INC=$(INSTALL_DIR)/include && \
	export HDF5LIB=$(INSTALL_DIR)/lib && \
	export CURLINC=$(INSTALL_DIR)/include && \
	export CURLLIB=$(INSTALL_DIR)/lib && \
	export IDNINC=$(INSTALL_DIR)/include && \
	export IDNLIB=$(INSTALL_DIR)/lib && \
	export NCDF4INC=$(INSTALL_DIR)/include && \
	export NCDF4LIB=$(INSTALL_DIR)/lib && \
	export HDF5INC=$(INSTALL_DIR)/include && \
	export HDF5LIB=$(INSTALL_DIR)/lib && \
	export HDFINC=$(INSTALL_DIR)/include && \
	export HDFLIB=$(INSTALL_DIR)/lib && \
	export HDFEOS_INC=$(INSTALL_DIR)/include/hdfeos && \
	export HDFEOS_LIB=$(INSTALL_DIR)/lib && \
	export HDFEOS_GCTPINC=$(INSTALL_DIR)/include && \
	export HDFEOS_GCTPLIB=$(INSTALL_DIR)/lib && \
	export CURLINC=$(INSTALL_DIR)/include && \
	export CURLLIB=$(INSTALL_DIR)/lib && \
	export IDNINC=$(INSTALL_DIR)/include && \
	export IDNLIB=$(INSTALL_DIR)/lib && \
	export XML2INC=$(INSTALL_DIR)/include/libxml2 && \
	export XML2LIB=$(INSTALL_DIR)/lib && \
	export ZLIBINC=$(INSTALL_DIR)/include && \
	export ZLIBLIB=$(INSTALL_DIR)/lib && \
	export LZMALIB=$(INSTALL_DIR)/lib && \
	export LZMAINC=$(INSTALL_DIR)/include && \
	export ESPALIB=$(INSTALL_DIR)/lib && \
	export ESPAINC=$(INSTALL_DIR)/include && \
	export JPEGINC=$(INSTALL_DIR)/include && \
	export JPEGLIB=$(INSTALL_DIR)/lib && \
	export ENABLE_DEBUG=yes && \
	export DISABLE_OPTIMIZATION=yes && \
	make && make install  && cd ../../../ && touch $@
#	export BUILD_STATIC=yes && 
#	export EXTRA_OPTIONS="$(CFLAGS) -lm -lmfhdf" &&  

ledaps-read-only:
	svn checkout http://ledaps.googlecode.com/svn/releases/version_1.3.1 ledaps-read-only
ledaps.installed: ledaps-read-only libgeotiff.installed gctpc20.installed hdf4.static.installed HDF-EOS2.installed szip.installed tiff.installed
	cd ledaps-read-only/ledapsSrc/src && \
	export HDFEOS_GCTPINC=$(INSTALL_DIR)/include/gctp && \
	export HDFEOS_GCTPLIB=$(INSTALL_DIR)/lib && \
	export TIFFINC=/usr/include && \
	export TIFFLIB=/usr/lib && \
	export GEOTIFF_INC=$(INSTALL_DIR)/include && \
	export GEOTIFF_LIB=$(INSTALL_DIR)/lib && \
	export HDFINC=$(INSTALL_DIR)/hdf4-static/include && \
	export HDFLIB=$(INSTALL_DIR)/hdf4-static/lib && \
	export HDFEOS_INC=$(INSTALL_DIR)/include/hdfeos && \
	export HDFEOS_LIB=$(INSTALL_DIR)/lib && \
	export JPEGINC=$(INSTALL_DIR)/include && \
	export JPEGLIB=$(INSTALL_DIR)/lib && \
	export BIN=$(INSTALL_DIR)/bin/ledaps && \
	export SZIPINC=$(INSTALL_DIR)/include && \
	export SZIPLIB=$(INSTALL_DIR)/lib && \
	find -type f | grep Makefile$ | xargs -n 1 sed -i 's/-ldf /-ldf -lsz /g' && \
	make && make install && cd $$OLDPWD && touch $@

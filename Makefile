INSTALL_DIR = $(HOME)/apps

UNAME_A = $(shell uname -a)
ifeq ($(findstring x86_64,$(UNAME_A)),x86_64)
m64_FLAG = -m64  -L$(INSTALL_DIR)/lib64
else
m64_FLAG = -m32
endif

ifneq (`which make`,)
MAKE = make
else
MAKE = gmake
endif

#ifneq (`which libtool`,)
#LIBTOOL = 
#else
#LIBTOOL = && ln -sf `which libtool` .
#endif

CFLAGS = -fPIC -I$(INSTALL_DIR)/include -I/usr/include -I/usr/local/include -L$(INSTALL_DIR)/lib -L/usr/local/lib
LDFLAGS= $(m64_FLAG) -L$(INSTALL_DIR)/lib

compile = tar xaf $< && cd $(basename $(basename $<)) && ./configure --prefix=$(INSTALL_DIR) $1 && $(MAKE) uninstall; $(MAKE) && $(MAKE) install && cd .. && touch $@

cmake = cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) $1 . && make && make install && cd ../ && touch $@
#

sqlite_ver = 3081101
expat_ver = 2.1.0
#proj_ver = 4.8.0
#geos_ver = 3.5.0
geos_ver = 3.4.2
grass_ver = 6.4.5
mapserver_ver = 6.4.1
python_ver = 2.7.9
fftw_ver = 3.3.4
icewm_ver = 1.3.3
qgis_ver = 2.6.1
pyqt_version = 4.11.3
sip_version = 4.16.4
gsl_version = 1.16
qiv_version = 2.3.1
qwt_ver = 6.0.2
octave_ver = 3.8.2
graphicmagick_ver = 1.3.21
ossim_ver = 1.8.16

libxslt_ver = 1.1.28
libspatialite_ver = 4.3.0
spatialite-tools_ver = 4.3.0
freexl_ver = 1.0.2
hdf4_ver = 4.2.10
jpeg_ver = 9a

ITK_ver = 3.12.0
OpenSceneGraph_ver = 2.8.5


include utils.makefile
include makefile.d/*.makefile

all:




gippy.installed: pip.installed
	pip install gippy && touch $@

pcl:
	git clone https://github.com/PointCloudLibrary/pcl.git
pcl.installed: pcl flann.installed eigen.installed boost.installed
	cd pcl && mkdir -p build && cd build && git fetch origin --tags && git checkout tags/pcl-1.7.2 && cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) -DBUILD_outofcore:BOOL=OFF -DWITH_QT:BOOL=ON -DWITH_VTK:BOOL=ON -DWITH_OPENNI:BOOL=OFF -DWITH_CUDA:BOOL=OFF -DWITH_LIBUSB:BOOL=OFF -DBUILD_people:BOOL=OFF -DBUILD_surface:BOOL=ON -DBUILD_tools:BOOL=ON -DBUILD_visualization:BOOL=ON -DBUILD_sample_consensus:BOOL=ON -DBUILD_tracking:BOOL=OFF -DBUILD_stereo:BOOL=OFF -DBUILD_keypoints:BOOL=OFF -DBUILD_pipeline:BOOL=ON -DCMAKE_CXX_FLAGS="-std=c++11" -DBUILD_io:BOOL=ON -DBUILD_octree:BOOL=ON -DBUILD_segmentation:BOOL=ON -DBUILD_search:BOOL=ON -DBUILD_geometry:BOOL=ON -DBUILD_filters:BOOL=ON -DBUILD_features:BOOL=ON -DBUILD_kdtree:BOOL=ON -DBUILD_common:BOOL=ON -DBUILD_ml:BOOL=ON -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DBoost_INCLUDE_DIR=$(INSTALL_DIR)/myports/boost_1_60_0 && make && make install && cd ../.. && touch $@

flann-1.8.4-src.zip:
	wget http://www.cs.ubc.ca/research/flann/uploads/FLANN/$@

flann.installed:flann-1.8.4-src.zip
	unzip $< && cd flann-1.8.4-src && mkdir -p build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ && make && make install && cd ../.. && touch $@

eigen.3.2.8.tar.bz2:
	wget --no-check-certificate http://bitbucket.org/eigen/eigen/get/3.2.8.tar.bz2 -O $@
eigen.installed: eigen.3.2.8.tar.bz2
	tar xaf $< && cd eigen-* && mkdir -p build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) && make && make install && cd ../.. && touch $@

boost_1_60_0.tar.gz:
	wget --no-check-certificate http://sourceforge.net/projects/boost/files/boost/1.60.0/$@
boost.installed: boost_1_60_0.tar.gz
	tar xaf $< && cd  boost_1_60_0 && ./bootstrap.sh && ./b2 && cd .. && touch $@

OpenSceneGraph-2.8.5.zip:
	wget http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-2.8.5/source/OpenSceneGraph-2.8.5.zip
OpenSceneGraph.installed: OpenSceneGraph-2.8.5.zip
	unzip $< && cd OpenSceneGraph-2.8.5 && ./configure --prefix=$(INSTALL_DIR) CC=gcc PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib"  && $(MAKE) uninstall; $(MAKE) && ln -sf `which libtool` . && $(MAKE) install && cd .. && touch $@


ossim-$(ossim_ver).tar.gz:
	wget http://download.osgeo.org/ossim/source/ossim-$(ossim_ver)/ossim-$(ossim_ver).tar.gz
ossim.installed: ossim-$(ossim_ver).tar.gz
	$(call compile,--with-libtiff=$(INSTALL_DIR) --with-geotiff=$(INSTALL_DIR) --with-openthreads=$(INSTALL_DIR))
#	tar xaf $< && cd ossim-1.8.16/ossim && ./configure --prefix=$(INSTALL_DIR) --enable-sharedOssimLibraries --enable-staticOssimLibraries --enable-singleSharedOssimLibrary --enable-singleStaticOssimLibrary --enable-staticOssimApps --with-libtiff=$(INSTALL_DIR) --with-geotiff=$(INSTALL_DIR) --with-openthreads=$(INSTALL_DIR) CC=gcc PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib"  CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" CPPFLAGS="$(CFLAGS)" F77=gfortran FFLAGS="$(CFLAGS)" && gmake uninstall; gmake -j20 && ln -sf `which libtool` . && gmake install && cd .. && touch $@

GraphicsMagick-$(graphicmagick_ver).tar.bz2:
	wget http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/$(graphicmagick_ver)/GraphicsMagick-$(graphicmagick_ver).tar.bz2
graphicsmagick.installed: GraphicsMagick-$(graphicmagick_ver).tar.bz2
	$(call compile,--enable-shared --with-quantum-depth=16 --disable-static --with-magick-plus-plus=yes)

octave-$(octave_ver).tar.bz2:
	wget ftp://ftp.gnu.org/gnu/octave/octave-$(octave_ver).tar.bz2
octave.installed: octave-$(octave_ver).tar.bz2 graphicsmagick.installed
	$(call compile,--disable-gui --disable-readline)


#	tar xaf $< && cd $(basename $(basename $<)) && export CC=gcc && export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && export LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64" && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && export F77=gfortran && export FFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) $1  && gmake uninstall; gmake && ln -sf `which libtool` . && gmake install && cd .. && touch $@

dropbear-2014.66.tar.bz2:
	wget http://matt.ucc.asn.au/dropbear/releases/dropbear-2014.66.tar.bz2
dropbear.installed: dropbear-2014.66.tar.bz2
	$(call compile)
openssl-0.9.8zc.tar.gz:
	wget http://www.openssl.org/source/openssl-0.9.8zc.tar.gz
openssl.installed: openssl-0.9.8zc.tar.gz
	tar xaf $< && cd $(basename $(basename $<)) && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && ./Configure linux-x86_64 shared zlib --prefix=$(INSTALL_DIR) && make && make install && cd .. && touch $@
openssh-$(openssh_ver).tar.gz:
	wget http://www.ftp.ne.jp/OpenBSD/OpenSSH/portable/openssh-$(openssh_ver).tar.gz
openssh.installed: openssh-$(openssh_ver).tar.gz openssl.installed
	$(call compile,--with-shared --with-libs --with-pie)

sip-$(sip_version).tar.gz:
	wget http://sourceforge.net/projects/pyqt/files/sip/sip-$(sip_version)/sip-$(sip_version).tar.gz
sip.installed: sip-$(sip_version).tar.gz
	tar xaf $< && cd $(basename $(basename $<)) && python configure.py && make && make install && cd .. && touch $@
PyQt-x11-gpl-$(pyqt_version).tar.gz:
	wget http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-$(pyqt_version)/PyQt-x11-gpl-$(pyqt_version).tar.gz
pyqt.installed: PyQt-x11-gpl-$(pyqt_version).tar.gz sip.installed
	tar xaf $< && cd $(basename $(basename $<)) && python configure.py && make && make install && cd .. && touch $@
QScintilla-gpl-2.8.4.tar.gz:
	wget http://sourceforge.net/projects/pyqt/files/QScintilla2/QScintilla-2.8.4/QScintilla-gpl-2.8.4.tar.gz
QScintilla.installed: QScintilla-gpl-2.8.4.tar.gz sip.installed
	tar xaf $< && cd $(basename $(basename $<))/Qt4Qt5 && qmake qscintilla.pro && make && make install && cd ../Python && python configure.py && make && make install && cd ../../ && touch $@

qwt-$(qwt_ver).tar.bz2:
	wget http://sourceforge.net/projects/qwt/files/qwt/$(qwt_ver)/qwt-$(qwt_ver).tar.bz2
qwt.installed: qwt-$(qwt_ver).tar.bz2
	tar xaf $< && cd $(basename $(basename $<)) && sed -i 's#QWT_INSTALL_PREFIX *= .*#QWT_INSTALL_PREFIX = $(INSTALL_DIR)#g' qwtconfig.pri && qmake qwt.pro && make && make install && cd $$OLDPWD && touch $@

gsl-$(gsl_version).tar.gz:
	wget http://ftp.yzu.edu.tw/gnu/gsl/gsl-$(gsl_version).tar.gz
gsl.installed: gsl-$(gsl_version).tar.gz
	$(call compile)
spatialindex-src-1.8.5.tar.gz:
	wget http://download.osgeo.org/libspatialindex/spatialindex-src-1.8.5.tar.gz
spatialindex.installed: spatialindex-src-1.8.5.tar.gz
	tar xaf $< && cd $(basename $(basename $<)) && export CFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib64" && export CXXFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib64" && export CPPFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib64" && export LDFLAGS="-L$(INSTALL_DIR)/lib64" && ./configure --prefix=$(INSTALL_DIR) $1 && make && make install && cd .. && touch $@
qgis-$(qgis_ver).tar.bz2:
	wget http://qgis.org/downloads/qgis-$(qgis_ver).tar.bz2
0001-Fix-build-failure-with-gcc-4.4-bug-10762.patch:
	wget http://hub.qgis.org/attachments/download/7755/0001-Fix-build-failure-with-gcc-4.4-bug-10762.patch
qgis.installed: qgis-$(qgis_ver).tar.bz2 qt.installed pyqt.installed gsl.installed QScintilla.installed qwt.installed spatialindex.installed bison.installed flex.installed gdal.installed 0001-Fix-build-failure-with-gcc-4.4-bug-10762.patch
	tar xaf $< && cd $(basename $(basename $<)) && patch -p1 < ../0001-Fix-build-failure-with-gcc-4.4-bug-10762.patch && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && cmake -DSQLITE3_INCLUDE_DIR=/dias/users/miyazaki.h.u-tokyo/apps/include -DSQLITE3_LIBRARY=/dias/users/miyazaki.h.u-tokyo/apps/lib/libsqlite3.so -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) . && make && make install

qt-everywhere-opensource-src-4.7.4.tar.gz:
	wget http://download.qt-project.org/archive/qt/4.7/qt-everywhere-opensource-src-4.7.4.tar.gz
qt.installed: qt-everywhere-opensource-src-4.7.4.tar.gz
	$(call compile,-opensource)
icewm-$(icewm_ver).tar.gz:
	wget http://downloads.sourceforge.net/project/icewm/icewm-1.3/$(icewm_ver)/icewm-$(icewm_ver).tar.gz
icewm.installed: icewm-$(icewm_ver).tar.gz
	$(call compile)
libxslt-$(libxslt_ver).tar.gz:
	wget http://xmlsoft.org/sources/libxslt-$(libxslt_ver).tar.gz
libxslt.installed: libxslt-$(libxslt_ver).tar.gz
	$(call compile)
#proj-$(proj_ver).tar.gz:
#	wget http://download.osgeo.org/proj/proj-$(proj_ver).tar.gz
#proj.installed: proj-$(proj_ver).tar.gz
#	$(call compile,--enable-shared)
geos-$(geos_ver).tar.bz2:
	wget http://download.osgeo.org/geos/geos-$(geos_ver).tar.bz2
geos.installed: geos-$(geos_ver).tar.bz2 proj.installed
	$(call compile,)
fftw-$(fftw_ver).tar.gz:
	wget http://www.fftw.org/fftw-$(fftw_ver).tar.gz
fftw.installed: fftw-$(fftw_ver).tar.gz
	$(call compile)
libkml-1.2.0.tar.gz:
	wget --no-check-certificate https://libkml.googlecode.com/files/libkml-1.2.0.tar.gz
libkml.installed: libkml-1.2.0.tar.gz curl.installed
	tar xaf $< && cd $(basename $(basename $<)) \
	&& export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig:$(INSTALL_DIR)/share/pkgconfig \
	&& export CFLAGS="-O3 $(m64_FLAG) -fPIC -I$(INSTALL_DIR)/include -I/usr/include -I/usr/local/include -L$(INSTALL_DIR)/lib -Wno-long-long" \
	&& export CXXFLAGS="-O3 $(m64_FLAG) -fPIC -I$(INSTALL_DIR)/include -I/usr/include -I/usr/local/include -Wno-long-long -Wno-unused-result" \
	&& export CPPFLAGS="-O3 $(m64_FLAG) -fPIC -I$(INSTALL_DIR)/include -I/usr/local/include -I/usr/include -Wno-long-long -Wno-unused-result" \
	&& export LDFLAGS="$(m64_FLAG) -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib" \
	&& ./configure --prefix=$(INSTALL_DIR) $1 && sed -i 's/#include <sys\/stat.h>/#include <sys\/stat.h>\n#include <unistd.h>\n#include <sys\/unistd.h>/g' src/kml/base/file_posix.cc && make uninstall; make && make install && cd .. && touch $@

sqlite-autoconf-$(sqlite_ver).tar.gz:
	wget http://www.sqlite.org/2015/$@
sqlite.installed: sqlite-autoconf-$(sqlite_ver).tar.gz
	$(call compile,)
libspatialite-$(libspatialite_ver).tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/libspatialite-sources/$@
libspatialite.installed: libspatialite-$(libspatialite_ver).tar.gz sqlite.installed freexl.installed geos.installed
	rm -rf $(INSTALL_DIR)/lib/libspatialite.* $(INSTALL_DIR)/include/spatialite $(INSTALL_DIR)/include/spatialite.h
	$(call compile,--disable-mathsql --with-geosconfig=$(INSTALL_DIR)/bin/geos-config --disable-examples LIBXML2_LIBS="-lxml2" LIBXML2_CFLAGS="-I$(INSTALL_DIR)/include/libxml2 -L$(INSTALL_DIR)/lib -lxml2" CFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/geos" CXXFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/geos" CPPFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/geos" LDFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/geos")
freexl-$(freexl_ver).tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/freexl-sources/$@
freexl.installed: freexl-$(freexl_ver).tar.gz
	$(call compile)
readosm-1.0.0b.tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/readosm-sources/$@
readosm.installed: readosm-1.0.0b.tar.gz
	$(call compile)
spatialite-tools-$(spatialite-tools_ver).tar.gz: 
	wget http://www.gaia-gis.it/gaia-sins/spatialite-tools-sources/spatialite-tools-$(spatialite-tools_ver).tar.gz
spatialite-tools.installed: spatialite-tools-$(spatialite-tools_ver).tar.gz libspatialite.installed freexl.installed readosm.installed
	$(call compile,CFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib -lspatialite" CXXFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib -lspatialite" PKG_CONFIG_PATH=$(shell pwd)/libspatialite-$(libspatialite_ver):$(shell pwd)/freexl-$(freexl_ver):$(shell pwd)/readosm-1.0.0b)
postgresql_ver = 9.1.20
postgresql-$(postgresql_ver).tar.bz2:
	wget http://ftp.postgresql.org/pub/source/v$(postgresql_ver)/postgresql-$(postgresql_ver).tar.bz2
postgresql.installed: postgresql-$(postgresql_ver).tar.bz2 texinfo.installed readline.installed
	$(call compile)
postgis_ver = 2.1.8
postgis-$(postgis_ver).tar.gz:
	wget http://download.osgeo.org/postgis/source/postgis-$(postgis_ver).tar.gz
postgis.installed: postgis-$(postgis_ver).tar.gz postgresql.installed proj.installed geos.installed
	$(call compile,--with-projdir=$(INSTALL_DIR))
jpegsrc.v$(jpeg_ver).tar.gz:
	wget http://www.ijg.org/files/jpegsrc.v$(jpeg_ver).tar.gz
jpeg.installed: jpegsrc.v$(jpeg_ver).tar.gz
	tar xaf $< && cd jpeg-$(jpeg_ver) && ./configure --prefix=$(INSTALL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" && make && make install && cd .. && touch $@
zlib-$(zlib_ver).tar.gz:
	wget http://zlib.net/zlib-$(zlib_ver).tar.gz
zlib.installed: zlib-$(zlib_ver).tar.gz
	$(call compile)
szip-2.1.tar.gz:
	wget http://www.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar.gz
szip.installed: szip-2.1.tar.gz jpeg.installed
	$(call compile,--enable-encoding)

hdf-$(hdf4_ver).tar.gz:
	wget http://www.hdfgroup.org/ftp/HDF/releases/HDF$(hdf4_ver)/src/hdf-$(hdf4_ver).tar.gz
hdf4.static.installed: hdf-$(hdf4_ver).tar.gz szip.installed jpeg.installed zlib.installed
	$(call compile,--enable-static-exec --with-zlib=$(INSTALL_DIR) --with-szlib=$(INSTALL_DIR) --with-jpeg=$(INSTALL_DIR) --prefix=$(INSTALL_DIR)/hdf4-static CFLAGS="-O3 -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib" CXXFLAGS="-O3 -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib")
hdf4.shared.installed: hdf-$(hdf4_ver).tar.gz szip.installed jpeg.installed zlib.installed bison.installed flex.installed
	$(call compile, --enable-shared --disable-fortran --with-szlib=$(INSTALL_DIR) --with-jpeg=$(INSTALL_DIR))

openjpeg-read-only:
	svn checkout http://openjpeg.googlecode.com/svn/tags/version.2.0.1 openjpeg-read-only
openjpeg.installed: openjpeg-read-only
	cd openjpeg-read-only && cmake -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ && make && make install && cd .. && touch $@
jasper-1.900.1.zip:
	wget http://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip
jasper-1.900.1.uuid.tar.gz:
	wget ftp://ftp.remotesensing.org/gdal/jasper-1.900.1.uuid.tar.gz
jasper.installed: jasper-1.900.1.uuid.tar.gz
	$(call compile)
epsilon-0.9.2.tar.gz:
	wget http://sourceforge.net/projects/epsilon-project/files/epsilon/0.9.2/epsilon-0.9.2.tar.gz
epsilon.installed: epsilon-0.9.2.tar.gz popt.installed
	$(call compile)
popt-1.14.tar.gz:
	wget http://rpm5.org/files/popt/popt-1.14.tar.gz
popt.installed:popt-1.14.tar.gz
	$(call compile,)

expat-$(expat_ver).tar.gz:
	wget http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz
expat.installed: expat-$(expat_ver).tar.gz
	$(call compile,--enable-shared --host=`uname -m` CFLAGS="-fPIC -shared")
Python-$(python_ver).tar.xz:
	wget --no-check-certificate http://www.python.org/ftp/python/$(python_ver)/Python-$(python_ver).tar.xz
python.installed: Python-$(python_ver).tar.xz
	$(call compile,--enable-shared)

grass-$(grass_ver).tar.gz:
	wget http://grass.osgeo.org/grass64/source/grass-$(grass_ver).tar.gz
grass.installed: grass-$(grass_ver).tar.gz gdal.installed postgresql.installed sqlite.installed fftw.installed geos.installed proj.installed
	$(call compile, --with-cxx --with-postgres --with-sqlite --with-blas --with-lapack --with-fftw --with-fftw-includes=$(INSTALL_DIR)/include --with-fftw-libs=$(INSTALL_DIR)/lib --with-geos --with-cairo --with-gdal=$(INSTALL_DIR)/bin/gdal-config --with-proj-includes=$(INSTALL_DIR)/include --with-proj-libs=$(INSTALL_DIR)/lib --with-proj-share=$(INSTALL_DIR)/share/proj --with-postgres-includes=$(INSTALL_DIR)/include --with-postgres-libs=$(INSTALL_DIR)/lib --without-tcltk --enable-largefile  --with-python --without-wxwidgets)

mapserver-$(mapserver_ver).tar.gz:
	wget http://download.osgeo.org/mapserver/mapserver-$(mapserver_ver).tar.gz
mapserver.installed: mapserver-$(mapserver_ver).tar.gz gdal.installed curl.installed expat.installed postgis.installed pcre.installed
	tar xaf $<
	cd mapserver-$(mapserver_ver) && mkdir -p build && cd build && cmake -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) -DWITH_CLIENT_WFS=ON -DWITH_CLIENT_WMS=ON -DWITH_CURL=ON -DWITH_JAVA=OFF -DWITH_GD=OFF -DWITH_RSVG=0 -DWITH_FRIBIDI=0 -DWITH_FCGI=0 .. && make && make install && cd ../../ && touch $@

gctpc20.tar.Z:
	wget http://www.nco.ncep.noaa.gov/pmb/codes/nwprod/util/sorc/wgrib2.cd/grib2/gctpc20.tar.Z
gctpc20.installed: gctpc20.tar.Z
	tar xaf $< && cd gctpc/source && make && mv geolib.a $(INSTALL_DIR)/lib/libgctp.a && gcc -shared -fPIC -o libgctp.so *.c && mv libgctp.so $(INSTALL_DIR)/lib/ && cd $$OLDPWD && touch $@

HDF-EOS2.19v1.00.tar.Z:
	wget -nc ftp://edhs1.gsfc.nasa.gov/edhs/hdfeos/latest_release/HDF-EOS2.19v1.00.tar.Z
HDF-EOS2.installed: HDF-EOS2.19v1.00.tar.Z szip.installed hdf4.static.installed
	tar xaf $< && cd hdfeos && ./configure CC=$(INSTALL_DIR)/bin/h4cc LDFLAGS=-L$(INSTALL_DIR)/lib --with-szlib=$(INSTALL_DIR) --with-hdf4=$(INSTALL_DIR)/hdf4-static --prefix=$(INSTALL_DIR) && make && make install && cd .. && touch $@

ledaps-read-only:
	svn checkout http://ledaps.googlecode.com/svn/releases/version_1.3.1 ledaps-read-only
ledaps.installed: libgeotiff.installed gctpc20.installed hdf4.static.installed HDF-EOS2.installed szip.installed
	cd ledaps-read-only/ledapsSrc/src && export HDFEOS_GCTPINC=$(INSTALL_DIR)/include/gctp &&export HDFEOS_GCTPLIB=$(INSTALL_DIR)/lib && export TIFFINC=/usr/include && export TIFFLIB=/usr/lib && export GEOTIFF_INC=$(INSTALL_DIR)/include && export GEOTIFF_LIB=$(INSTALL_DIR)/lib && export HDFINC=$(INSTALL_DIR)/hdf4-static/include && export HDFLIB=$(INSTALL_DIR)/hdf4-static/lib && export HDFEOS_INC=$(INSTALL_DIR)/include/hdfeos && export HDFEOS_LIB=$(INSTALL_DIR)/lib && export JPEGINC=$(INSTALL_DIR)/include && export JPEGLIB=$(INSTALL_DIR)/lib && export BIN=$(INSTALL_DIR)/bin/ledaps && export SZIPINC=$(INSTALL_DIR)/include && export SZIPLIB=$(INSTALL_DIR)/lib && find -type f | grep Makefile$ | xargs -n 1 sed -i 's/-ldf /-ldf -lsz /g' && make && make install && cd $$OLDPWD && touch $@

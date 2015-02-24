INSTALL_DIR = $(HOME)/apps
CFLAGS = -O3 -fPIC -I$(INSTALL_DIR)/include -I$(INSTALL_DIR)/include/python2.7 -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib
# -mtune=native
compile = tar xaf $< && cd $(basename $(basename $<)) && export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig:$(INSTALL_DIR)/share/pkgconfig && export LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64" && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && export F77=gfortran && export FFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) $1 && make uninstall; make && make install && cd .. && touch $@

texinfo_ver = 5.2
pcre_ver = 8.36
zlib_ver = 1.2.8
xz_version = 5.0.8
bash_ver = 4.3.30
gcc_ver = 4.8.3
bison_ver = 3.0.2
flex_ver = 2.5.39
raptor_ver = 2.0.15

w3m_version = 0.5.3
wget_ver = 1.16.1
openssh_ver = 6.7p1
rsync_ver = 3.1.1
curl_ver = 7.38.0
lynx_ver = 2.8.8
svn_ver = 1.8.11

sqlite_ver = 3080802
gdal_ver = 1.11.0
GDAL_OPT =  --with-fgdb=$(INSTALL_DIR) 
expat_ver = 2.1.0
proj_ver = 4.8.0
geos_ver = 3.4.2
grass_ver = 6.4.4
mapserver_ver = 6.4.1
python_ver = 2.7.8
fftw_ver = 3.3.4
icewm_ver = 1.3.3
qgis_ver = 2.6.1
pyqt_version = 4.11.3
sip_version = 4.16.4
gsl_version = 1.16
qiv_version = 2.3.1
qwt_ver = 6.0.2

libxml2_ver = 2.9.1
libxslt_ver = 1.1.28
libspatialite_ver = 4.2.0
spatialite-tools_ver = 4.2.0
freexl_ver = 1.0.0h
hdf4_ver = 4.2.10
jpeg_ver = 9a

nettle-2.7.1.tar.gz:
	wget http://ftp.gnu.org/gnu/nettle/nettle-2.7.1.tar.gz
nettle.installed: nettle-2.7.1.tar.gz
	$(call compile,--enable-shared)
gnutls-3.3.9.tar.xz:
	wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.3/gnutls-3.3.9.tar.xz
gnutls.installed: gnutls-3.3.9.tar.xz nettle.installed gmp.installed
	$(call compile,)

wget-1.16.1.tar.xz:
	wget http://ftp.gnu.org/gnu/wget/wget-1.16.1.tar.xz
wget.installed: wget-1.16.1.tar.xz gnutls.installed
	$(call compile,)
raptor2-2.0.15.tar.gz:
	wget http://download.librdf.org/source/raptor2-2.0.15.tar.gz
raptor.installed: raptor2-2.0.15.tar.gz
	$(call compile)

lynx$(lynx_ver).tar.bz2:
	wget http://lynx.isc.org/lynx$(lynx_ver)/lynx$(lynx_ver).tar.bz2
lynx.installed:lynx$(lynx_ver).tar.bz2 openssl.installed
	tar xaf $< && cd lynx2-8-8 && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) --with-ssl=$(INSTALL_DIR)/lib --enable-persistent-cookies && make && make install && cd .. && touch $@

w3m.installed: w3m-$(w3m_version).tar.gz w3m-bdwgc72.diff w3m-0.5.3-button.patch
	tar xaf $< && cd $(basename $(basename $<)) && patch -p1 < ../w3m-bdwgc72.diff && patch -p1 < ../w3m-0.5.3-button.patch && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && ./configure --with-ssl --prefix=$(INSTALL_DIR) --with-termlib="ncurses terminfo termcap" --enable-image=no --disable-xface --disable-mouse && make && make install && cd .. && touch $@
w3m-bdwgc72.diff:
	wget http://sourceforge.net/p/w3m/patches/_discuss/thread/0f07465b/645b/attachment/w3m-bdwgc72.diff
w3m-0.5.3-button.patch:
	wget --no-check-certificate https://raw.githubusercontent.com/Vliegendehuiskat/slackbuilds/master/network/w3m/patches/w3m-0.5.3-button.patch

subversion-$(svn_ver).tar.bz2:
	wget http://mirror.symnds.com/software/Apache/subversion/subversion-$(svn_ver).tar.bz2	
subversion.installed: subversion-$(svn_ver).tar.bz2
	$(call compile)

gtk+-3.14.6.tar.xz:
	wget http://ftp.gnome.org/pub/gnome/sources/gtk+/3.14/gtk+-3.14.6.tar.xz
gtk+.installed: gtk+-3.14.6.tar.xz
	$(call compile)
qiv-2.3.1.tgz:
	wget http://spiegl.de/qiv/download/qiv-2.3.1.tgz
qiv.installed: qiv-2.3.1.tgz gtk+.installed
	tar xaf $< && cd qiv-2.3.1 && make && make install && cd .. && touch $@

gcc-$(gcc_ver).tar.bz2:
	wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-$(gcc_ver)/gcc-$(gcc_ver).tar.bz2
gcc.installed: gcc-$(gcc_ver).tar.bz2 gmp.installed mpfr.installed mpc.installed
	tar xaf $< && mkdir -p gcc-build && cd gcc-build && ../gcc-$(gcc_ver)/configure --prefix=$(INSTALL_DIR) --with-gmp=$(INSTALL_DIR) --with-mpfr=$(INSTALL_DIR) --with-mpc=$(INSTALL_DIR) --disable-libjava && make && make install

gmp_ver = 6.0.0
gmp-$(gmp_ver).tar.xz:
	wget https://gmplib.org/download/gmp/gmp-$(gmp_ver).tar.xz
#	wget ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
gmp.installed: gmp-$(gmp_ver).tar.xz
	$(call compile)

#tar xaf $< && cd $(basename $(basename $<)) && export CFLAGS="-I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib" && export CXXFLAGS="-I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib" && export CPPFLAGS="-I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib" && ./configure --prefix=$(INSTALL_DIR) $1 && make && make install && cd .. && touch $@
mpfr-2.4.2.tar.bz2:
	wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpfr-2.4.2.tar.bz2
mpfr.installed: mpfr-2.4.2.tar.bz2
	$(call compile)
mpc-0.8.1.tar.gz:
	wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpc-0.8.1.tar.gz
mpc.installed: mpc-0.8.1.tar.gz
	$(call compile)
bison-$(bison_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/bison/bison-$(bison_ver).tar.xz
bison.installed: bison-$(bison_ver).tar.xz
	$(call compile)
flex-$(flex_ver).tar.xz:
	wget http://sourceforge.net/projects/flex/files/flex-$(flex_ver).tar.xz
flex.installed: flex-$(flex_ver).tar.xz
	$(call compile)
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
bash-$(bash_ver).tar.gz:
	wget http://ftp.gnu.org/gnu/bash/bash-$(bash_ver).tar.gz
bash.installed: bash-$(bash_ver).tar.gz
	$(call compile)

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
libxml2-$(libxml2_ver).tar.gz:
	wget http://xmlsoft.org/sources/libxml2-$(libxml2_ver).tar.gz
libxml2.installed: libxml2-$(libxml2_ver).tar.gz python.installed
	$(call compile)
libxslt-$(libxslt_ver).tar.gz:
	wget http://xmlsoft.org/sources/libxslt-$(libxslt_ver).tar.gz
libxslt.installed: libxslt-$(libxslt_ver).tar.gz libxml2.installed
	$(call compile)
rsync-$(rsync_ver).tar.gz:
	wget http://rsync.samba.org/ftp/rsync/src/rsync-$(rsync_ver).tar.gz
rsync.installed: rsync-$(rsync_ver).tar.gz
	$(call compile)
texinfo-$(texinfo_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/texinfo/texinfo-$(texinfo_ver).tar.xz
texinfo.installed: texinfo-$(texinfo_ver).tar.xz
	$(call compile)
curl-$(curl_ver).tar.lzma:
	wget http://curl.haxx.se/download/curl-$(curl_ver).tar.lzma
curl.installed: curl-$(curl_ver).tar.lzma xz.installed
	$(call compile)
xz-$(xz_version).tar.bz2:
	wget http://tukaani.org/xz/xz-$(xz_version).tar.bz2
xz.installed: xz-$(xz_version).tar.bz2
	$(call compile)
pcre-$(pcre_ver).tar.bz2:
	wget http://downloads.sourceforge.net/project/pcre/pcre/$(pcre_ver)/pcre-$(pcre_ver).tar.bz2
pcre.installed: pcre-$(pcre_ver).tar.bz2
	$(call compile)
proj-$(proj_ver).tar.gz:
	wget http://download.osgeo.org/proj/proj-$(proj_ver).tar.gz
proj.installed: proj-$(proj_ver).tar.gz
	$(call compile)
geos-$(geos_ver).tar.bz2:
	wget http://download.osgeo.org/geos/geos-$(geos_ver).tar.bz2
geos.installed: geos-$(geos_ver).tar.bz2
	$(call compile)
fftw-$(fftw_ver).tar.gz:
	wget http://www.fftw.org/fftw-$(fftw_ver).tar.gz
fftw.installed: fftw-$(fftw_ver).tar.gz
	$(call compile)
libkml-1.2.0.tar.gz:
	wget https://libkml.googlecode.com/files/libkml-1.2.0.tar.gz
libkml.installed: libkml-1.2.0.tar.gz curl.installed
	tar xaf $< && cd $(basename $(basename $<)) && export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig:$(INSTALL_DIR)/share/pkgconfig && export LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64" && export CFLAGS="$(CFLAGS) -Wno-long-long" && export CXXFLAGS="$(CFLAGS) -Wno-long-long" && export CPPFLAGS="$(CFLAGS) -Wno-long-long" && export F77=gfortran && export FFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) $1 && sed -i 's/#include <sys\/stat.h>/#include <sys\/stat.h>\n#include <unistd.h>/g' src/kml/base/file_posix.cc && make uninstall; make && make install && cd .. && touch $@

libgeotiff-1.4.0.tar.gz:
	wget http://download.osgeo.org/geotiff/libgeotiff/libgeotiff-1.4.0.tar.gz
libgeotiff.installed: libgeotiff-1.4.0.tar.gz jpeg.installed zlib.installed
	$(call compile,LIBS=-lproj --with-zlib --with-jpeg)
sqlite-autoconf-$(sqlite_ver).tar.gz:
	wget http://www.sqlite.org/2015/sqlite-autoconf-$(sqlite_ver).tar.gz
sqlite.installed: sqlite-autoconf-$(sqlite_ver).tar.gz
	$(call compile,--enable-threadsafe=no)
libspatialite-$(libspatialite_ver).tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-$(libspatialite_ver).tar.gz
libspatialite.installed: libspatialite-$(libspatialite_ver).tar.gz sqlite.installed freexl.installed geos.installed libxml2.installed
	rm -rf $(INSTALL_DIR)/lib/libspatialite.* $(INSTALL_DIR)/include/spatialite $(INSTALL_DIR)/include/spatialite.h
	$(call compile)
freexl-$(freexl_ver).tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/freexl-sources/freexl-$(freexl_ver).tar.gz
freexl.installed: freexl-$(freexl_ver).tar.gz
	$(call compile)
readosm-1.0.0b.tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/readosm-sources/readosm-1.0.0b.tar.gz
readosm.installed: readosm-1.0.0b.tar.gz
	$(call compile)
spatialite-tools-$(spatialite-tools_ver).tar.gz: 
	wget http://www.gaia-gis.it/gaia-sins/spatialite-tools-sources/spatialite-tools-$(spatialite-tools_ver).tar.gz
spatialite-tools.installed: spatialite-tools-$(spatialite-tools_ver).tar.gz libspatialite.installed freexl.installed readosm.installed
	$(call compile,CFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib -lspatialite" CXXFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib -lspatialite" PKG_CONFIG_PATH=$(shell pwd)/libspatialite-$(libspatialite_ver):$(shell pwd)/freexl-$(freexl_ver):$(shell pwd)/readosm-1.0.0b)
postgresql-9.1.14.tar.bz2:
	wget http://ftp.postgresql.org/pub/source/v9.1.14/postgresql-9.1.14.tar.bz2
postgresql.installed: postgresql-9.1.14.tar.bz2 texinfo.installed
	$(call compile)
postgis-1.5.8.tar.gz:
	wget http://download.osgeo.org/postgis/source/postgis-1.5.8.tar.gz
postgis.installed: postgis-1.5.8.tar.gz postgresql.installed proj.installed geos.installed
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
	cd openjpeg-read-only && cmake -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) && make && make install && cd .. && touch $@
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
	$(call compile)

expat-$(expat_ver).tar.gz:
	wget http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz
expat.installed: expat-$(expat_ver).tar.gz
	$(call compile)
Python-$(python_ver).tar.xz:
	wget https://www.python.org/ftp/python/$(python_ver)/Python-$(python_ver).tar.xz
python.installed: Python-$(python_ver).tar.xz
	$(call compile,--enable-shared)
gdal-$(gdal_ver).tar.xz:
	wget http://download.osgeo.org/gdal/$(gdal_ver)/gdal-$(gdal_ver).tar.xz

gdal.installed: gdal-$(gdal_ver).tar.xz sqlite.installed expat.installed proj.installed geos.installed openjpeg.installed python.installed libspatialite.installed curl.installed freexl.installed libkml.installed pcre.installed xz.installed hdf4.shared.installed epsilon.installed postgresql.installed jasper.installed
	$(call compile,$(GDAL_OPT) --with-pg=$(INSTALL_DIR)/bin/pg_config --with-sqlite3=$(INSTALL_DIR)/lib --with-static-proj4=$(INSTALL_DIR)/lib --with-libz=internal --with-pcraster=internal --with-png=internal --with-libtiff=internal --with-geotiff=internal --with-jpeg=internal --with-gif=internal --with-geos=$(INSTALL_DIR)/bin/geos-config --with-spatialite=$(INSTALL_DIR) --with-epsilon --with-python --with-hdf4=$(INSTALL_DIR) --with-jasper=$(INSTALL_DIR)/lib --with-expat=$(INSTALL_DIR) --with-openjpeg=$(INSTALL_DIR) --with-liblzma --with-curl=$(INSTALL_DIR)/bin --with-freexl=$(INSTALL_DIR) --with-libkml=$(INSTALL_DIR) CFLAGS="$(CFLAGS) -lspatialite" CXXFLAGS="$(CFLAGS) -lspatialite")

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

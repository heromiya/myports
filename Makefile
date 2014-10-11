INSTALL_DIR = $(HOME)/apps
CFLAGS = -O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib
# -mtune=native
compile = tar xaf $< && cd $(basename $(basename $<)) && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) $1 && make && make install && cd .. && touch $@

texinfo_ver = 5.2
curl_ver = 7.38.0
pcre_ver = 8.36
sqlite_ver = 3080600
gdal_ver = 1.11.0
GDAL_OPT =  --with-fgdb=$(INSTALL_DIR) 
expat_ver = 2.1.0
proj_ver = 4.8.0
geos_ver = 3.4.2
grass_ver = 6.4.4
mapserver_ver = 6.4.1
python_ver = 2.7.8
fftw_ver = 3.3.4

texinfo-$(texinfo_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/texinfo/texinfo-$(texinfo_ver).tar.xz
texinfo.installed: texinfo-$(texinfo_ver).tar.xz
	$(call compile)
curl-$(curl_ver).tar.lzma:
	wget http://curl.haxx.se/download/curl-$(curl_ver).tar.lzma
curl.installed: curl-$(curl_ver).tar.lzma xz.installed
	$(call compile)
xz-5.0.7.tar.bz2:
	wget http://tukaani.org/xz/xz-5.0.7.tar.bz2
xz.installed: xz-5.0.7.tar.bz2
	$(call compile)
pcre-$(pcre_ver).tar.bz2:
	wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$(pcre_ver).tar.bz2
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
libkml.installed: libkml-1.2.0.tar.gz
	$(call compile)
libgeotiff-1.4.0.tar.gz:
	wget http://download.osgeo.org/geotiff/libgeotiff/libgeotiff-1.4.0.tar.gz
libgeotiff.installed: libgeotiff-1.4.0.tar.gz jpegsrc.v9a.installed zlib.installed
	$(call compile,LIBS=-lproj --with-zlib --with-jpeg)
sqlite-autoconf-$(sqlite_ver).tar.gz:
	wget http://www.sqlite.org/2014/sqlite-autoconf-$(sqlite_ver).tar.gz
sqlite.installed: sqlite-autoconf-$(sqlite_ver).tar.gz
	$(call compile)
libspatialite-3.0.1.tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-3.0.1.tar.gz
libspatialite.installed: libspatialite-3.0.1.tar.gz sqlite.installed
	$(call compile)
freexl-1.0.0g.tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/freexl-sources/freexl-1.0.0g.tar.gz
freexl.installed: freexl-1.0.0g.tar.gz
	$(call compile)
readosm-1.0.0b.tar.gz:
	wget http://www.gaia-gis.it/gaia-sins/readosm-sources/readosm-1.0.0b.tar.gz
readosm.installed: readosm-1.0.0b.tar.gz
	$(call compile)
spatialite-tools-3.1.0.tar.gz: 
	http://www.gaia-gis.it/gaia-sins/spatialite-tools-sources/spatialite-tools-3.1.0.tar.gz
spatialite-tools.installed: spatialite-tools-3.1.0.tar.gz libspatialite.installed freexl.installed readosm.installed
	$(call compile,CFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib -lspatialite" CXXFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib -lspatialite" PKG_CONFIG_PATH=$(shell pwd)/libspatialite-3.0.1:$(shell pwd)/freexl-1.0.0g:$(shell pwd)/readosm-1.0.0b)
postgresql-9.1.14.tar.bz2:
	wget http://ftp.postgresql.org/pub/source/v9.1.14/postgresql-9.1.14.tar.bz2
postgresql.installed: postgresql-9.1.14.tar.bz2 texinfo.installed
	$(call compile)
postgis-1.5.8.tar.gz:
	wget http://download.osgeo.org/postgis/source/postgis-1.5.8.tar.gz
postgis.installed: postgis-1.5.8.tar.gz postgresql.installed proj.installed geos.installed
	$(call compile,--with-projdir=$(INSTALL_DIR))
jpegsrc.v9a.tar.gz:
	wget http://www.ijg.org/files/jpegsrc.v9a.tar.gz
jpegsrc.v9a.installed: jpegsrc.v9a.tar.gz
	tar xaf $< && cd jpeg-9a && ./configure --prefix=$(INSTALL_DIR) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" && make && make install && cd .. && touch $@
zlib-1.2.8.tar.gz:
	wget http://zlib.net/zlib-1.2.8.tar.gz
zlib.installed: zlib-1.2.8.tar.gz
	$(call compile)
#	tar xaf $< && cd $(basename $(basename $<)) && cmake . -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) && make && make install && cd .. && touch $@
szip-2.1.tar.gz:
	wget http://www.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar.gz
szip.installed: szip-2.1.tar.gz jpegsrc.v9a.installed
	$(call compile,--enable-encoding)
#	tar xaf $< && cd $(basename $(basename $<)) && cmake . -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) && make && make install && cd .. && touch $@
hdf-4.2.10.tar.bz2:
	wget http://www.hdfgroup.org/ftp/HDF/HDF_Current/src/hdf-4.2.10.tar.bz2
hdf4.static.installed: hdf-4.2.10.tar.bz2 szip.installed jpegsrc.v9a.installed zlib.installed
	$(call compile,--enable-static-exec --with-zlib=$(INSTALL_DIR) --with-szlib=$(INSTALL_DIR) --with-jpeg=$(INSTALL_DIR) --prefix=$(INSTALL_DIR)/hdf4-static CFLAGS="-O3 -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib" CXXFLAGS="-O3 -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib")
hdf4.shared.installed: hdf-4.2.10.tar.bz2 szip.installed jpegsrc.v6b.installed zlib.installed
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
epsilon.installed: epsilon-0.9.2.tar.gz
	$(call compile)
expat-$(expat_ver).tar.gz:
	wget http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz
expat.installed: expat-$(expat_ver).tar.gz
	$(call compile)
Python-$(python_ver).tar.xz:
	wget https://www.python.org/ftp/python/$(python_ver)/Python-$(python_ver).tar.xz
python.installed: Python-$(python_ver).tar.xz
	$(call compile)
gdal-$(gdal_ver).tar.xz:
	wget http://download.osgeo.org/gdal/$(gdal_ver)/gdal-$(gdal_ver).tar.xz
gdal.installed: gdal-$(gdal_ver).tar.xz sqlite.installed expat.installed proj.installed geos.installed openjpeg.installed python.installed hdf4.shared.installed libspatialite.installed jasper.installed epsilon.installed postgresql.installed curl.installed xz.installed freexl.installed libkml.installed pcre.installed
	$(call compile,$(GDAL_OPT) --with-pg=$(INSTALL_DIR)/bin/pg_config --with-sqlite3=$(INSTALL_DIR)/lib --with-static-proj4=$(INSTALL_DIR)/lib --with-libz=internal --with-pcraster=internal --with-png=internal --with-libtiff=internal --with-geotiff=internal --with-jpeg=internal --with-gif=internal --with-geos=$(INSTALL_DIR)/bin/geos-config --with-spatialite=$(INSTALL_DIR) --with-epsilon --with-python --with-hdf4=$(INSTALL_DIR) --with-jasper=$(INSTALL_DIR)/lib --with-expat=$(INSTALL_DIR) --with-openjpeg=$(INSTALL_DIR) --with-liblzma --with-curl=$(INSTALL_DIR)/bin --with-freexl=$(INSTALL_DIR) --with-libkml=$(INSTALL_DIR) CFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib -lspatialite" CXXFLAGS="-O3 -fPIC -I$(INSTALL_DIR)/include -L$(INSTALL_DIR)/lib -lspatialite")
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

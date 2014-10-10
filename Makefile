CFLAGS = -O3 -mtune=native -fPIC
compile = tar xaf $< && cd $(basename $(basename $<)) && ./configure --prefix=$(HOME)/apps $1 CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" && make && make install && cd .. && touch $@

texinfo_ver = 5.2
curl_ver = 7.38.0
pcre_ver = 8.33
sqlite_ver = 3080600
gdal_ver = 1.11.0
expat_ver = 2.1.0
proj_ver = 4.8.0
geos_ver = 3.4.2

texinfo-$(texinfo_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/texinfo/texinfo-$(texinfo_ver).tar.xz
texinfo.installed: texinfo-$(texinfo_ver).tar.xz
	$(call compile)

curl-$(curl_ver).tar.lzma:
	wget http://curl.haxx.se/download/curl-$(curl_ver).tar.lzma
curl.installed: curl-$(curl_ver).tar.lzma
	$(call compile)

pcre-$(pcre_ver).tar.bz2:
	ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$(pcre_ver).tar.bz2
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

sqlite-autoconf-$(sqlite_ver).tar.gz:
	wget http://www.sqlite.org/2014/sqlite-autoconf-$(sqlite_ver).tar.gz
sqlite.installed: sqlite-autoconf-$(sqlite_ver).tar.gz
	$(call compile)

expat-$(expat_ver).tar.gz:
	wget http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz
expat.installed: expat-$(expat_ver).tar.gz
	$(call compile)

openjpeg-read-only:
	svn checkout http://openjpeg.googlecode.com/svn/tags/version.2.0.1 openjpeg-read-only
openjpeg.installed: openjpeg-read-only
	cd openjpeg-read-only && cmake -DCMAKE_INSTALL_PREFIX=$(HOME)/apps && make && make install && cd .. && touch $@

gdal-$(gdal_ver).tar.xz:
	wget http://download.osgeo.org/gdal/$(gdal_ver)/gdal-$(gdal_ver).tar.xz
gdal.installed: gdal-$(gdal_ver).tar.xz sqlite.installed expat.installed proj.installed geos.installed openjpeg.installed
	$(call compile,--with-fgdb=$(HOME)/apps --with-sqlite3=$(HOME)/apps --with-expat=$(HOME)/apps --with-static-proj4=$(HOME)/apps/lib --with-geos=$(HOME)/apps/bin/geos-config --with-libz=internal --with-pcraster=internal --with-png=internal --with-libtiff=internal --with-geotiff=internal --with-jpeg=internal --with-gif=internal --with-python --with-openjpeg=$(HOME)/apps)

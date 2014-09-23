texinfo_ver = 5.2
curl_ver = 7.38.0
CFLAGS = -O3 -mtune=native
COMPILE = tar xaf $< && cd $(basename $(basename $<)) && ./configure --prefix=$(HOME)/apps $1 CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" && make && make install

texinfo-$(texinfo_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/texinfo/texinfo-$(texinfo_ver).tar.xz
texinfo.installed: texinfo-$(texinfo_ver).tar.xz
	$(call COMPILE)
curl-$(curl_ver).tar.lzma:
	wget http://curl.haxx.se/download/curl-$(curl_ver).tar.lzma
curl.installed: curl-$(curl_ver).tar.lzma
	$(call COMPILE)


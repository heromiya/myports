gmp_ver = 4.3.2

gmp-$(gmp_ver).tar.xz:
	wget --no-check-certificate https://gmplib.org/download/gmp/archive/gmp-$(gmp_ver).tar.xz
gmp.installed: gmp-$(gmp_ver).tar.xz
	export LD_LIBRARY_PATH= && $(call compile,--disable-assembly --enable-cxx ABI=32 CC=gcc-4.8)

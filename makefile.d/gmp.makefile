gmp_ver = 4.3.2

gmp-$(gmp_ver).tar.xz:
	wget -q  --no-check-certificate https://gmplib.org/download/gmp/archive/gmp-$(gmp_ver).tar.xz
gmp.installed: gmp-$(gmp_ver).tar.xz
	$(call compile,--enable-cxx --enable-shared)
# ABI=32 CC=/usr/bin/gcc
#export LD_LIBRARY_PATH= && 

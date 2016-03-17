libstdc++-3.0.tar.gz:
	wget -q http://ftp.tsukuba.wide.ad.jp/software/gcc/libstdc++/old-releases/$@
libstdc++.installed: libstdc++-3.0.tar.gz gcc.installed
	tar xaf libstdc++-3.0.tar.gz && cd libstdc++-3.0 
#	$(call compile)

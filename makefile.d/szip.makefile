szip-$(szip_ver).tar.gz:
	wget $(wget_opt) http://www.hdfgroup.org/ftp/lib-external/szip/$(szip_ver)/src/$@
szip.installed: szip-$(szip_ver).tar.gz jpeg.installed
	$(call compile,--enable-encoding)

cmake-$(cmake_ver).tar.gz:
	wget $(wget_opt) http://www.cmake.org/files/v3.10/$@
cmake.installed: cmake-$(cmake_ver).tar.gz
	$(call compile)

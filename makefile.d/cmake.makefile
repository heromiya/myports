cmake_ver = 3.4.3
cmake-$(cmake_ver).tar.gz:
	wget -q  --no-check-certificate http://www.cmake.org/files/v3.4/$@
cmake.installed: cmake-$(cmake_ver).tar.gz
<<<<<<< HEAD
	$(call compile)
=======
	$(call compile)
>>>>>>> 66583cc2d987e90cf8dad6a15a288513c7090447

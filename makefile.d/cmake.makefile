cmake_ver = 3.4.3
cmake-$(cmake_ver).tar.gz:
	wget -q  --no-check-certificate http://www.cmake.org/files/v3.4/$@
cmake.installed: cmake-$(cmake_ver).tar.gz
	$(compile) && touch ../$@

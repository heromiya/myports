
libkml:
	git clone https://github.com/libkml/libkml.git
libkml.installed: libkml curl.installed
	cd libkml && $(call cmake)





#	&& export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig:$(INSTALL_DIR)/share/pkgconfig \
	&& export CFLAGS="-O3 $(m64_FLAG) -fPIC -I$(INSTALL_DIR)/include -I/usr/include -I/usr/local/include -L$(INSTALL_DIR)/lib -Wno-long-long" \
	&& export CXXFLAGS="-O3 $(m64_FLAG) -fPIC -I$(INSTALL_DIR)/include -I/usr/include -I/usr/local/include -Wno-long-long -Wno-unused-result" \
	&& export CPPFLAGS="-O3 $(m64_FLAG) -fPIC -I$(INSTALL_DIR)/include -I/usr/local/include -I/usr/include -Wno-long-long -Wno-unused-result" \
	&& export LDFLAGS="$(m64_FLAG) -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib" \
	&& ./configure --prefix=$(INSTALL_DIR) $1 && make uninstall; make && make install && cd .. && touch $@

# && sed -i 's/#include <sys\/stat.h>/#include <sys\/stat.h>\n#include <unistd.h>\n#include <sys\/unistd.h>/g' src/kml/base/file_posix.cc
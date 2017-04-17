# Requires edits:
# src/interfaces/ecpg/ecpglib/misc.c: add #include <pthread.h>
# src/test/regress/pg_regress.c: add #include "pg_config.h"

#CFLAGS = -fPIC $(m64_FLAG) -std=c99 -I$(INSTALL_DIR)/include -I/usr/include
postgresql-8.4.22.tar.bz2:
	wget -q  http://ftp.postgresql.org/pub/source/v8.4.22/postgresql-8.4.22.tar.bz2
postgresql-8.4.installed: postgresql-8.4.22.tar.bz2 texinfo.installed lib/libreadline.a
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=gcc && \
	export CXX=g++ && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	./configure --prefix=$(INSTALL_DIR)/postgresql-8.4 \
	--without-readline && \
	$(MAKE) && \
	$(MAKE) install && \
	cd .. && touch $@

# CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)"
#	--enable-thread-safety \
#	export CFLAGS="$(CFLAGS)" && \
#	export CXXFLAGS="$(CFLAGS)" && \
#	export CPPFLAGS="$(CFLAGS)" && \
#	export F77=gfortran && \
#	export LDFLAGS="$(LDFLAGS)" && \
#	export FFLAGS="$(CFLAGS)" && \

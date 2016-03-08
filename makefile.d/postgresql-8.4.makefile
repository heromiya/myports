# Requires edits:
# src/interfaces/ecpg/ecpglib/misc.c: add #include <pthread.h>
# src/test/regress/pg_regress.c: add #include "pg_config.h"

postgresql-8.4.22.tar.bz2:
	wget -q  http://ftp.postgresql.org/pub/source/v8.4.22/postgresql-8.4.22.tar.bz2
postgresql-8.4.installed: postgresql-8.4.22.tar.bz2 texinfo.installed readline.installed
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=gcc-4.8 && \
	export CXX=g++-4.8 && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	export LDFLAGS="$(LDFLAGS)" && \
	export CFLAGS="$(CFLAGS)" && \
	export CXXFLAGS="$(CFLAGS)" && \
	export CPPFLAGS="$(CFLAGS)" && \
	export F77=gfortran && \
	export FFLAGS="$(CFLAGS)" && \
	./configure --prefix=$(INSTALL_DIR)/postgresql-8.4 && \
	$(MAKE) && \
	$(MAKE) install && \
	cd .. && touch $@

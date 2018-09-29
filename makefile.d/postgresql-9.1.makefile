postgresql_ver = 9.1.20
postgresql-$(postgresql_ver).tar.bz2:
	wget -q  http://ftp.postgresql.org/pub/source/v$(postgresql_ver)/postgresql-$(postgresql_ver).tar.bz2
postgresql.installed: postgresql-$(postgresql_ver).tar.bz2 texinfo.installed readline.installed
	$(call compile,CFLAGS=-I$(INSTALL_DIR)/include CXXFLAGS=-I$(INSTALL_DIR)/include LDFLAGS=-L$(INSTALL_DIR)/lib)

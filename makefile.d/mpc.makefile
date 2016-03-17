mpc_ver = 1.0.3
mpc-$(mpc_ver).tar.gz:
	wget -q  http://www.multiprecision.org/mpc/download/mpc-$(mpc_ver).tar.gz
mpc.installed: mpc-$(mpc_ver).tar.gz gmp.installed mpfr.installed
	$(call compile,--enable-shared --with-mpfr=$(INSTALL_DIR) --with-gmp=$(INSTALL_DIR))
#	ld -shared -o $(INSTALL_DIR)/lib/libmpc.so --whole-archive  $(INSTALL_DIR)/lib/libmpc.a

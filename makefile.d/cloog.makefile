cloog_ver = 0.18.0

cloog-$(cloog_ver).tar.gz:
	wget -q  -O $@ http://www.bastoul.net/cloog/pages/download/count.php3?url=./$@
cloog.installed: cloog-$(cloog_ver).tar.gz isl.installed
	$(subst tar xaf $< && cd,tar xaf $< && sed -i 's/GIT_HEAD_ID="UNKNOWN"/GIT_HEAD_ID="isl-0.11.1"/' cloog-0.18.0/isl/configure && cd,$(call compile,--with-gmp-prefix=$(INSTALL_DIR)))

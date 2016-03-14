zoo-src:
	svn checkout http://svn.zoo-project.org/svn/trunk zoo-src

zoo.installed:
	cd zoo-src/thirds/cgic206 && make
	cd zoo-src/zoo-project/zoo-kernel && autoconf && ./configure --with-proj=$(INSTALL_DIR) --with-js --with-python && make && sudo make install
	cd zoo-src/zoo-project/zoo-services/utils/registry && make && sudo cp cgi-env/* /usr/lib/cgi-bin
# --prefix=$(INSTALL_DIR)

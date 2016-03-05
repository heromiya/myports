boost_1_60_0.tar.gz:
	wget -q  --no-check-certificate http://sourceforge.net/projects/boost/files/boost/1.60.0/$@
boost.installed: boost_1_60_0.tar.gz
	tar xaf $< && cd  boost_1_60_0 && ./bootstrap.sh && ./b2 --prefix=$(INSTALL_DIR) install && touch ../$@

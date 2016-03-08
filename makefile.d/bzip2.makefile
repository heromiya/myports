bzip2-1.0.6.tar.gz:
	wget -q http://bzip.org/1.0.6/$@

bzip2.installed: bzip2-1.0.6.tar.gz
	tar xaf $< && cd bzip2-1.0.6 && make && make PREFIX=$(INSTALL_DIR) && touch ../$@

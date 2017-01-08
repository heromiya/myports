w3m_version = 0.5.3
w3m.installed: w3m-$(w3m_version).tar.gz w3m-bdwgc72.diff w3m-0.5.3-button.patch
	tar xaf $< && cd $(basename $(basename $<)) && patch -p1 < ../w3m-bdwgc72.diff && patch -p1 < ../w3m-0.5.3-button.patch && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && ./configure --with-ssl --prefix=$(INSTALL_DIR) --with-termlib="ncurses terminfo termcap" --enable-image=no --disable-xface --disable-mouse && make && make install && cd .. && touch $@
w3m-bdwgc72.diff:
	wget -q  http://sourceforge.net/p/w3m/patches/_discuss/thread/0f07465b/645b/attachment/w3m-bdwgc72.diff
w3m-0.5.3-button.patch:
	wget -q  --no-check-certificate https://raw.githubusercontent.com/Vliegendehuiskat/slackbuilds/master/network/w3m/patches/w3m-0.5.3-button.patch

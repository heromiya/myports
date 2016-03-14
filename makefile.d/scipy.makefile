scipy:
	git clone https://github.com/scipy/scipy.git
scipy.installed: scipy
	cd scipy && ./setup.py build install --prefix $(INSTALL_DIR) && cd .. && touch $@
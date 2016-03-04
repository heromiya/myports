easy_install.installed: python.installed
	wget -nc http://peak.telecommunity.com/dist/ez_setup.py && python ez_setup.py && touch $@
pip.installed: easy_install.installed
	easy_install pip && touch $@

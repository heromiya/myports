curl_ver = 7.47.1
curl-$(curl_ver).tar.gz:
	wget -q  http://www.execve.net/curl/$@
curl.installed: curl-$(curl_ver).tar.gz libssh2.installed openssl.installed
	tar xaf $< && cd curl-$(curl_ver) && $(call cmake,-DLibSSH2_DIR=$(INSTALL_DIR) )
#	$(call compile, --with-ssl=/usr )

curl_ver = 7_47_1
curl-$(curl_ver).tar.gz:
	wget -q --no-check-certificate https://github.com/curl/curl/archive/$@
curl.installed: curl-$(curl_ver).tar.gz libssh2.installed openssl.installed
	tar xaf $< && cd curl-curl-$(curl_ver) && $(call cmake,-DLibSSH2_DIR=$(INSTALL_DIR) )
#	$(call compile, --with-ssl=/usr )

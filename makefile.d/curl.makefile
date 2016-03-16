curl_ver = 7.47.1
curl-$(curl_ver).tar.gz:
	wget -q  http://www.execve.net/curl/$@
curl.installed: curl-$(curl_ver).tar.gz libssl.so
	tar xaf $< && cd curl-$(curl_ver) && $(call cmake)
#	$(call compile, --with-ssl=/usr )

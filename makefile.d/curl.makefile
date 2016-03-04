curl_ver = 7.41.0
curl-$(curl_ver).tar.gz:
	wget http://www.execve.net/curl/$@
curl.installed: curl-$(curl_ver).tar.gz
	$(call compile)

curl_ver = 7.53.1
curl-$(curl_ver).tar.bz2:
	wget -q -nc https://curl.haxx.se/download/$@
#	wget -q --no-check-certificate https://github.com/curl/curl/archive/$@
curl.installed: curl-$(curl_ver).tar.bz2 libssh2.installed openssl.installed
	$(call compile, --with-ssl=$(INSTALLED_DIR) --without-libssh2)


#tar xaf $< && cd curl-curl-$(curl_ver) && \
#	sed -i 's/#    error "strerror_r MUST be either POSIX, glibc or vxworks-style"//' lib/strerror.c && \
#	$(call cmake,-DLibSSH2_DIR=$(INSTALL_DIR) -DCMAKE_SHARED_LINKER_FLAGS= -DCMAKE_STATIC_LINKER_FLAGS="$(LDFLAGS) -static" -DCMAKE_C_FLAGS= -DCMAKE_CXX_FLAGS= -DCURL_STATICLIB=ON )


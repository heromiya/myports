texinfo_ver = 5.2
pcre_ver = 8.36
zlib_ver = 1.2.8
xz_ver = 5.0.8
bash_ver = 4.3.30
bison_ver = 3.0.2
flex_ver = 2.5.39
raptor_ver = 2.0.15
emacs_ver = 24.4
screen_ver = 4.2.1
cmake_ver = 3.1.3
w3m_version = 0.5.3
wget_ver = 1.16.1
openssh_ver = 6.7p1
rsync_ver = 3.1.1
curl_ver = 7.41.0
lynx_ver = 2.8.8
subversion_ver = 1.8.11
neon_ver = 0.30.1
serf_ver = 1.3.8
apr_ver = 1.5.1
apr-util_ver = 1.5.4
tar_ver =  1.28
glibc_ver = 2.21
gzip_ver = 1.3.13
iojs_ver = 2.4.0
parallel_ver = 20151122
binutils_ver = 2.25.1
openthreads_ver = 

gcc_ver = 4.9.3
gmp_ver = 4.3.2
mpfr_ver = 3.1.3
isl_ver = 0.12.2
cloog_ver = 0.18.0
ppl_ver = 0.10.2

nettle_ver = 2.0

make_ver = 4.1
libtool_ver = 2.4.6

libtool-$(libtool_ver).tar.gz:
	wget ftp://ftp.gnu.org/gnu/libtool/$@
libtool.installed: libtool-$(libtool_ver).tar.gz
	$(call compile)

make-$(make_ver).tar.bz2:
	wget http://ftp.gnu.org/gnu/make/make-$(make_ver).tar.bz2
make.installed: make-$(make_ver).tar.bz2
	$(call compile)

readline-6.3.tar.gz:
	wget ftp://ftp.cwru.edu/pub/bash/readline-6.3.tar.gz
readline.installed: readline-6.3.tar.gz
	$(call compile,--disable-shared)

gcc-$(gcc_ver).tar.bz2:
	wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-$(gcc_ver)/gcc-$(gcc_ver).tar.bz2
gcc.installed: gcc-$(gcc_ver).tar.bz2 
	$(subst ./configure,../gcc-$(gcc_ver)/configure,$(subst tar xaf $< && cd $(basename $(basename $<)),tar xaf $< && $(basename $(basename $<))/contrib/download_prerequisites && mkdir -p gcc-build && cd gcc-build,$(call compile,--with-gmp=$(INSTALL_DIR) --with-mpfr=$(INSTALL_DIR) --with-mpfr-include=$(INSTALL_DIR)/include --with-mpc=$(INSTALL_DIR) --with-cloog=$(INSTALL_DIR) --with-isl=$(INSTALL_DIR) --disable-libjava CFLAGS="$(CFLAGS) -std=c99")))
# ppl.installedgmp.installed mpfr.installed mpc.installed cloog.installed isl.installed
ppl-$(ppl_ver).tar.bz2:
	wget http://bugseng.com/products/ppl/download/ftp/releases/$(ppl_ver)/$@
ppl.installed: ppl-$(ppl_ver).tar.bz2
	$(call compile)

cloog-$(cloog_ver).tar.gz:
	wget -O $@ http://www.bastoul.net/cloog/pages/download/count.php3?url=./$@
cloog.installed: cloog-$(cloog_ver).tar.gz
	$(subst tar xaf $< && cd,tar xaf $< && sed -i 's/GIT_HEAD_ID="UNKNOWN"/GIT_HEAD_ID="isl-0.11.1"/' cloog-0.18.0/isl/configure && cd,$(call compile))

isl-$(isl_ver).tar.bz2:
	wget http://isl.gforge.inria.fr/$@
isl.installed: isl-$(isl_ver).tar.bz2
	$(call compile)

binutils-$(binutils_ver).tar.bz2:
	wget http://ftp.gnu.org/gnu/binutils/binutils-$(binutils_ver).tar.bz2 
binutils.installed: binutils-$(binutils_ver).tar.bz2
	$(call compile)

parallel-$(parallel_ver).tar.bz2:
	wget http://ftp.gnu.org/gnu/parallel/parallel-$(parallel_ver).tar.bz2

parallel.installed: parallel-$(parallel_ver).tar.bz2
	$(call compile)

iojs-v$(iojs_ver).tar.xz:
	wget https://iojs.org/dist/v$(iojs_ver)/iojs-v$(iojs_ver).tar.xz
iojs.installed: iojs-v$(iojs_ver).tar.xz
	$(call compile)

gzip-$(gzip_ver).tar.xz:
	wget http://ftp.jaist.ac.jp/pub/GNU/gzip/$@
gzip.installed: gzip-$(gzip_ver).tar.xz
	$(compile)
glibc-$(glibc_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/glibc/$@
glibc.installed: glibc-$(glibc_ver).tar.xz
	mkdir -p glibc-build && cd glibc-build && ../$(basename $(basename $<))/configure --prefix=$(INSTALL_DIR) CC=/usr/bin/cc PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64 -L$(INSTALL_DIR)/lib" CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" CPPFLAGS="$(CFLAGS)" F77=gfortran FFLAGS="$(CFLAGS)" && gmake uninstall; gmake && ln -sf `which libtool` . && gmake install && cd .. && touch $@

screen-$(screen_ver).tar.gz:
	wget http://ftp.gnu.org/gnu/screen/$@
screen.installed: screen-$(screen_ver).tar.gz
	$(compile)

emacs-$(emacs_ver).tar.gz:
	wget http://ftp.yzu.edu.tw/gnu/emacs/$@
emacs.installed: emacs-$(emacs_ver).tar.gz
	$(compile)

tar-$(tar_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/tar/$@
tar.installed: tar-$(tar_ver).tar.xz
	tar xJf $< && cd $(basename $(basename $<)) && ./configure --prefix=$(INSTALL_DIR) PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig:$(INSTALL_DIR)/share/pkgconfig LDFLAGS="-L$(INSTALL_DIR)/lib -L$(INSTALL_DIR)/lib64" CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" CPPFLAGS="$(CFLAGS)" F77=gfortran FFLAGS="$(CFLAGS)" gmake uninstall; gmake && gmake install && cd .. && touch $@

p7zip_9.38.1_src_all.tar.bz2: 
	wget http://sourceforge.net/projects/p7zip/files/p7zip/9.38.1/$@
p7zip.installed:
	tar xaf $< && cd $(basename $(basename $<)) && make

nettle-$(nettle_ver).tar.gz:
	wget http://ftp.gnu.org/gnu/nettle/nettle-$(nettle_ver).tar.gz
nettle.installed: nettle-$(nettle_ver).tar.gz binutils.installed gmp.installed
	$(call compile,--enable-shared)
gnutls-2.6.6.tar.bz2:
	wget ftp://ftp.gnutls.org/gcrypt/gnutls/v2.6/gnutls-2.6.6.tar.bz2
gnutls.installed: gnutls-2.6.6.tar.bz2 nettle.installed gmp.installed
	$(call compile)

wget-$(wget_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/wget/$@
wget.installed: wget-$(wget_ver).tar.xz gnutls.installed
	$(call compile,)
raptor2-2.0.15.tar.gz:
	wget http://download.librdf.org/source/raptor2-2.0.15.tar.gz
raptor.installed: raptor2-2.0.15.tar.gz
	$(call compile)

lynx$(lynx_ver).tar.bz2:
	wget http://lynx.isc.org/lynx$(lynx_ver)/lynx$(lynx_ver).tar.bz2
lynx.installed:lynx$(lynx_ver).tar.bz2 openssl.installed
	tar xaf $< && cd lynx2-8-8 && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) --with-ssl=$(INSTALL_DIR)/lib --enable-persistent-cookies && make && make install && cd .. && touch $@

w3m.installed: w3m-$(w3m_version).tar.gz w3m-bdwgc72.diff w3m-0.5.3-button.patch
	tar xaf $< && cd $(basename $(basename $<)) && patch -p1 < ../w3m-bdwgc72.diff && patch -p1 < ../w3m-0.5.3-button.patch && export CFLAGS="$(CFLAGS)" && export CXXFLAGS="$(CFLAGS)" && export CPPFLAGS="$(CFLAGS)" && ./configure --with-ssl --prefix=$(INSTALL_DIR) --with-termlib="ncurses terminfo termcap" --enable-image=no --disable-xface --disable-mouse && make && make install && cd .. && touch $@
w3m-bdwgc72.diff:
	wget http://sourceforge.net/p/w3m/patches/_discuss/thread/0f07465b/645b/attachment/w3m-bdwgc72.diff
w3m-0.5.3-button.patch:
	wget --no-check-certificate https://raw.githubusercontent.com/Vliegendehuiskat/slackbuilds/master/network/w3m/patches/w3m-0.5.3-button.patch

subversion-$(subversion_ver).tar.bz2:
	wget http://mirror.symnds.com/software/Apache/subversion/$@
subversion.installed: subversion-$(subversion_ver).tar.bz2 apr.installed apr-util.installed neon.installed serf.installed
	$(call compile,--with-neon=$(INSTALL_DIR))
apr-$(apr_ver).tar.bz2:
	wget http://apache.claz.org//apr/$@
apr.installed: apr-$(apr_ver).tar.bz2
	$(compile)
apr-util-$(apr-util_ver).tar.bz2:
	wget http://apache.claz.org//apr/$@
apr-util.installed: apr-util-$(apr-util_ver).tar.bz2 apr.installed expat.installed
	$(call compile,--with-apr=$(INSTALL_DIR))
neon-$(neon_ver).tar.gz:
	wget http://webdav.org/neon/$@
neon.installed: neon-$(neon_ver).tar.gz
	$(compile)
serf-$(serf_ver).tar.bz2:
	wget http://serf.googlecode.com/svn/src_releases/$@
serf.installed:serf-$(serf_ver).tar.bz2
	$(compile)
scons-local-2.3.4.tar.gz:
	wget  http://prdownloads.sourceforge.net/scons/$@
scons.installed: python.installed
	python scons.py

gtk+-3.14.6.tar.xz:
	wget http://ftp.gnome.org/pub/gnome/sources/gtk+/3.14/gtk+-3.14.6.tar.xz
gtk+.installed: gtk+-3.14.6.tar.xz
	$(call compile)
qiv-2.3.1.tgz:
	wget http://spiegl.de/qiv/download/qiv-2.3.1.tgz
qiv.installed: qiv-2.3.1.tgz gtk+.installed
	tar xaf $< && cd qiv-2.3.1 && make && make install && cd .. && touch $@


gmp-$(gmp_ver).tar.xz:
	wget --no-check-certificate https://gmplib.org/download/gmp/gmp-$(gmp_ver).tar.xz
gmp.installed: gmp-$(gmp_ver).tar.xz
	$(call compile,--disable-assembly --enable-cxx ABI=32)
#	tar xaf $< && cd $(basename $(basename $<)) && ./configure --prefix=$(INSTALL_DIR) --enable-cxx CC=/usr/bin/gcc && $(MAKE) uninstall; $(MAKE) $(LIBTOOL) && $(MAKE) install && cd .. && touch $@

mpfr-$(mpfr_ver).tar.bz2:
	wget http://www.mpfr.org/mpfr-$(mpfr_ver)/mpfr-$(mpfr_ver).tar.bz2
mpfr.installed: mpfr-$(mpfr_ver).tar.bz2
	tar xaf $< && cd $(basename $(basename $<)) && ./configure --prefix=$(INSTALL_DIR) --with-mpfr=$(INSTALL_DIR) --with-gmp=$(INSTALL_DIR) CC=/usr/bin/gcc && $(MAKE) uninstall; $(MAKE) $(LIBTOOL) && $(MAKE) install && cd .. && touch $@

mpc_ver = 0.9
mpc-$(mpc_ver).tar.gz:
	wget http://www.multiprecision.org/mpc/download/mpc-$(mpc_ver).tar.gz
mpc.installed: mpc-$(mpc_ver).tar.gz gmp.installed mpfr.installed
	$(call compile)
#	tar xaf $< && cd $(basename $(basename $<)) && export CFLAGS="$(CFLAGS)" && ./configure --prefix=$(INSTALL_DIR) CC=/usr/bin/gcc && $(MAKE) uninstall; $(MAKE) $(LIBTOOL) && $(MAKE) install && cd .. && touch $@
bison-$(bison_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/bison/bison-$(bison_ver).tar.xz
bison.installed: bison-$(bison_ver).tar.xz
	$(call compile)
flex-$(flex_ver).tar.xz:
	wget http://sourceforge.net/projects/flex/files/flex-$(flex_ver).tar.xz
flex.installed: flex-$(flex_ver).tar.xz
	$(call compile)
cmake-3.1.3.tar.gz:
	wget --no-check-certificate http://www.cmake.org/files/v3.1/$@
cmake.installed: cmake-3.1.3.tar.gz
	$(compile)
bash-$(bash_ver).tar.gz:
	wget http://ftp.gnu.org/gnu/bash/bash-$(bash_ver).tar.gz
bash.installed: bash-$(bash_ver).tar.gz
	$(call compile)
pcre-$(pcre_ver).tar.bz2:
	wget http://downloads.sourceforge.net/project/pcre/pcre/$(pcre_ver)/pcre-$(pcre_ver).tar.bz2
pcre.installed: pcre-$(pcre_ver).tar.bz2
	$(call compile)
curl-$(curl_ver).tar.lzma:
	wget http://www.execve.net/curl/$@
curl.installed: curl-$(curl_ver).tar.lzma xz.installed
	$(call compile)
rsync-$(rsync_ver).tar.gz:
	wget http://rsync.samba.org/ftp/rsync/src/rsync-$(rsync_ver).tar.gz
rsync.installed: rsync-$(rsync_ver).tar.gz
	$(call compile)
texinfo-$(texinfo_ver).tar.xz:
	wget http://ftp.gnu.org/gnu/texinfo/texinfo-$(texinfo_ver).tar.xz
texinfo.installed: texinfo-$(texinfo_ver).tar.xz
	$(call compile)
xz-$(xz_ver).tar.bz2:
	wget http://tukaani.org/xz/$@
xz.installed: xz-$(xz_ver).tar.bz2
	$(call compile)

R-3.2.3.tar.gz:
	wget https://cran.r-project.org/src/base/R-3/$@

R.installed: R-3.2.3.tar.gz
	$(call compile,\
	--with-blas \
	--with-lapack)

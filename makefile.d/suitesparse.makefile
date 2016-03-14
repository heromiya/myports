SuiteSparse-4.2.1.tar.gz:
	wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.2.1.tar.gz
lib/libsuitesparseconfig.so: SuiteSparse-4.2.1.tar.gz
	tar xaf $< && cd SuiteSparse && \
	sed -i 's#INSTALL_LIB = /usr/local/lib#INSTALL_LIB = $(INSTALL_DIR)/lib#g; s#INSTALL_INCLUDE = /usr/local/include#INSTALL_INCLUDE = $(INSTALL_DIR)/include#g; s#BLAS = -lopenblas#BLAS = -lblas#g;' SuiteSparse_config/SuiteSparse_config.mk && \
	make && make install && \
	cd $(INSTALL_DIR)/lib && \
	top=`pwd` && \
	mkdir -p tmp && \
	cd tmp && \
	for f in libsuitesparseconfig libamd libcamd libcolamd libbtf libklu libldl libccolamd libumfpack libcholmod libcxsparse librbio libspqr; do ar vx ../$$f.a; done && \
	for f in libsuitesparseconfig libamd libcamd libcolamd libbtf libklu libldl libccolamd libumfpack libcholmod libcxsparse librbio libspqr; do gcc -shared -o ../$$f.so *.o -lrt -llapack -lblas; done

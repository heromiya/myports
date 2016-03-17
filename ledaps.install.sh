#! /bin/bash
export PREFIX=$INSTALL_DIR
export NCDF4INC=$INSTALL_DIR/include 
export NCDF4LIB=$INSTALL_DIR/lib 
export HDF5INC=$INSTALL_DIR/include 
export HDF5LIB=$INSTALL_DIR/lib 
export HDFINC=$INSTALL_DIR/include 
export HDFLIB=$INSTALL_DIR/lib 
export HDFEOS_INC=$INSTALL_DIR/include/hdfeos 
export HDFEOS_LIB=$INSTALL_DIR/lib 
export HDFEOS_GCTPINC=$INSTALL_DIR/include 
export HDFEOS_GCTPLIB=$INSTALL_DIR/lib 
export CURLINC=$INSTALL_DIR/include 
export CURLLIB=$INSTALL_DIR/lib 
export IDNINC=$INSTALL_DIR/include 
export IDNLIB=$INSTALL_DIR/lib 
export XML2INC=$INSTALL_DIR/include/libxml2 
export XML2LIB=$INSTALL_DIR/lib 
export ZLIBINC=$INSTALL_DIR/include 
export ZLIBLIB=$INSTALL_DIR/lib 
export LZMALIB=$INSTALL_DIR/lib 
export LZMAINC=$INSTALL_DIR/include 
export ESPALIB=$INSTALL_DIR/lib 
export ESPAINC=$INSTALL_DIR/include 
export JPEGINC=$INSTALL_DIR/include 
export JPEGLIB=$INSTALL_DIR/lib 
export DISABLE_OPTIMIZATION=yes 
export ENABLE_DEBUG=yes 
export EXTRA_OPTIONS="$CFLAGS -I$INSTALL_DIR/include -L/usr/lib -lm"
export CC=gcc
sed -i "s#MATHLIB = -lm#MATHLIB = -L/usr/lib -lm#g" lndsr/Makefile 
ln -fs $INSTALL_DIR/libxml2/libxml $INSTALL_DIR
make
make install

exit 0

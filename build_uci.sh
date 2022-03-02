#! /bin/sh

TOPDIR=$PWD

do_init() {
	rm -rf $TOPDIR/libubox $TOPDIR/uci $TOPDIR/install
	mkdir $TOPDIR/install
}

build_libubox() {
	cd $TOPDIR
	git clone http://git.openwrt.org/project/libubox.git
	cd libubox
	cmake -DBUILD_LUA=OFF -DBUILD_EXAMPLES=OFF -DCMAKE_INSTALL_PREFIX=../install
	make && make install
	cd $TOPDIR
}

build_uci() {
	cd $TOPDIR
	git clone git://git.openwrt.org/project/uci.git
	cd uci
	cmake -DBUILD_LUA=OFF -DCMAKE_INSTALL_PREFIX=../install
	make && make install
	cd $TOPDIR
}

do_done() {
	tree $TOPDIR/install
}

test_uci() {
	echo "LD_LIBRARY_PATH=$TOPDIR/install/lib/ $TOPDIR/install/bin/uci"
	LD_LIBRARY_PATH=$TOPDIR/install/lib/ $TOPDIR/install/bin/uci
}

do_main() {
	do_init
	build_libubox
	build_uci
	do_done
	test_uci
}

do_main

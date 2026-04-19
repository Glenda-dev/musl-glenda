#!/bin/sh

ARCH="riscv64"
CONFIGURE_ARGS=""

for i in "$@"; do
    case $i in
        --arch=*)
            ARCH="${i#*=}"
            ;;
        *)
            CONFIGURE_ARGS="$CONFIGURE_ARGS $i"
            ;;
    esac
done

echo "Building musl for architecture: $ARCH"

case $ARCH in
    riscv64)
        CFLAGS="-target riscv64 -march=rv64gc -mabi=lp64d -O2"
        ;;
    x86_64)
        CFLAGS="-target x86_64"
        ;;
    loongarch64)
        CFLAGS="-target loongarch64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

export ARCH
export CC="clang"
export AR="llvm-ar"
export RANLIB="llvm-ranlib"
export NM="llvm-nm"
export OBJCOPY="llvm-objcopy"
export CFLAGS

./configure --disable-shared --prefix=../../target/sysroot --target=$ARCH $CONFIGURE_ARGS
make -j$(nproc)
make install

cd ../../target/sysroot/lib
llvm-ar rc libgcc_eh.a
echo "" | clang $CFLAGS -c -x c - -o crtbeginT.o
echo "" | clang $CFLAGS -c -x c - -o crtend.o
#!/bin/sh

ARCH="riscv64"

for i in "$@"; do
    case $i in
        --arch=*)
            ARCH="${i#*=}"
            ;;
        *)
            ;;
    esac
done

echo "Building musl for architecture: $ARCH"

case $ARCH in
    riscv64)
        CROSS_COMPILE="riscv64-unknown-elf-"
        ;;
    x86_64)
        CROSS_COMPILE="x86_64-unknown-elf"
        ;;
    loongarch64)
        CROSS_COMPILE="loongarch64-unknown-elf"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

export ARCH
export CROSS_COMPILE

./configure --disable-shared --prefix=../../target/sysroot
make -j$(nproc)
make install

cd ../../target/sysroot/lib
llvm-ar rc libgcc_eh.a
llvm-objcopy --strip-symbol=_start libape.a libape.a
echo "" | ${CROSS_COMPILE}gcc -c -x c - -o crtbeginT.o
echo "" | ${CROSS_COMPILE}gcc -c -x c - -o crtend.o
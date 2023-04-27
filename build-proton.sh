mkdir -p out
make O=out clean
make O=out mrproper
export PATH="$HOME/android/proton-clang/bin:$PATH"

echo input "wifi" or "lte" according to the version you want to build

read input

case $input in
wifi)
echo wifi defconfig selected
make CC=clang O=out ARCH=arm64 gts4lvwifi_defconfig
;;
lte)
echo lte defconfig selected
make CC=clang O=out ARCH=arm64 gts4lv_defconfig
;;
*)
echo don\'t know
return 0
;;
esac

make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      SUBARCH=arm64 \
                      CC=clang \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi-

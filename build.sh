mkdir -p out
make O=out clean
make O=out mrproper

echo input "wifi" or "lte" according to the version you want to build

read version

case $version in
wifi)
echo wifi defconfig selected
make O=out ARCH=arm64 gts4lvwifi_full_defconfig
;;
lte)
echo lte defconfig selected
make O=out ARCH=arm64 gts4lv_full_defconfig
;;
*)
echo the input typed is wrong, compilation aborted...
return 0
;;
esac

echo input "aosp" or "proton" according to the toolchains of your choice

read tool

case $tool in
aosp)
echo aosp clang selected
PATH=""$HOME"/android/aosp-clang/clang/bin:"$HOME"/android/toolchains/aosp-clang/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin:"$HOME"/android/aosp-clang/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      SUBARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi-
;;
proton)
echo proton clang selected
export PATH="$HOME/android/toolchains/proton-clang/bin:$PATH"
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      SUBARCH=arm64 \
                      CC=clang \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi-
;;
*)
echo the input typed is wrong, compilation aborted...
return 0
;;
esac

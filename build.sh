mkdir -p out
make O=out clean
make O=out mrproper



echo input "wifi" or "lte" according to the version you want to build

read input

case $input in
wifi)
echo wifi defconfig selected
make O=out ARCH=arm64 gts4lvwifi_defconfig
;;
lte)
echo lte defconfig selected
make O=out ARCH=arm64 gts4lv_defconfig
;;
*)
echo don\'t know
return 0
;;
esac

PATH=""$HOME"/android/aosp-clang/clang/bin:"$HOME"/android/aosp-clang/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin:"$HOME"/android/aosp-clang/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      SUBARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- \
                      CROSS_COMPILE_ARM32=arm-linux-androideabi-




# AERA Recovery for Xiaomi Mi 11 Lite 4G (courbet)

**Unofficial Alpha** device tree for the
[AERA Recovery Project](https://github.com/AERA-Recovery) on Android 16
(`aera-16.0`).

Maintainer: [@qualixxe096](https://github.com/qualixxe)

This is an initial bring-up. The tree is built automatically with GitHub
Actions; on-device boot, display, touch and userdata decryption have **not**
been verified yet. Treat every build as experimental, and keep a backup of
your stock recovery (and a restore zip) before flashing anything.

## Status

- **Build:** GitHub Actions (`.github/workflows/build.yml`) on Ubuntu 24.04.
- **Display:** modern Adreno 618 DRM/KMS path; the legacy KGSL backend used by
  older Qualcomm targets is intentionally not enabled.
- **Encryption:** Qualcomm FBE helpers enabled (`qcom_decrypt`,
  `qcom_decrypt_fbe`) for the metadata-encrypted userdata. Decryption is
  unverified and may need matching keymaster blobs at runtime.
- **Kernel:** prebuilt from the courbet EU Android 13 release
  `V14.0.4.0.TKQMIXM` (boot header v2, separate `dtb` / `dtbo`). The obsolete
  Android 11 tree kernel is not used.

## To compile

Place this tree at `device/xiaomi/courbet` in an AERA Android 16 checkout:

```sh
repo init -u https://github.com/AERA-Recovery/android_manifest.git -b aera-16.0
repo sync -c --force-sync --no-clone-bundle --no-tags -j$(nproc)
git clone -b aera-16.0 \
  https://github.com/qualixxe/android_device_xiaomi_courbet-AERA.git \
  device/xiaomi/courbet
source build/envsetup.sh
lunch aera_courbet-eng
mka adbd recoveryimage
```

Expected image: `out/target/product/courbet/AERA-*-courbet.img`.

Alternatively, run the **Build AERA Recovery (courbet)** workflow manually
(`workflow_dispatch`). The recovery image and the build log are uploaded as
workflow artifacts.

## Device specifications

| Basic                   | Spec Sheet                                                    |
| -----------------------:|:------------------------------------------------------------- |
| CPU                     | Octa-core (2x2.3 GHz Kryo 470 Gold & 6x1.8 GHz Kryo 470 Silver) |
| Chipset                 | Qualcomm SM7150 Snapdragon 732G (reports as `sm6150`)          |
| GPU                     | Adreno 618                                                    |
| Memory                  | 6/8 GB RAM                                                    |
| Shipped Android Version | 11 (MIUI 12)                                                  |
| Storage                 | 64/128 GB UFS 2.2, dedicated microSDXC slot                   |
| Battery                 | Non-removable Li-Po 4250 mAh, 33W fast charging               |
| Display                 | 1080 x 2400 pixels, 6.55 inches AMOLED, 90 Hz (~402 ppi)       |
| Camera                  | 64 MP f/1.8 + 8 MP ultrawide + 5 MP telemacro; 16 MP front     |
| Model                   | M2101K9AG (Global)                                            |

## Partition layout

A/B device with a dynamic `super` partition (group
`xiaomi_dynamic_partitions`: system, system_ext, vendor, product, odm,
mi_ext) and a dedicated `recovery` partition. `boot` / `recovery` are
128 MiB, `dtbo` is 32 MiB. Userdata is metadata-encrypted FBE using Qualcomm
inline crypto (ICE).

## Credits

- [AERA Recovery Project](https://github.com/AERA-Recovery) — recovery source
  and build system.
- [SebaUbuntu / twrpdtgen](https://github.com/twrpdtgen) — generated hardware
  base and the prebuilt kernel / dtb / dtbo for courbet.
- [AERA chiron device tree](https://github.com/AERA-Recovery/android_device_xiaomi_chiron-AERA)
  — reference for the AERA device-tree structure.
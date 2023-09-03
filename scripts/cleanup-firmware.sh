#!/bin/bash

# Note: If this file is in /usr/lib/firmware, it's probably going to
# be overwritten, so go find the original and edit that instead.

echo "I'm $0"
echo "I'm going to clean up /usr/lib/firmware for this wacky little intel stick computer"
echo " "

fw_dir=/usr/lib/firmware
echo "First, put a copy of myself in $fw_dir"
sudo cp $0 fw_dir
echo " "

echo "$fw_dir is using $(du -sh $fw_dir | cut -f1)."

echo "We might use some stuff in the intel dir, but I can't figure out"
echo "what it would be."
echo "We probably use i915"
files_we_definitely_use=( "rtl_bt/rtl8723bs_fw.bin" "rtl_bt/rtl8723bs_config-OBDA8723.bin" "regulatory.db" "rtlwifi/rtl8723bs_nic.bin" )
echo "We definitely use:"

for f in ${files_we_definitely_use[@]}; do
    echo "  $f"
    if [[ ! -f $fw_dir/$f ]]; then
        echo "Whoa.  $f already doesn't exist.  Bailing out."
        exit 1
    fi
done

echo " "
echo -n "Delete crud we don't use. "
cd $fw_dir

sudo rm -rf intel
echo -n ". "

sudo rm -rf netronome amdgpu \
   liquidio qcom ath11k qed \
   mediatek dpaa2 mrvl \
   vsc radeon cypress ti-connectivity \
   brcm iwlwifi*.ucode v4l* \
   tehuti ti_3410.fw ti_5052.fw tigon ti-keystone tlg2300_firmware.bin \
   ttusb-budget usbduxfast_firmware.bin usbdux_firmware.bin \
   usbduxsigma_firmware.bin vicam vntwusb.fw vxge whiteheat.fw \
   whiteheat_loader.fw wil6210.brd wil6210.fw wsm_22.bin yam yamaha \
   zd1201-ap.fw zd1201.fw zd1211 bnx2 i2400m-fw-usb-1.4.sbcf \
   i2400m-fw-usb-1.5.sbcf i6050-fw-usb-1.5.sbcf libertas phanfw.bin qca \
   rsi rtw89 ueagle-atm asihpi bnx2x nvidia cxgb4 ath10k \
   mellanox
echo -n ". "

sudo rm -rf 1a98-INTEL-EDK2-2-tplg.bin a300_pfp.fw a300_pm4.fw amd-ucode \
   qat_mmp.bin rt3070.bin rt3090.bin s2250.fw s2250_loader.fw vpu_d.bin \
   vpu_p.bin
echo -n ". "

sudo rm -rf 3com acenic adaptec advansys agere_ap_fw.bin agere_sta_fw.bin amd \
   ar3k ar5523.bin as102_data1_st.hex as102_data2_st.hex ath3k-1.fw ath6k \
   ath9k_htc atmel atmel_at76c504_2958.bin atmel_at76c504a_2958.bin \
   atmsar11.fw atusb av7110 cadence carl9170-1.fw cavium cbfw-3.2.1.1.bin \
   cbfw-3.2.3.0.bin cbfw-3.2.5.1.bin cis cpia2 ct2fw-3.2.1.1.bin \
   ct2fw-3.2.3.0.bin ct2fw-3.2.5.1.bin ctefx.bin ctfw-3.2.1.1.bin \
   ctfw-3.2.3.0.bin ctfw-3.2.5.1.bin ctspeq.bin cxgb3 dsp56k \
   dvb-fe-xc4000-1.4.1.fw dvb-fe-xc5000-1.6.114.fw \
   dvb-fe-xc5000c-4.1.30.7.fw dvb-usb-dib0700-1.20.fw \
   dvb-usb-it9135-01.fw dvb-usb-it9135-02.fw dvb-usb-terratec-h5-drxk.fw \
   e100 ea edgeport emi26 emi62 ene-ub6250 ess f2255usb.bin go7007 \
   hfi1_dc8051.fw hfi1_fabric.fw hfi1_pcie.fw hfi1_sbus.fw hp htc_7010.fw \
   htc_9271.fw imx inside-secure ipw2100-1.3.fw ipw2100-1.3-i.fw \
   ipw2100-1.3-p.fw ipw2200-bss.fw ipw2200-ibss.fw ipw2200-sniffer.fw \
   isci iwlwifi-so-a0-gf4-a0.pnvm iwlwifi-so-a0-gf-a0.pnvm \
   iwlwifi-ty-a0-gf-a0.pnvm kaweth keyspan keyspan_pda korg lbtf_usb.bin \
   lgs8g75.fw matrox meson microchip moxa mt7601u.bin mt7650.bin \
   mt7662.bin mt7662_rom_patch.bin mts_cdma.fw mts_edge.fw mts_gsm.fw \
   mts_mt9234mu.fw mts_mt9234zba.fw mwl8k mwlwifi \
   myri10ge_eth_big_z8e.dat myri10ge_ethp_big_z8e.dat \
   myri10ge_ethp_z8e.dat myri10ge_eth_z8e.dat \
   myri10ge_rss_eth_big_z8e.dat myri10ge_rss_ethp_big_z8e.dat \
   myri10ge_rss_ethp_z8e.dat myri10ge_rss_eth_z8e.dat ositech \
   qat_895xcc.bin qat_895xcc_mmp.bin qat_c3xxx.bin qat_c3xxx_mmp.bin \
   qat_*.bin qat_c62x_mmp.bin ql2100_fw.bin ql2200_fw.bin \
   ql2300_fw.bin ql2322_fw.bin ql2400_fw.bin ql2500_fw.bin qlogic r128 \
   r8a779x_usb3_v1.dlmem r8a779x_usb3_v2.dlmem r8a779x_usb3_v3.dlmem \
   rockchip rp2.fw rsi_91x.fw rt2561.bin rt2561s.bin rt2661.bin \
   rt2860.bin rt2870.bin rt3290.bin rt73.bin RTL8192E rtl_nic \
   rtw88 s5p-mfc.fw s5p-mfc-v6.fw s5p-mfc-v6-v2.fw s5p-mfc-v7.fw \
   s5p-mfc-v8.fw sb16 sdd_sagrad_1091_1098.bin slicoss sun
echo -n ". "
echo " "
echo " "

echo "Let's make sure we still have the stuff we definitely use:"
for f in ${files_we_definitely_use[@]}; do
    if [[ -f $fw_dir/$f ]]; then
        echo " ✓ $f"
    else
        echo "Whoa.  $f is missing."
    fi
done
echo " "

echo "After cleanup, $fw_dir is $(du -sh $fw_dir | cut -f1)."

# With /etc/default/grub containing
#   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash dyndbg=\"file drivers/base/firmware_loader/main.c +fmp\" "
# you can run:
#   dmesg | grep firmware_class:fw_get
# to get the list of firmware we tried to load, or:
#   dmesg | grep firmware_class:fw_get |grep -v fail| tr -s ' ' |cut -f 4- -d' '
# to get the filenames of the firmware that we successfully loaded

#!/bin/bash
FILE1=lubu.qcow2
FILE2=qemu_iso/lubuntu-20.04.4-desktop-amd64.iso
# creates a virtual disk for lxle if there is not one
if [ ! -f "$FILE1" ]
then
    echo "Going to create a lubuntu virt-disk"
    qemu-img create -f raw lubu.qcow2 20G 
else
    echo "files exists"
fi
# downloads lxle.iso if it does not exist in current directory.
if [ ! -f "$FILE2" ]
then
echo "going to download lubuntu"
wget -P qemu_iso https://cdimage.ubuntu.com/lubuntu/releases/20.04.4/release/lubuntu-20.04.4-desktop-amd64.iso
else
    echo "lubuntu downloaded"
fi
# starts qemu with the iso if it is not installed or starts the vm.
if qemu-img info lubu.qcow2 | grep -i "disk size: 4 KiB"
then
    qemu-system-x86_64 -drive file=lubu.qcow2,format=raw -boot d \
    -cdrom qemu_iso/lubuntu-20.04.4-desktop-amd64.iso  -m 2048M -cpu host \
    -smp 1 -spice port=3002,disable-ticketing=on \
    -vga qxl -enable-kvm 
    echo "vm creation successfully completed"
else
    qemu-system-x86_64 -drive file=lubu.qcow2,format=raw -boot d \
    -m 6192M -cpu host -device intel-hda -device hda-duplex \
    -smp 4 -spice port=3002,disable-ticketing=on \
    -netdev user,id=mynet0,net=192.168.76.0/24,dhcpstart=192.168.76.12 \
    -device e1000,netdev=mynet0,mac=88:5d:32:31:d2:fd  \
    -vga qxl -enable-kvm 
    echo "starting lubuntu"
fi 


$name = "i3"
$disk_size = 10000
$iso = "$HOME\Downloads\archlinux-2021.07.01-x86_64.iso"

VBoxManage unregistervm $name --delete
VBoxManage createvm --name $name --ostype ArchLinux_64 --register
VBoxManage modifyvm $name --cpus 4 --memory 4096 --vram 32 --apic on --graphicscontroller vmsvga
VBoxManage modifyvm $name --firmware efi
VBoxManage modifyvm $name --clipboard-mode bidirectional

VBoxManage createhd --filename "$HOME\VirtualBox VMs\$name\$name.vdi" --size $disk_size --variant Standard 
VBoxManage storagectl $name --name "SATA" --add sata --bootable on
VBoxManage storageattach $name --storagectl "SATA" --type hdd --port 0 --device 0 --medium "$HOME\VirtualBox VMs\$name\$name.vdi"

VBoxManage storagectl $name --name "IDE" --add ide
VBoxManage storageattach $name --storagectl "IDE" --type dvddrive --port 0 --device 0 --medium "$iso"

VBoxManage sharedfolder add $name --name "install" --hostpath "." --automount
VBoxManage sharedfolder add $name --name "winhome" --hostpath "$HOME" --automount

VBoxManage setextradata $name "VBoxInternal2/EfiGraphicsResolution" "1920x1080"
VBoxManage setextradata $name "CustomVideoMode1" "1920x1080x24"
VBoxManage setextradata $name "GUI/ShowMiniToolBar" "false"
VBoxManage setextradata $name "GUI/AutoresizeGuest" "false"
# VBoxManage setextradata $name "GUI/Fullscreen" "true"

# VBoxManage internalcommands createrawvmdk -filename "$HOME\VirtualBox VMs\endeavouros.vmdk" -rawdisk \\.\PHYSICALDRIVE1 -partitions 5 -relative
# VBoxManage storageattach $name --storagectl "SATA" --type hdd --port 0 --device 1 --medium "$HOME\VirtualBox VMs\endeavouros.vmdk"

VBoxManage startvm $name
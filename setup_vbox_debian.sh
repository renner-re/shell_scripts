#!/bin/bash
# UNTESTED


VM_NAME="server_name_here"
ISO_PATH=""/path/to/iso""
DISK_SIZE="25000" # 25GB disk size
RAM_SIZE="4096" # 4GB RAM
USER_NAME="user"
ADMIN_NAME="administrator"

# Join to Domain
# DOMAIN="domain.here"
# AD_USERNAME="aduser"
# AD_PASSWORD="adpassword"

# Create VM
VBoxManage createvm --name $VM_NAME --ostype "Debian_64" --register

# Set Memory Size
VBoxManage modifyvm $VM_NAME --memory $RAM_SIZE\

# Create Hard Disk
VBoxManage createhd --filename "$VM_NAME.vdi" --size $DISK_SIZE

# Attach ISO & Start VM
VBoxManage storagectl $VM_NAME --name "IDE Controller" --size $DISK_SIZE
VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 0 --device 0 --type 0 dvddrive --medium $ISO_PATH
VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 1 --device 0 --type hdd --medium "$VM_NAME.vdi"

 # Start the VM
 VBoxManage startvm $VM_NAME

 # Wait for VM to boot and SSH to be available
 sleep 60

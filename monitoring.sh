
#concrete architecture
printf "#Architecture: "
uname -a

#physical processors
printf "#CPU physical : "
nproc --all

#virtual processors
printf "#vCPU : "
cat /proc/cpuinfo | grep processor | wc -l

#available RAM
printf "#Memory Usage: "
free -m | grep Mem | awk '{ printf "%d/%dMB  (%.2f%%)\n", $3, $2, $3/$2*100 }'

#available disk memory
printf "#Disk Usage: "
df -BM -a | grep /dev/mapper | awk '{sum+=$3}END{printf sum}'
printf "/"
df -H -a | grep /dev/mapper | awk '{sum+=$4}END{printf sum}'
printf "GB  ("
df -BM -a | grep /dev/mapper | awk '{sum1+=$3; sum2+=$4}END{printf "%d", sum1/sum2*100}'
printf "%%)\n"

#processors percentage
printf "#CPU load: "
mpstat | grep all | awk '{printf "%.2f%%\n", 100-$13}'

#last reboot
printf "#Last boot: "
who -b | awk {'printf $3" "$4"\n"}'

#Whether LVM
printf "#LVM use: "
if [ "$(lsblk | grep lvm | wc -l)" -ge 1 ]; then printf "yes\n"; else printf "no\n"; fi

#active connections
printf "#Connexions TCP : "
ss | grep -i tcp | wc -l | tr -d '\n'
printf " ESTABLISHED\n"

#using users
printf "#User log: "
who | wc -l

#IP addr and MAC
printf "#Network: IP "
hostname -I | tr -d '\n'
printf "("
ip link | grep link/ether | awk '{printf $2}'
printf ")\n"

#sudo commands executed
printf "#Sudo : "
cat /var/log/auth.log | grep -a sudo | grep COMMAND | wc -l | tr -d '\n'
printf " cmd\n"

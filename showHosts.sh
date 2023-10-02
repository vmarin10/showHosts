#!/bin/bash 

# Script para ver los hosts en una red.

trap ctrl_c SIGINT


for i in $(seq 1 254); do # Bucle del 1 al 254 para descubrir todas IPs
	for port in 21, 22, 23, 25, 80, 139, 443, 445, 8080; do
		# Hemos metido el & para hacerlo con threads o hilos)
		timeout 1 bash -c "echo '' > /dev/tcp/192.168.0.$i/$port" 2>/dev/null &&
			echo "[+] Host 192.168.0.$i - Port: $port - ACTIVO" &
	done;
		
done


function ctrl_c() {
	echo -e "\n [+] Has pulsado CTRL C. Saliendo ... \n " 
	exit 1
}

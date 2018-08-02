#!/bin/bash
echo '=============================== MAKING ================================'
cd custom/armgcc
make
if [[ $? -ne 0 ]] ; then
    exit 0
fi
sleep 0.1
#SOFTHEX=`readlink -f /home/william/GlenPickle/nrf51_SDK_10/components/softdevice/s110/hex/s110_nrf51_8.0.0_softdevice.hex`
SOFTHEX=`readlink -f /home/william/GlenPickle/nRF5_SDK_11/components/softdevice/s130/hex/s130_nrf51_2.0.0_softdevice.hex`
HEX=`readlink -f _build/nrf51822_xxac.hex`
du -b $HEX

echo
echo '============================= PROGRAMMING ============================='
{
	echo "reset halt";
	sleep 0.1;
	echo "flash write_image erase" $SOFTHEX;
	sleep 30;
	echo "reset";
	sleep 0.1;
	exit;

} | telnet localhost 4444

echo
echo '============================= PROGRAMMING ============================='
{
	echo "reset halt";
	sleep 0.1;
	echo "flash write_image erase" $HEX;
	sleep 15;
	echo "reset";
	sleep 0.1;
	exit;

} | telnet localhost 4444

echo
echo '============================== FINISHED ==============================='

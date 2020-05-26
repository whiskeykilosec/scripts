# OSCP Oneliners

* clean IPs from nmap
  * intended input is txt with nmap -oG flag. grep for whatever you're looking for
  * grep -i "string" old-file | cut -d " " -f 2 > new-file

* sort list of IP addresses with mask 255.255.255.0 separated by newline, ascending
  * sort -t . -k 4,4n -o new-file old-file

* add a protocol to list of IPs or domains separated by newline and create a backup of the original file
  * sed -i.bak -e 's/^/protocol/' file

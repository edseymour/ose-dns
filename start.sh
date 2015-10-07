#!/bin/bash

hfn=/etc/dnsmasq.d/hosts

# Generate /etc/dnsmasq.d/ configuration for additional hosts
# DOMAIN= openshift host zone
# HOSTNAMES= CSV of openshift host names (not fqdn, will automatically append DOMAIN)
# <HOSTNAME>_IP= case sensitive env var for the IP of each host
# WILDCARD= wildcard zone
# WILDCARD_IP= ip of wildcard zone

# Start from scratch with the hostnames - casual attempt at making this idempotent
rm -f ${hfn}

hosts=$(echo $HOSTNAMES | tr "," "\n")
for HOST in $hosts
do
   fqdn=$HOST.$DOMAIN
   eval ip='$'$HOST'_IP'   

   echo "host-record=$HOST.$DOMAIN,$ip" >> ${hfn} 

done

cat ${hfn}

echo "/usr/sbin/dnsmasq -d --local-service --local=/$DOMAIN/ --address=/$WILDCARD/$WILDCARD_IP --conf-dir=/etc/dnsmasq.d"
/usr/sbin/dnsmasq -d --local-service --local=/$DOMAIN/ --address=/$WILDCARD/$WILDCARD_IP --conf-dir=/etc/dnsmasq.d

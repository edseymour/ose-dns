# ose-dns

When running OpenShift in a small test of POC environment, it helps to have an external DNS configured to create a wildcard zone for your exposed OpenShift apps.

This container will run dnsmasq with configuration to support your environment, automatically pulling upstream configuration from your localhost and presenting a new DNS configuration. 

## USAGE
Run the container with the following environmental variables:
 * DOMAIN - the zone used by all of your OpenShift hosts, e.g. example.com
 * HOSTNAMES - a comma separated list of OpenShift hosts, e.g. master,node01,node02
 * For each OpenShift host: <host>_IP - the IP address of the host, e.g. master_IP=192.168.122.100
 * WILDCARD - the wildcard zone for OpenShift routes, e.g. cloudapps.example.com
 * WILDCARD_IP - the IP address of the OpenShift router (currently only one IP supported), e.g. 192.168.122.100 

### EXAMPLE

`docker run -d -e "DOMAIN=example.com" -e "HOSTNAMES=master,node01,node02" -e "master_IP=192.168.122.100" -e "node01_IP=192.168.122.101" -e "node02_IP=192.168.122.102" -e "WILDCARD=.cloudapps.example.com" -e "WILDCARD_IP=192.168.122.100" -p 53:53/udp edseymour/ose-dns`

## Run Script
The `run-ose-dns` script includes some common defaults for a small OSE3 deployment, and simplifies the task of launching the container. 

#!/bin/sh
# this line adds an IP and tweb.local to the hosts file

echo "\n$1\ttweb.local" >> /etc/hosts

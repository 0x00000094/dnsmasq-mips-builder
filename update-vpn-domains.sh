#!/bin/sh

domains_url=https://raw.githubusercontent.com/itdoginfo/allow-domains/main/Russia/inside-dnsmasq-ipset.lst

new_file="/tmp/domains.conf"
old_file="/etc/dnsmasq.d/vpn-domain.conf"

count=0
while true; do
    if curl -m 3 github.com; then
        curl -f $domains_url --output $new_file
        break
    else
        echo "GitHub is not available. Check the internet availability [$count]"
        count=$((count + 1))
    fi
done

sed -i 's@vpn_domains@vpn@g' $new_file

if ! cmp -s "$new_file" "$old_file"; then
    if dnsmasq --conf-file=$new_file --test 2>&1 | grep -q "syntax check OK"; then
        rm -f $old_file
        mv $new_file $old_file
        /etc/init.d/dnsmasq restart
    fi
fi

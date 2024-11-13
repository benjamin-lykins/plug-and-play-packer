#bin/bash -ex

# Cleaning logs.
echo "Cleaning logs..."
if [ -f /var/log/audit/audit.log ]; then
    echo "Cleaning audit logs..."
    cat /dev/null >/var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
    echo "Cleaning wtmp logs..."
    cat /dev/null >/var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    echo "Cleaning lastlog logs..."
    cat /dev/null >/var/log/lastlog
fi

# Cleaning udev rules.
echo "Cleaning udev rules..."
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
    echo "Cleaning persistent net rules..."
    rm /etc/udev/rules.d/70-persistent-net.rules
fi

# Cleaning the /tmp directories
echo "Cleaning /tmp directories..."
rm -rf /tmp/*
rm -rf /var/tmp/*

# Cleaning the SSH host keys
echo "Cleaning SSH host keys..."
rm -f /etc/ssh/ssh_host_*

# Cleaning the machine-id
echo "Cleaning machine-id..."
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Cleaning the shell history
echo "Cleaning shell history..."
unset HISTFILE
history -cw
echo >~/.bash_history
rm -fr /root/.bash_history

# Truncating hostname, hosts, resolv.conf and setting hostname to localhost
echo "Cleaning hostname, hosts, resolv.conf and setting hostname to localhost..."
truncate -s 0 /etc/{hostname,hosts,resolv.conf}
hostnamectl set-hostname localhost

# Clean cloud-init
echo "Cleaning cloud-init..."
cloud-init clean

#https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm#linux
/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync

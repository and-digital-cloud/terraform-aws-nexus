#!/bin/bash -e
# -e cancels scripts if anything fails 

# 1. 
apt update -y
apt install wget nfs-common -y
mkdir -p /efs
until host ${efs_mount} > /dev/null;
do
        echo "EFS MOUNT ${efs_mount} NOT AVAILABLE";
	echo "This may take up to 5 minutes if you create a new EFS file system"
        sleep 60;
done
echo "${efs_mount} exists"
mount -t nfs4 -o vers=4.1 ${efs_mount}:/ /efs
echo "${efs_mount}:/ /efs nfs4 rw,vers=4.1 0 0" | sudo tee -a /etc/fstab
mkdir -p /efs/nexus3

# 2. Install OpenJDK 1.8
apt install openjdk-8-jdk -y

# 3. Create a directory named app and cd into the directory 
cd /opt

# 4. Download the latest nexus. You can get the latest download links fo for nexus
wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz

# Untar the downloaded file - compress and decompress
tar -xvf nexus.tar.gz

# Rename the untared file to nexus.
mv nexus-3* nexus

# 5. Create a new user named nexus to run the nexus service. good security practice
useradd nexus

# Change the ownership of nexus files and nexus data directory to nexus user
chown -R nexus:nexus /opt/nexus
chown -R nexus:nexus /opt/sonatype-work
chown -R nexus:nexus /efs/nexus3 

# 6. Open vi /app/nexus/bin/nexus.rc file
echo "run_as_user=\"nexus\"" > '/opt/nexus/bin/nexus.rc'

# 7. Edit the /opt/nexus/bin/nexus.vmoptions file - from -Dkaraf.data=../sonatype-work/ to -Dkaraf.data=../efs/
sed -i 's/..\/sonatype-work/\/efs/g' /opt/nexus/bin/nexus.vmoptions

# 8. Add the Nexus service and start
cat <<EOF > /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

# 9. Add nexus service to boot and starts immediately
systemctl enable nexus --now

# Setup telegraf and hostname config

TELEGRAF="${install_telegraf}"

if [ "$${TELEGRAF}" = true ]; then
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.20.0~rc0-1_amd64.deb -O /tmp/telegraf_1.20.0~rc0-1_amd64.deb
dpkg -i /tmp/telegraf_1.20.0~rc0-1_amd64.deb

INSTANCEID=`curl http://169.254.169.254/latest/meta-data/instance-id 2>/dev/null`
HOSTNAME="${service_name}-$${INSTANCEID}.digital.internal"
hostname "$${HOSTNAME}"
hostname | tee /etc/hostname > /dev/null
sed -i "s/preserve_hostname: false/preserve_hostname: true/g" /etc/cloud/cloud.cfg

cat <<  GLOBALCONF > /etc/telegraf/telegraf.conf
        [global_tags]
        service_name = "${service_name}"
        env = "${environment}"
        instance_id = "$${INSTANCEID}"
        aws_account_name = "${aws_account_name}"

        [agent]
        omit_hostname = false
        interval = "10s"
        round_interval = true
        metric_batch_size = 1000
        metric_buffer_limit = 10000
        collection_jitter = "0s"
        flush_interval = "10s"
        flush_jitter = "0s"
        logfile = "/var/log/telegraf/telegraf.log"
        debug = false
        quiet = false
GLOBALCONF

cat <<  NEXUSCONF > /etc/telegraf/telegraf.d/nexus.conf
        [[inputs.prometheus]]
        urls = [ "http://localhost:8081/service/metrics/prometheus"]
        username = "${metrics_user}"
        password = "${metrics_password}" #Ensure user only has perms to read metrics
        [[outputs.influxdb]]
        database = "${influxdb_database}"
        urls = ["${influxdb_endpoint}"]
NEXUSCONF

# Start telegraf service
systemctl enable telegraf --now

else
echo "Not installing telegraf"
fi
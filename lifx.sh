#!/usr/bin/env sh
cd /opt/lifx
su lifx -c '/opt/lifx/feed.rb' >> /var/log/lifx.log

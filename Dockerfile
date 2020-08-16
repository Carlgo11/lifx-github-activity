FROM alpine

# Install Ruby, LifxLAN, Python & Nokogiri
RUN apk add --no-cache build-base libxml2-dev libxslt-dev ruby-full ruby-dev python3-dev py-pip gcc linux-headers
RUN gem install nokogiri -- --use-system-libraries

# Copy files
COPY . /opt/lifx
WORKDIR /opt/lifx
RUN dos2unix *

# Set permissions
RUN adduser -Dh /tmp/lifx -u 1000 lifx lifx
RUN chown lifx:lifx -R /opt/lifx

# Install lifx.sh as a cron job
COPY lifx.sh /etc/periodic/hourly/lifx
RUN chmod a+x /etc/periodic/hourly/lifx
RUN touch /var/log/lifx.log; chmod 777 /var/log/lifx.log
USER lifx

# Install python dependencies
RUN pip install -r requirements.txt

# Run listener
CMD ruby feed.rb >> /var/log/lifx.log; tail -F /var/log/lifx.log

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
USER lifx

# Install gem dependencies
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle config set path 'vendor/bundle'
RUN bundle install

# Install python dependencies
RUN pip install -r requirements.txt

# Run listener
EXPOSE 6281
CMD ./listen.rb

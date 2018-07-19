FROM ministryofjustice/ruby:2.5.1

# Ensure the pdftk package is installed as a prereq for ruby PDF generation
ENV DEBIAN_FRONTEND noninteractive

# SSH proxy settings
ENV SSH_AUTH_SOCK /tmp/ssh-auth
ENV SSH_AUTH_PROXY_PORT 1234

# install runit, nodejs and pdftk
RUN apt-get update && apt-get install -y runit unzip zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

RUN mkdir -p /usr/src/app
RUN bundle config --global without test:development
WORKDIR /usr/src/app

#COPY Gemfile /usr/src/app/
#COPY Gemfile.lock /usr/src/app/
#COPY et_atos_file_transfer.gemspec /usr/src/app/

#RUN socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork TCP4:$(ip route|awk '/default/ {print $3}'):$SSH_AUTH_PROXY_PORT & bundle install

COPY . /usr/src/app

RUN bundle install

#COPY . /usr/src/app

EXPOSE 8080

CMD ["./run.sh"]

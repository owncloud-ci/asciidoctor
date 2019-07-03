FROM owncloud/ubuntu:16.04

LABEL maintainer="ownCloud DevOps <devops@owncloud.com>" \
  org.label-schema.name="ownCloud CI Asciidoctor" \
  org.label-schema.vendor="ownCloud GmbH" \
  org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["asciidoctor"]

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y tree make ruby ruby-dev zlib1g-dev libxml2-dev bison cmake build-essential && \
  gem install --no-ri --no-rdoc asciidoctor asciidoctor-pdf:1.5.0.alpha.16 rouge coderay pygments.rb concurrent-ruby prawn-gmagick && \
  apt-get purge -y ruby-dev zlib1g-dev libxml2-dev bison cmake build-essential && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY rootfs /

FROM ubuntu:focal

# install phoronix test suite requirements + python
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq install \
          build-essential wget unzip perl perl-base perl-modules libsdl-perl \
          libperl-dev libpcre3-dev mesa-utils zlib1g-dev libpng-dev sqlite php-cli php-xml \
          python3 python3-pip

# install phoronix test suite
RUN cd /tmp \
    && wget https://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.8.2_all.deb \
    && dpkg -i phoronix-test-suite_10.8.2_all.deb \
    && rm -f phoronix-test-suite_10.8.2_all.deb

# install requirements for the python script
ADD requirements.txt /requirements.txt
RUN python3 -m pip install -r /requirements.txt
ADD extract_and_add_meta.py /extract_and_add_meta.py

# set up entrypoint
ADD entry.sh .
RUN chmod a+x entry.sh
ENTRYPOINT /entry.sh

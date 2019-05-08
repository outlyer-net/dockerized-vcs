#FROM debian:stretch-slim

#RUN apt-get update && apt-get install --no-install-recommends curl
#RUN curl http://packages.outlyer.net/public_key.gpg > /tmp/p.o.n.key

FROM debian:stretch-slim
LABEL MAINTAINER="Toni Corvera <outlyer@gmail.com>"

RUN echo deb http://www.deb-multimedia.org stable main non-free | tee -a /etc/apt/sources.list \
    && echo deb http://packages.outlyer.net/debian stable main contrib | tee -a /etc/apt/sources.list

# * Can't clean up on a different step or it has no effect
# * ncurses-term installs the 'pc3' terminfo file (in /usr/share/terminfo) which makes
#     tput stop complaining about 'unknown terminal "pc3"' and enables colour output in vcs
#     (there might be a better way to handle this)
# * TODO: If gawk isn't explicitly installed, mawk will be used instead.
#      gawk adds 3MiB, but should fix script to run on mawk anyway
RUN apt-get update && apt-get install -y --allow-unauthenticated --no-install-recommends \
        vcs \
        ffmpeg \
        gawk \
        mplayer \
        ncurses-term \
     && rm -rf /var/lib/apt/lists/*

# TODO: ? Load username from ENV for signature, instead of root
# TODO: Load custom configuration file

# Avoid errors about unknown TERM types
ENV TERM=linux
WORKDIR /mnt
ENTRYPOINT [ "vcs" ]


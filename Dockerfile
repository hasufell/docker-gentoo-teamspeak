FROM        hasufell/gentoo-amd64-paludis:latest
MAINTAINER  Julian Ospald <hasufell@posteo.de>


##### PACKAGE INSTALLATION #####

# copy paludis config
COPY ./config/paludis /etc/paludis

# update world with our USE flags
RUN chgrp paludisbuild /dev/tty && \
	cave resolve -c world -x && \
	cave resolve -c teamspeakset -x && \
	rm -rf /usr/portage/distfiles/* /var/tmp/paludis/* \
		/var/tmp/portage/*

# update etc files... hope this doesn't screw up
RUN etc-update --automode -5

################################


COPY ./start.sh /usr/bin/teamspeak-start.sh
RUN chmod +x /usr/bin/teamspeak-start.sh

EXPOSE 9987

CMD exec /usr/bin/teamspeak-start.sh

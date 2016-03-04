FROM        mosaiksoftware/gentoo-amd64-paludis:latest
MAINTAINER  Julian Ospald <hasufell@gentoo.org>


##### PACKAGE INSTALLATION #####

# copy paludis config
COPY ./config/paludis /etc/paludis

RUN chgrp paludisbuild /dev/tty && \
	git -C /usr/portage checkout -- . && \
	env-update && \
	source /etc/profile && \
	cave sync gentoo && \
	mkdir -p /usr/portage/distfiles && \
	cave resolve -c world -x && \
	cave resolve -c teamspeakset -x && \
	cave resolve -c tools -x && \
	cave fix-linkage -x && \
	rm -rf /var/cache/paludis/names/* /var/cache/paludis/metadata/* \
		/var/tmp/paludis/* /usr/portage/* /srv/binhost/*

# update etc files... hope this doesn't screw up
RUN etc-update --automode -5

################################


COPY ./start.sh /usr/bin/teamspeak-start.sh
RUN chmod +x /usr/bin/teamspeak-start.sh

EXPOSE 9987

CMD exec /usr/bin/teamspeak-start.sh

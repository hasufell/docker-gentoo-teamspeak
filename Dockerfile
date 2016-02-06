FROM        mosaiksoftware/gentoo-amd64-paludis:latest
MAINTAINER  Julian Ospald <hasufell@gentoo.org>


##### PACKAGE INSTALLATION #####

RUN rm /etc/paludis/package_mask.conf.d/binhost.conf

# copy paludis config
COPY ./config/paludis /etc/paludis

# update world with our USE flags
RUN chgrp paludisbuild /dev/tty && cave resolve -c world -x

# install umurmurset set
RUN chgrp paludisbuild /dev/tty && cave resolve -c teamspeakset -x

# install tools set
RUN chgrp paludisbuild /dev/tty && cave resolve -c tools -x

# update etc files... hope this doesn't screw up
RUN etc-update --automode -5

################################


COPY ./start.sh /usr/bin/teamspeak-start.sh
RUN chmod +x /usr/bin/teamspeak-start.sh

EXPOSE 9987

CMD exec /usr/bin/teamspeak-start.sh

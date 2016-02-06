## Installation

```sh
docker build -t mosaiksoftware/gentoo-teamspeak .
```

## Configuration

All configuration variables from
`/usr/share/doc/teamspeak-server-bin-*/server_quickstart.txt`
can simply be set when starting the container via the `-e` switches. E.g.
if you want to set `logpath="/path/to/logs"` you just pass
`-e logpath="/path/to/logs"` to the `docker run` command.

If you don't like the `-e`-foo you can mount in a configuration file
and tell teamspeak to use it via `-e inifile=/path/to/config/server.conf`.

Data files will usually be created at `/var/lib/teamspeak3-server/`, unless
you overwrite all those locations. So it might make sense to use a data volume
for that location or mount in a host folder.

## Running

A full command could look like this:

```sh
docker run -ti -d \
	--name=teamspeak3 \
	-p 9987:9987/udp \
	-p 30033:30033 \
	-p 10011:10011 \
	-e dbsqlpath=/opt/teamspeak3-server/sql/ \
	-v /srv/teamspeak:/var/lib/teamspeak3-server/ \
	mosaiksoftware/gentoo-teamspeak
```

Then examine the logs via `docker logs teamspeak3` to get your admin account
information.

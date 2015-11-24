#!/bin/bash

set -e

print_cmd_args() {
	local i
	local cmd_args=(
		default_voice_port
		voice_ip
		create_default_virtualserver
		machine_id
		filetransfer_port
		filetransfer_ip
		query_port
		query_ip
		clear_database
		logpath
		dbplugin
		dbpluginparameter
		dbsqlpath
		dbsqlcreatepath
		licensepath
		createinifile
		inifile
		query_ip_whitelist
		query_ip_blacklist
		query_skipbruteforcecheck
		dbclientkeepdays
		dblogkeepdays
		logquerycommands
		no_permission_update
		open_win_console
		no_password_dialog
		dbconnections
		logappend
	)

	for i in ${cmd_args[@]} ; do
		if [[ ${!i} ]] ; then
			echo "${i}=${!i} "
		fi
	done
}


BASEDIR="/opt/teamspeak3-server"

cd "/var/lib/teamspeak3-server"

exec sudo -u teamspeak3 -g teamspeak3 \
	LD_LIBRARY_PATH="${BASEDIR}${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}" \
	"${BASEDIR}/sbin/ts3server-bin" -- \
	$(print_cmd_args)

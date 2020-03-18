#! /bin/bash
# TODO: add help menu
# TODO: add support for parameters (container name, volume, etc)

docker cp DM_SH.DMP vigorous_gauss:/opt/oracle/admin/XE/dpdump/
docker cp import.sql vigorous_gauss:/
docker exec -it --tty --user root --workdir / vigorous_gauss bash -c "chown oracle /opt/oracle/admin/XE/dpdump/DM_SH.DMP"

docker exec -it vigorous_gauss bash -c "chmod 777 /opt/oracle/admin/XE/dpdump/DM_SH.DMP";

# sql instructions;
docker exec -it vigorous_gauss bash -c "sqlplus sys/Oradoc_db1@localhost:1521/XE as sysdba << SCRIPT
@ /import.sql
exit;
SCRIPT"
docker exec -it vigorous_gauss bash -c 'impdp \"sys/Oradoc_db1 as sysdba\" REMAP_SCHEMA=dm:student DIRECTORY=MY_IMPORT_DIR DUMPFILE=DM_SH.DMP;'

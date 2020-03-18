#! /bin/bash
# TODO: add help menu
# TODO: add support for parameters (container name, volume, etc)
containerId="$(docker ps | grep 'arcilli/ecbd-oracle-db:12.2.0.1-ee' | awk '{print $1}')"
echo "$containerId is running the Oracle server.";

docker cp ./DM_SH.DMP "$containerId":/opt/oracle/admin/XE/dpdump/
docker cp ./import.sql "$containerId":/
docker exec -it --tty --user root --workdir / "$containerId" bash -c "chown oracle /opt/oracle/admin/XE/dpdump/DM_SH.DMP"

docker exec -it "$containerId" bash -c "chmod 777 /opt/oracle/admin/XE/dpdump/DM_SH.DMP";

# sql instructions;
docker exec -it "$containerId" bash -c "sqlplus sys/Oradoc_db1@localhost:1521/XE as sysdba << SCRIPT
@ /import.sql
exit;
SCRIPT"
docker exec -it "$containerId" bash -c 'impdp \"sys/Oradoc_db1 as sysdba\" REMAP_SCHEMA=dm:student DIRECTORY=MY_IMPORT_DIR DUMPFILE=DM_SH.DMP';

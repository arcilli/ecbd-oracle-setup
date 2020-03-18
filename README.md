# Database setup - Oracle EE 12c
Script for setup an instance of Oracle EE 12c, used at data mining laboratory.

## Prerequisites
Docker should be installed on the machine. Also, please make sure that you can execute docker without root privilege.
<p>For installing docker, check  https://docs.docker.com/install/linux/docker-ce/debian/ and for execute docker commands 
as non-root user, check https://docs.docker.com/install/linux/linux-postinstall/.
</p>

## Installation
```bash
docker run --name <container-name> -p 1521:1521 -p 5500:5500 -e \ 
ORACLE_SID=XE -e ORACLE_PWD=Oradoc_db1 arcilli/ecbd-oracle-db:12.2.0.1-ee
```

After the database is started, run
```bash
chmod +x script.sh
./script.sh
```
After the script is executed and the dump file is imported, you can use the database.</p>

## Configuration
By default, the script creates an user **student** with pass **student**.
It imports the dmp file from the repository. Also, a tablespace named *example* is created. 

## Usage
For the moment, the image does not support volumes, so the data will not be persisted if the container is removed and a
new one is created. 
<p>For this reason, please use `docker start container-name` instead of creating a new one with `docker run image-name`.
</p>

The database is self closing at CTRL+C or `docker-stop container-name`.

## Credits
This repository is based on https://github.com/oracle/docker-image. The docker image was build using
the official sources of OracleDB 12.2.0.1 and is hosted on dockerhub.

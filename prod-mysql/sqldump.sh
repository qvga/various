#!/bin/bash
/snap/bin/docker exec mysql sh -c 'exec nice -n 20 mysqldump --triggers --routines --events --all-databases --add-drop-database -uroot -p"$MYSQL_ROOT_PASSWORD"' | gzip -9  > ~/sqldump_$(date +%w).sql.gz

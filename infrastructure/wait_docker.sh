 #!/usr/bin/env bash

set -e

MAX_COUNTER=100
COUNTER=1

echo "Waiting for MySQL server…"
while ! docker-compose exec -T db mysql --protocol TCP -uroot -proot -e "show databases;" > /dev/null 2>&1; do
    COUNTER=$((${COUNTER} + 1))
    if [ ${COUNTER} -gt ${MAX_COUNTER} ]; then
        echo "We have been waiting for MySQL too long already; failing." >&2
        exit 1
    fi;
    sleep 1
done

echo "MySQL server is running!"

# !/bin/bash

#if [ -x "$(command -v xterm)" ]; then
#    echo "xterm is installed"
#else
#    sudo apt-get install xterm -y
#fi
#xterm -hold -e cat dump.sql | docker exec -i yellowpages_db_1 psql -U postgres
rake db:create db:migrate

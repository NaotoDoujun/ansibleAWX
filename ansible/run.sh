#!/bin/bash
export COMPOSE_HTTP_TIMEOUT=1200
cd /awx/installer/ && ansible-playbook -i inventory -e project_data_dir=/var/lib/awx/projects install.yml
tail -f /dev/null &
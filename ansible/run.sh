#!/bin/bash
export COMPOSE_HTTP_TIMEOUT=1200
cd /awx/installer/ && ansible-playbook -i inventory install.yml
tail -f /dev/null &
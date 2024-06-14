#!/bin/sh
/usr/sbin/sshd -f ${HOME}/.local/my_sshd/sshd_config &
bash -ic 'jupyter lab --notebook-dir=${HOME} --ip 0.0.0.0 --no-browser --allow-root --port 8888'

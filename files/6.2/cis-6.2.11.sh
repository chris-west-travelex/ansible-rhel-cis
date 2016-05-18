#!/bin/bash
RET=0
for dir in `/bin/cat /etc/passwd |\
  /bin/awk -F: '{ print $6 }'`; do
  if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ]; then
    echo ".forward file $dir/.forward exists"
    RET=1
  fi
done

exit ${RET}

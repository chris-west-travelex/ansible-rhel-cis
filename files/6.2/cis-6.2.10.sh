#!/bin/bash
RET=0
for dir in `/bin/cat /etc/passwd | /bin/egrep -v '(root|halt|sync|shutdown)' |\
  /bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
  for file in $dir/.rhosts; do
    if [ ! -h "$file" -a -f "$file" ]; then
      echo ".rhosts file in $dir"
      RET=1
    fi
  done
done

exit ${RET}

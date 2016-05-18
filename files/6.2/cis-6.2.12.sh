#!/bin/bash
RET=0
for dir in `/bin/cat /etc/passwd |\
  /bin/awk -F: '{ print $6 }'`; do
  if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then
    echo ".netrc file $dir/.netrc exists"
    RET=1
  fi
done

exit ${RET}

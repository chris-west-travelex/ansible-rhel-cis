#!/bin/bash
RET=0

cat /etc/passwd | cut -f1 -d":" | /bin/sort -n | /usr/bin/uniq -c |\
  while read x ; do
  [ -z "${x}" ] && break
  set - $x
  if [ $1 -gt 1 ]; then
    uids=`/bin/gawk -F: '($1 == n) { print $3 }' n=$2 \
      /etc/passwd | xargs`
    echo "Duplicate User Name ($2): ${uids}"
    RET=1
  fi
done

exit ${RET}

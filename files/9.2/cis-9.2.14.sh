#!/bin/bash
RET=0
echo "The Output for the Audit of Control 9.2.14 - Check for Duplicate UIDs is"
/bin/cat /etc/passwd | /bin/cut -f3 -d":" | /bin/sort -n | /usr/bin/uniq -c |\
  while read x ; do
  [ -z "${x}" ] && break
  set - $x
  if [ $1 -gt 1 ]; then
    users=`/bin/gawk -F: '($3 == n) { print $1 }' n=$2 \
      /etc/passwd | /usr/bin/xargs`
    echo "Duplicate UID ($2): ${users}"
    RET=1
  fi
done

exit ${RET}

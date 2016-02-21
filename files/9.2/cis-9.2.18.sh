#!/bin/bash
RET=0
echo "The Output for the Audit of Control 9.2.18 - Check for Duplicate Group Names is"
cat /etc/group | cut -f1 -d":" | /bin/sort -n | /usr/bin/uniq -c |\
  while read x ; do
  [ -z "${x}" ] && break
  set - $x
  if [ $1 -gt 1 ]; then
    gids=`/bin/gawk -F: '($1 == n) { print $3 }' n=$2 \
      /etc/group | xargs`
    echo "Duplicate Group Name ($2): ${gids}"
    RET=1
  fi
done

exit ${RET}

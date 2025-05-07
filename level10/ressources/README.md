# TOCTOU Race Condition Exploit

This level had a `setuid` executable that sent a file to a remote host. By running `strace`, we saw the following sequence:

1. `access()` was used to check if the user had permission to read the file.

2. It connected to the remote host.

3. Then `open()` was called to read the file.

This introduced a **Time-Of-Check to Time-Of-Use (TOCTOU)** vulnerability: we could swap the file between the `access` and `open` calls.

To exploit it, we created a loop that constantly replaced a file with a symlink to the protected `token` file. While the loop ran, we launched the vulnerable binary to send that file to our machine via netcat:
```
nc -l 6969
```
After a few attempts, the binary sent the contents of the `token` file to our listener, and we got the flag.

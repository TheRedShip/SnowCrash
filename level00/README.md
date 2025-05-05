## level00

- **How we found it**

	Used `find` to locate files owned by `flag00`:  

	```bash
	find / -user flag00 2>/dev/null
	```

	This revealed two copies of the john binary:

	```bash
	/usr/sbin/john
	/rofs/usr/sbin/john
	```

	Both files, when using `cat`, output a short string:

	```bash
	cat /usr/sbin/john
	cdiiddwpgswtgt
	```

	That string is a simple Caesar cipher which decrypts to:

	```
	nottoohardhere
	```

	Then we just needed to use that password

	```bash
	su flag00
	# Password: nottoohardhere

	getflag
	# Check flag. Here is your token: x24ti5gi3x0ol2eh4esiuxias
	```

- **Utility of this exercise**

	Demonstrates file‑ownership enumeration and basic cipher cracking; purely educational.

- **How to patch**
	- Remove or relocate sensitive files  world-readable locations.

	- Tighten permissions:

	```bash
		chmod 750 /usr/sbin/john
		chown root:root /usr/sbin/john
	```

	- Avoid placing secret binaries on publicly mounted or read‑only file systems.

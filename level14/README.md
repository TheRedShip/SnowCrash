# Bypassing Anti-Debug and UID Check in getflag

In this level, the `getflag` binary called `ptrace` at the beginning to detect debugging. If `ptrace` failed (i.e., returned a non-zero value), the program exited.

To bypass this, we used `gdb` and, right after the `ptrace` call, forced `$eax` to `0` to make it appear successful.

Next, we set a breakpoint on `getuid`. After the call, we changed the returned UID to `3014`, which corresponds to the `flag14` user.

Stepping through the program, we eventually reached a function named `ft_des`, which was used in previous levels to print the flag. At that point, the program printed the flag successfully.

Running the binary showed:
```
UID 2013 started us but we expect 4242
```
This suggested the program checks the current UID with `getuid()` and expects it to be `4242`.

We used `gdb` to reverse the binary. After the `getuid` call, we manually set the return value (`$eax`) to `4242` and stepped through the rest of the program.

Later, we found a call to a function named `ft_des`. We examined `$eax` at that point:
```
x/s $eax
```
It pointed to the string:
```
"2A31L79asukciNyi8uppkEuSx"
```
That was the flag.

# Code Execution via preg_replace /e Vulnerability

We were given a PHP script that uses preg_replace with the /e modifier:
```
preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
```
The `/e` flag causes the replacement string to be evaluated as PHP code, making it a code injection vector.

We found that directly injecting commands using quotes didn’t work, but we noticed the second argument `$z` of the `x()` function was unused in the replacement. So we passed our command (`getflag`) as that argument and referenced it in the file as:
```
[x {${system($z)}}]
```
Running the script like this:
```
./level06 /tmp/test getflag
```
Successfully executed `getflag` and gave us the flag.

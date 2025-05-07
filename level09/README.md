# Reversing Offset Encoding

The program in this level printed the input string after adding the character’s index to its ASCII value. For example:
```
Input:  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
Output: abcdefghijklmnopqrstuvwxyz{|}~
```
We found a `token` file whose contents were encoded using this same logic. By reading the file and reversing the transformation—subtracting each byte’s index from its value—we were able to recover the original string.

This gave us the password for the `flag` user, and we used `getflag` to retrieve the flag.

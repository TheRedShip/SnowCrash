# CTF Flag Discovery - Packet Analysis
## Overview

For this challenge, we were given a .pcap file containing a sequence of network packets. The goal was to extract a hidden flag or password from the captured traffic.
## Methodology

- Packet Inspection  
We opened the .pcap file using Wireshark and looked for any readable or suspicious payloads.

- Keyword Detection  
One packet ended with the string password:, suggesting the secret was transmitted right after.

- Hex Analysis  
After password:, the following hex sequence appeared:

```
66 74 5f 77 61 6e 64 72 7f 7f 7f 4e 44 52 65 6c 7f 4c 30 4c 0c
```

Using an ASCII table, we found that 7f represents the Backspace character.

Reconstructing the Password
Interpreting the string with backspaces applied:
```
    Input:   f t _ w a n d r <BS> <BS> <BS> N D R e l <BS> L 0 L
    Output:  f t _ w a N D R e L 0 L
```

## Result

The extracted password is:  
**ft_waNDReL0L**  
We can now login and execute the command getflag to get the flag

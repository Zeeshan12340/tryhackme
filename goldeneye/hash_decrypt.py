from HTMLParser import HTMLParser
import re
x = '&#73;&#110;&#118;&#105;&#110;&#99;&#105;&#98;&#108;&#101;&#72;&#97;&#99;&#107;&#51;&#114;'
x = re.sub(r'(&#[0-9]*)', r'\1;', x)
h = HTMLParser()
print h.unescape(x)
#!/usr/bin/env python
#
# This script write the hex 0-255 representation useful to spot bad characters
# when writing an exploit.

a=""
for x in range(1,256):
    if x < 16:
        a+="\\x0"+format(x, "x")
    else:
        a+="\\x"+format(x, "x")
print "bad_chars=\"" + a + "\""

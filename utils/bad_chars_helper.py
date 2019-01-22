#!/usr/bin/env python
#
# This script write the hex 0-255 representation useful to spot bad characters
# when writing an exploit.
import argparse

parser=argparse.ArgumentParser(description='Generate ASCII characters list in hex format')
parser.add_argument('-b', '--bad', help='bad characters list')
parser.add_argument('-v', '--variable', help='specify the variable name to use in output')

args = parser.parse_args()

var_name="bad_chars"

if args.variable is not None:
  var_name=args.variable

a=""

for x in range(0,256):
    if x < 16:
        a+="\\x0"+format(x, "x")
    else:
        a+="\\x"+format(x, "x")
if args.bad is None: 
  print var_name+"=\"" + a + "\""
else:
  print var_name+"=\"" + a.replace(args.bad, "") + "\""
  

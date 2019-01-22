a=""
for x in range(1,256):
    if x < 16:
        a+="\\x0"+format(x, "x")
    else:
        a+="\\x"+format(x, "x")
print a

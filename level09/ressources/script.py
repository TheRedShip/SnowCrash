str = ""
with open("token", 'rb') as file:
    str = file.read()

str = str[:-1]
print("".join([chr(str[x] - x) for x in range(len(str))]))

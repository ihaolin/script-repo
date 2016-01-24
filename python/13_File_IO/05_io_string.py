import io

# new a buffer string
s = io.StringIO()
print(s.write('Hello, StringIO'))

print('This is a test of StringIO', file=s)

# Get all of the data written so far
print(s.getvalue())

# Wrap a file interface around an existing string
s = io.StringIO('Hello\nPython\n')
print(s.read(4))
print(s.read())

s = io.BytesIO()
s.write(b'binary data')
print(s.getvalue())
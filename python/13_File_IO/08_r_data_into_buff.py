import os.path

def read_into_buffer(filename):
    '''
        read a file's binary content into a buffer
    '''
    buf = bytearray(os.path.getsize(filename))
    with open(filename, 'rb') as f:
        f.readinto(buf)
    return buf

with open('sample.bin', 'wb') as f:
    f.write(b'Hello, Python')

buf = read_into_buffer('sample.bin')
print(buf)

# write buff to a new file
buf[0:5] = b'Hallo'

with open('newsample.bin','wb') as f:
    f.write(buf)

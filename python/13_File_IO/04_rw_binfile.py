import array

nums = array.array('i', [1,2,3,4])
with open('data.bin', 'wb') as f:
    f.write(nums)

a = array.array('i', [0,0,0,0,0,0])
with open('data.bin', 'rb') as f:
    f.readinto(a)
print(a)


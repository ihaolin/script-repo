man = []
other = []

#read content from a file
try:
    #read a file input
    data = open('sketch.txt')

    #data handle
    for each_line in data:
        #if not each_line.find(':') == -1:
        try:
            (role, line_spoken) = each_line.split(':',1)
            line_spoken = line_spoken.strip()
            if role == 'Man':
                man.append(line_spoken)
            elif role == 'Other Man':
                other.append(line_spoken)
        except ValueError:
            pass
    #close the file input
    data.close()
except IOError:
    print("the file is missing!")

#write data to file by use with(a context management tech)
try:
    with open('man_data.txt', 'w') as man_file:
        print(man, file=man_file)
    with open('other_data.txt', 'w') as other_file:
        print(other, file=other_file)
except IOError as e:
    print('写文件失败:'+str(e))


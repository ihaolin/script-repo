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

#write data to file
try:
    man_file = open('man_data.txt', 'w')
    other_file = open('other_data.txt', 'w')

    print(man, file=man_file)
    print(other, file=other_file)
except IOError as e:
    print('写文件失败:'+str(e))
finally:
    if  'man_file' in locals():
        man_file.close()
    if 'other_file' in locals():
        other_file.close()

try:
    #read a file input
    data = open('sketch.txt')

    #data handle
    for each_line in data:
        #if not each_line.find(':') == -1:
        try:
            (role, line_spoken) = each_line.split(':',1)
            print(role, end='')
            print(' said:', end='')
            print(line_spoken, end='')
        except ValueError:
            pass
    #close the file input
    data.close()
except IOError:
    print("the file is missing!")


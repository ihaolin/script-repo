import pickle

try:
    with open('man_data.txt', 'wb') as man_file, open('other_data.txt', 'wb') as other_file:
        pickle.dump('haha', man_file)
        pickle.dump('hehe', other_file)
except IOError as ie:
    print('IO error'+str(ie))
except pickle.PickleError as pe:
    print('Pickle error:'+str(pe))


from athletemodel import Athlete
'''
class Athlete:
    def __init__(self, name, dob=None, times=[]):
        self.name = name
        self.dob = dob
        self.times = times

    def top3(self):
        return sorted(set([sanitize(t) for t in self.times]))[0:3]

    def add_time(self, time_value):
        self.times.append(time_value)

    def add_times(self, list_of_times):
        self.times.extend(list_of_times)

# handle the input string
def sanitize(time_string):
    if '-' in time_string:
        splitter = '-'
    elif ':' in time_string:
        splitter = ':'
    else:
        return(time_string)
    (mins, secs) = time_string.split(splitter)
    return (mins+'.'+secs)
'''
# read a file
def get_coach_data(filename):
    try:
        with open(filename) as f:
            data = f.readline()
            listData = data.strip().split(',')
            return Athlete(listData.pop(0), listData.pop(0), listData)
    except IOError as ioerr:
        print('File error: ' + str(ioerr))
        return(None)

sarah = get_coach_data('sarah2.txt')
james = get_coach_data('james2.txt')
julie = get_coach_data('julie2.txt')
mikey = get_coach_data('mikey2.txt')
#(sarah_name, sarah_dob) = sarah.pop(0), sarah.pop(0)
#print(sarah_name + "'s fastest times are: "+ str(sorted(set([sanitize(t) for t in sarah]))[0:3]))

#we use dict
#print(james['Name'] + '\'s fastest times are: ' + james['Times'])
#print(julie['Name'] + '\'s fastest times are: ' + julie['Times'])
#print(mikey['Name'] + '\'s fastest times are: ' + mikey['Times'])

print(sarah.name + '\'s fastest times are: ' + str(sarah.top3()))
print(james.name + '\'s fastest times are: ' + str(james.top3()))
print(julie.name + '\'s fastest times are: ' + str(julie.top3()))
print(mikey.name + '\'s fastest times are: ' + str(mikey.top3()))

print('after add_times to james:')
james.add_times(['1.01', '2.17', '2-51']);
print(james.name + '\'s fastest times are: ' + str(james.top3()))



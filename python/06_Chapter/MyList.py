
# define a class inheriting list

class MyList(list):
    def __init__(self, name):
        list.__init__([])
        self.name = name

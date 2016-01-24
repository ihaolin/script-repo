import json
from collections import OrderedDict

json_str = '{"name": "ACME", "shares": 50, "price": 490.1}'

#turn json to dict:

data = json.loads(json_str,object_pairs_hook=OrderedDict)

print(data)
print(data['name'])

#turn json to obj:

class JSONObject:
    def __init__(self, d):
        self.__dict__ = d

data = json.loads(json_str, object_hook=JSONObject)

print(data)
print(data.name)

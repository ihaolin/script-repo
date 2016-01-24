import json

data = [{
    'name':'Linhao',
    'sex':'男',
    'age':22
},{
    'name':'Linhao1',
    'sex':'男',
    'age':22
},{
    'name':'Linhao2',
    'sex':'男',
    'age':22
}]

# obj to json str
json_str = json.dumps(data,indent=2)
print(json_str)

print(json.loads(json_str))


# write json file
with open('data.json', 'w') as f:
    json.dump(data, f)

# read from a .json file
with open('data.json', 'r') as f:
     data = json.load(f)
     print(data)

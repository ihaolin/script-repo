from urllib import request, parse

url = 'http://www.baidu.com/'

u = request.urlopen(url)

repo = u.read();

print(str(repo))
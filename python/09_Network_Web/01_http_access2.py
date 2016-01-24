import requests

url = 'http://www.google.com/'

repo = requests.head(url)

print(repo.status_code)
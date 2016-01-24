from urllib.request import urlopen
from xml.etree.ElementTree import parse

# Download the RSS feed and parse it
# u = urlopen('http://planet.python.org/rss20.xml')
# doc = parse(u)

# load local xml
doc = parse('data.xml')

# Extract and output tags of interest
for item in doc.iterfind('channel/item'):
    (title, date, link) = item.findtext('title'),\
                          item.findtext('pubDate'),\
                          item.findtext('link')
    print(title)
    print(date)
    print(link)
    print()
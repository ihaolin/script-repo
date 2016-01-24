from xml.etree.ElementTree import parse, Element

class XMLNamespaces:

    def __init__(self, **kwargs):
        self.namespaces = {}
        for name, uri in kwargs.items():
            self.register(name, uri)

    def register(self, name, uri):
        self.namespaces[name] = '{'+uri+'}'

    def __call__(self, path):
        return path.format_map(self.namespaces)

doc = parse('ns.xml')
ns = XMLNamespaces(html='http://www.w3.org/1999/xhtml')
print(ns('content/{html}html'))
print(doc.find(ns('content/{html}html')))
print(doc.findtext(ns('content/{html}html/{html}head/{html}title')))
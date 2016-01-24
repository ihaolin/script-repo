from xml.etree.ElementTree import parse, Element

doc = parse('pred.xml')

root = doc.getroot()

# remove
root.remove(root.find('sri'))
root.remove(root.find('cr'))

# find
print(root.getchildren().index(root.find('nm')))

# insert
e = Element('spam')
e.text = 'This is a test'
root.insert(2, e)

# Write back to a file
doc.write('newpred.xml', xml_declaration=True)
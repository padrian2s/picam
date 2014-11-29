from lxml.html import parse
import requests


doc = parse('http://www.gaisma.com/en/location/timisoara.html').getroot()

for div in doc.cssselect('td'):
 print '%s %s' % (div.text_content())
import urllib.request
import urllib.parse
#import urllib.o


# let's do this...
#url = urllib.request.urlopen("http://www-inst.eecs.berkeley.edu/~selfpace/cs9honline/P2b/#checklist")
#html = str(url.read())
#print(html.split())
#for word in html.split():
#    if 'on' in word:
#        print('on')


url='http://pythonprogramming.net'
values={'s':'basic',
            'submit':'search'}
data=urllib.parse.urlencode(values)
data= data.encode('utf-8')
req=urllib.request.Request(url,data)
resp=urllib.request.urlopen(req)
respData=resp.read()

print(respData)

try:
    x=urllib.request.urlopen('https://www.google.com/search?q=test')

    print(x.read())

except Exception as e:
    print(str(e))

## Do something with html, parse it and format it in a pretty way
#url.close()

#https://www.youtube.com/watch?v=5GzVNi0oTxQ
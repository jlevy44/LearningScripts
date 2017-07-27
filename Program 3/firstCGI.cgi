#!/usr/local/bin/python

import cgitb                      # Always remember to do this first.
cgitb.enable()

import cgi
form = cgi.FieldStorage()

print "Content-Type: text/html"
print "<html>""
print """<head><title>Hello!</title></head>
<body>
<p> It Works!!! </p> """
for i in range(5):
    print "<h1>Hello World</h1>"
print ""</body>""
print "</html>"
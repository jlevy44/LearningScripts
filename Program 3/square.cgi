#!/usr/local/bin/python

import cgitb                      # Always remember to do this first.
cgitb.enable()

import cgi
form = cgi.FieldStorage()

x = int(form['number'].value)     # Values are strings, so we need to convert.

print 'Content-Type: text/html'
print
print 'The square of', x, 'is', x*x, '.'
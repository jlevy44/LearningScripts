#!/usr/local/bin/python

print 'Content-Type: text/html'
print
print '<h1>Hello!</h1>'

print """<form action="square.cgi">
Please enter a number:
<input type=text name=number>
<input type=submit value="Okay.">
</form>"""
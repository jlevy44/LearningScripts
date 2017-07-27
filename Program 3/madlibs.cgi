#!/usr/local/bin/python

# import libraries and modules
import random
import cgitb                      # Always remember to do this first.
cgitb.enable()
import cgi
form = cgi.FieldStorage()

# generates which lexical group will be used for madlibs
random.seed()
randomSentence=random.randint(0,4)

# lexical groups
randomSentenceCombinations=[['adjective1','noun1','verb1'], ['noun1','noun2','verb1'],['verb1','noun1','pronoun1'],
    ['adjective1','adjective2','verb1'],['verb1','verb2','noun1']]
randomSentenceChoice=randomSentenceCombinations[randomSentence]

# lexical group names
rand1=str(randomSentenceChoice[0])
rand2=str(randomSentenceChoice[1])
rand3=str(randomSentenceChoice[2])

# tuple of lexicals and their corresponding names that will be shown in the prompts
randomSentencePrompt=(rand1[:len(rand1)-1],rand1,rand2[:len(rand2)-1],rand2,rand3[:len(rand3)-1],rand3,randomSentence)

# print a form that asks for lexicals... inputs tuple into list
print 'Content-Type: text/html'
print
print '<h1>Hello! Welcome to my madlibs prompt!</h1>'

# direct prompts
print """<form action="sentence.cgi">
Please enter a %s: <br>
<input type=text name=%s>
<br> Please enter a %s: <br>
<input type=text name=%s>
<br> Please enter an %s: <br>
<input type=text name=%s>
<input type=hidden name="randSentType" value=%d>
<input type=submit value="Okay.">
</form>""" %randomSentencePrompt #tuple import is here


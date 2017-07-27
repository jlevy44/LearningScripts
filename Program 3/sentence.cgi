#!/usr/local/bin/python

# importing modules
import random
import cgitb                      # Always remember to do this first.
cgitb.enable()
import cgi

# importing form info from madlibs
form = cgi.FieldStorage()

def choose_Sentence(groupNumber,form):
    """
    choose_Sentence inputs the lexical group number and the form that came from the madlibs cgi. It uses the group
    number to choose the lexical group to be used and the sentence type to be used, the form helps input the words
    to be used in the madlib sentences that are decided by the lexical group number. The sentence is the output...
    """

    # decide what kind of lexical categories to use based on random selection from madlibs.cgi
    randomSentenceCombinations=[['adjective1','noun1','verb1'], ['noun1','noun2','verb1'],['verb1','noun1','pronoun1'],
        ['adjective1','adjective2','verb1'],['verb1','verb2','noun1']]
    randomSentenceChoice=randomSentenceCombinations[groupNumber]

    # tuple group containing madlibs word inputs
    words = (form[randomSentenceChoice[0]].value, form[randomSentenceChoice[1]].value,
        form[randomSentenceChoice[2]].value)

    # these are the sentences to be chosen
    Sentences=[['The %s %s %s with the toy.' %words,
        'Interestingly, a %s dinosaur is always seeking %s to %s.' %words],
        ['This is a %s that will teach %s to %s.' %words,
        'I have a %s, that one day, my %s will %s.' %words],
        ['It is time to %s a %s to %s.' %words,
        'Daniel said to %s in a %s is never, according to %s, a good idea.' %words],
        ['The %s policeman yelled at the %s pedestrian as he %s for the hell of it.' %words,
        'A %s man with %s features is hard to %s.' %words],
        ['The woman was %s into the chair as the Spanish Inquisition %s to her %s.' %words,
        'To %s is human; to %s is divine and %s is just fantastic.' %words]]

    # sentence is chosen from the form input of the madlibs.cgi
    sentenceType=Sentences[groupNumber]

    # out of the two possible sentences for the given lexical category, select one at random
    random.seed()
    sentenceFinal=sentenceType[random.randint(0,1)]

    return sentenceFinal


# output of program...
print 'Content-Type: text/html'
print
print '<h1>'+choose_Sentence(int(form['randSentType'].value),form)+'</h1>'

# try again???
print """<p> <a href="http://inst.eecs.berkeley.edu/~cs9h-at/madlibs.cgi">Click Here to Try Another One!!!</a> </p>"""
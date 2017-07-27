import urllib.request
import urllib.parse
import urllib.error

"""
This function will take a text input, and search for that word on Thesaurus.com and return many possible synonyms....
"""

# start program welcome
print('Hello, welcome to thesaurus of Joshua Levy. ')

def pretty_Word(word,wordList):
    """
    pretty_Word inputs a word and checks to make sure that the word is not blank, is not duplicated in wordList, is not
    too long, and properly formats a word that has a space represented by %20; this word is fed back into the main
    thesaurus app
    """
    # read a word and format it correctly else change word for word's removal from list
    # word goes to first quotation mark
    word=word[:word.find('"')]

    # if word is blank, get rid of it, or if too long, get rid of it
    if word=='':
        word='NaN'
    elif len(word)>25:
        word='NaN'

    # if word is duplicate, get rid of it
    if word in wordList:
        word='NaN'

    # split and recombine string
    word=word.replace('%20',' ')

    return word


def thesaurus():
    """
    thesaurus() inputs nothing, but can call itself again if a word does not exist or cannot be found on the thesaurus
    database or if the synonyms have been shown. This function asks for a user input for a word, and then searches for
    that word on thesaurus.com and prints synonyms to the word and then repeats the function.
    """

    # initialization
    wordList=[]

    #opening script
    # input name of word you want to find the definition for
    searchName=input('Please type in the word you would like to find a synonym of or'
                     ' press q to quit: ')
    #quit app if user wants to quit
    if searchName.lower()=='q':
        return

    # restart prompt if bad input (not a string, or contains some bad characters)
    try:
        str(searchName)
    except ValueError:
        return thesaurus()
    bad_characters=['!','@','#','$','%','^','&','*','(',')']
    for char in bad_characters:
        if char in searchName:
            print('Bad Input!!!\n')
            return thesaurus()

    # try to open the url of the thesaurus search, if can't find it, then cannot find the proper word
    try:
        url = urllib.request.urlopen('http://www.thesaurus.com/browse/'+searchName.lower())
    except urllib.error.HTTPError:
        print('We could not find the word you were looking for!!!\n')
        return thesaurus()
    # read the html file and convert it into a string for analysis
    url_Read = str(url.read())

    # close the url, we don't need it anymore
    url.close()

    #if bad query returning no results, reset app
    if 'not a match on Thesaurus.com' in url_Read:
        print('We could not find the word you were looking for!!!\n')
        return thesaurus()


    # limit the part of html that the function will look through to that which contains the synonyms and nothing else
    cutoff1='synonym-description'
    cutoff2='synonym_of_synonyms_0'
    url_Read = url_Read[url_Read.find(cutoff1):url_Read.find(cutoff2)]
    # find every instance of it that usually contains the synonyms, the synonyms are by a browse thing
    url_List=url_Read.find('browse/')


    # generate 15 words that can be found right next to each instance in the html code that browse is displayed
    for i in range (15):
        url_List=url_Read.find('browse/',url_List+1)
        wordArea=url_Read[url_List:url_List+100]
        wordList.append(wordArea[wordArea.rfind('/')+1:wordArea.rfind('"')])

    # for each word, reformat the word or remove it from list using NaNs
    for i in range(len(wordList)):
        wordList[i]=pretty_Word(wordList[i],wordList)

    # and finally the output!!!
    print('Here are a list of synonyms of '+searchName.lower())
    for word in wordList:
        if word != 'NaN':
            print(word)
    print('')

    #restart application after display words
    thesaurus()


# Adios
thesaurus()
# when you're done go celebrate!!!
print('Thank you for using my Thesaurus. Hope to see you next time!!!')
# This is the cellular Automation program
# Each function has a docstring that summarizes its purpose and provides a description of its inputs and outputs.
# cellularAutomation.py is a script that has two command line inputs. Input one is the rule number and determines the type
# of pattern that will be produced. Input two is the timeStep, the number of lines that are essentially produced
# from the first line by using the rules.



# imported libraries
from math import floor
import sys

#the ground work

# script input rule number and number of timesteps from commandline

#ruleNumber = input('Rule Number (0-255): ')
#timeStep = int(input('Number of timesteps: '))

ruleNumber=int(sys.argv[1])
timeStep=int(sys.argv[2])

# assigning input to a binary number and indicating number of rows and columns for bmp image
ruleNumberBin = bin(int(ruleNumber))
rows = str(timeStep+1)
columns = str(timeStep*2+1)


# convert binary string number into an 8 number digit string
# find place in ruleNumberBin where b occurs
for i in range(len(ruleNumberBin)):
    if ruleNumberBin[i] == 'b':
        cutoff = i
        break

# truncate ruleNumberBin and add 8 0's to it, then truncate once more so that it is eight digits
ruleNumberBin = ruleNumberBin[cutoff+1:]
ruleNumberBin = '0'*8 + ruleNumberBin
ruleNumberBin = ruleNumberBin[(len(ruleNumberBin)-8):]


# assigns a rule to a binary output
def cellAuto(totalInput):

    """ cellAuto inputs a five character string and checks to see if it matches the following inputs listed below. If
    it does match one of the inputs below, then returns a particular binary digit associated with the rule

    for example, if your binary number is 01110101, and if '1 1 0' is the input into the function, then the output is '1'
    """

    # if five character string read equals a certain rule, return corresponding binary digit

    if totalInput=='1 1 1':
        return ruleNumberBin[0]
    if totalInput=='1 1 0':
        return ruleNumberBin[1]
    if totalInput=='1 0 1':
        return ruleNumberBin[2]
    if totalInput=='1 0 0':
        return ruleNumberBin[3]
    if totalInput=='0 1 1':
        return ruleNumberBin[4]
    if totalInput=='0 1 0':
        return ruleNumberBin[5]
    if totalInput=='0 0 1':
        return ruleNumberBin[6]
    if totalInput=='0 0 0':
        return ruleNumberBin[7]

# function to read through an entire line of cellular automation and produce new line, output new line
def lineAuto(previousLine):

    """
    lineAuto will read the string characters of the previous line above and create a new line out of them. For a given
    character position in the new line, reads the 5 character string above it and inputs into cellAuto and then returns
    a particular value at that position and then skips a character and repeats the process. Left and right boundaries in
    lines are treated differently.

    for example, previous line is '0 1 0 0 0 0 1 1 1 0 0 1 0 0 1' new line reads '0 0 1' from left first (left boundary
    condition to include extra 0) then outputs 1 or 0 into new line, then skips a character, then reads '0 1 0' and
    outputs 1 or 0 in new line, and so on and so forth until like is constructed
    """
    # read left boundary
    leftInput = '0 '
    totalInput = leftInput+previousLine[0:3]

    # left most entry of new line
    newLine = cellAuto(totalInput) + ' '

    #read five character strings in line above and return cellAuto output and add this to new Line until most of new line is built
    for i in range(int(timeStep*2-1)):
        newLine = newLine + cellAuto(previousLine[len(newLine)-2:len(newLine)+3]) + ' '

    # read right entry
    rightInput = ' 0'
    totalInput = previousLine[len(newLine)-2:len(newLine)+1] + rightInput

    #right most entry of new line
    newLine = newLine + cellAuto(totalInput)

    return newLine


# prints the first line of output of the cellular automation bmp
print('P1 '+columns+' '+rows)

# second line has a one in the middle of it and is surrounded by 0s
previousLine='0 '*(timeStep) + '1' + ' 0'*(timeStep)
print(previousLine)

# iterate the rest of the lines over the number of time steps

for i in range(int(timeStep)):
    previousLine = lineAuto(previousLine)
    print(previousLine)

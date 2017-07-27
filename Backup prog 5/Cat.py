from Vector import Vector
from Color import *
import math
from Statue import *
from Turtle import Turtle

class Cat(Turtle):
    """This is the cat class inherits from turtle and adds stuff to class."""

    def __init__(self, center, position, heading, speed, mouseAngle=0, catRadius=0, catAngle=0,
                       outline=black, fill=white, width=1):
        """
        :param center: center of statue
        :param position: initial position of cat
        :param heading: heading of cat, doesn't matter really
        :param speed: speed of mouse as it circles and speed of cat as it approaches statue
        :param mouseAngle: angle of mouse relative to statue base, measured CW from (0,1)
        :param catRadius: distance from cat to statue base
        :param catAngle: angle of cat relative to statue base, measured CW from (0,1)
        :param outline: formatting
        :param fill: formatting
        :param width: formatting
        :return:
        """
        self.position, self.heading = position, heading
        self.style = dict(outline=outline, fill=fill, width=width)
        self.speed = speed
        self.center = center
        Turtle.catRadius = catRadius
        Turtle.catAngle = catAngle
        Turtle.mouseAngle = mouseAngle
        Turtle.originalCatRadius = catRadius
        Turtle.originalCatAngle = catAngle
        Turtle.originalMouseAngle = mouseAngle
        self.originalPosition=self.position

    def getshape(self):
        """Return a list of vectors giving the polygon for this turtle."""
        forward = unit(self.heading)
        right = unit(self.heading + 90)
        return [self.position + forward*15,
                self.position - forward*8 - right*8,
                self.position - forward*5,
                self.position - forward*8 + right*8]

    def getnextstate(self,reset=0):
        """circle the statue at that radius at 1.25 speed if mouse not in sight, else charge the statue at 1."""

        # corrects the angle readings by keeping them between 0 and 360
        while Turtle.mouseAngle<0.:
            Turtle.mouseAngle += 360.
        while Turtle.catAngle<0.:
            Turtle.catAngle += 360.
        while Turtle.mouseAngle>360.:
            Turtle.mouseAngle -= 360.
        while Turtle.catAngle>360.:
            Turtle.catAngle -= 360.

        # see if mouse is in sight or not and take appropriate action
        maxAngleSearch=math.acos(100./Turtle.catRadius)*180./pi
        relativeVector=self.position-self.center # conpare this to catRadius
        # output display
        print Turtle.mouseAngle, Turtle.catAngle, Turtle.catRadius, maxAngleSearch, Vector.length(relativeVector)
        # if mouse not in sight, circle at 1.25 speed
        if reset:
            Turtle.catRadius=Turtle.originalCatRadius
            Turtle.catAngle=Turtle.originalCatAngle
            Turtle.mouseAngle=Turtle.originalMouseAngle
            return self.originalPosition

        elif Turtle.mouseAngle-maxAngleSearch<Turtle.catAngle and Turtle.mouseAngle+maxAngleSearch>Turtle.catAngle:
            Turtle.catRadius=Turtle.catRadius - self.speed
            Turtle.mouseAngle=Turtle.mouseAngle -9/(5*pi)
            return self.position -self.speed*unit(Turtle.catAngle)
        # charge statue
        elif Turtle.catRadius > 100.:
            Turtle.mouseAngle=Turtle.mouseAngle -9/(5*pi)
            Turtle.catAngle=Turtle.catAngle-225./(Turtle.catRadius*pi)
            return self.center + Turtle.catRadius*unit(Turtle.catAngle)
        # don't do anything once get to statue
        else:
            if Turtle.mouseAngle<Turtle.catAngle+10 and Turtle.mouseAngle>Turtle.catAngle-10:
                print "I have you now, mouse..."
                quit()
            #return self.center + self.catRadius*unit(self.catAngle), self.mouseAngle-9./(5.*pi), self.catAngle-225./(self.catRadius*pi), self.catRadius

    def setstate(self, state):
        """Update the state of the turtle."""
        (self.position) = state

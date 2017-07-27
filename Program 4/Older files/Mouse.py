from Color import *
from Statue import Statue
from Turtle import Turtle
from Vector import *


class Mouse(Turtle,Statue):       #### Inherit behavior from Turtle
    """This mouse walks in a circle at a certain rate according to the statue."""

    def __init__(self,  heading, speed, position,  outline=black, fill=white, width=1):
        self.heading = position,heading
        position=position#+100*unit(253)
        self.position = position
        self.style = dict(outline=outline, fill=fill, width=width)
        self.speed = speed



    def getshape(self):
        """Return a list of vectors giving the polygon for this turtle."""
        forward = unit(self.heading)
        right = unit(self.heading + 90)
        return [self.position + forward*15,
                self.position - forward*8 - right*8,
                self.position - forward*5,
                self.position - forward*8 + right*8]

    def getnextstate(self,Statue):
        """Advance in circle."""
        return self.position,self.heading#Statue.position+100*unit(253*self.speed), self.heading #+ unit(self.heading)*self.speed, self.heading

    def setstate(self, state):
        """Update the state of the turtle."""
        self.position, self.heading = state




from Vector import *
from Color import *
from Statue import *
from Turtle import Turtle

class Mouse2(Turtle):
    """This is the subclass mouse, inherited from Turtle."""

    def __init__(self, center, position, heading, speed, mouseAngle=0, catRadius=0, catAngle=0,
                       outline=black, fill=white, width=1):
        """
        :param center: (see cat)
        :param position:
        :param heading:
        :param speed: this is the mouse's speed
        :param mouseAngle:
        :param catRadius:
        :param catAngle:
        :param outline:
        :param fill:
        :param width:
        :return:
        """
        self.position, self.heading = position, heading
        self.style = dict(outline=outline, fill=fill, width=width)
        self.speed = speed
        self.center = center
        self.catRadius = catRadius
        self.catAngle = catAngle
        self.mouseAngle = mouseAngle

    def getshape(self):
        """Return a list of vectors giving the polygon for this turtle."""
        forward = unit(self.heading)
        right = unit(self.heading + 90)
        return [self.position + forward*15,
                self.position - forward*8 - right*8,
                self.position - forward*5,
                self.position - forward*8 + right*8]

    def getnextstate(self):
        """Advance straight ahead."""
        relativeVector=self.position-self.center
        relativeHeading=Vector.direction(relativeVector)

        # angles should stay within 0 and 360
        while self.mouseAngle<0.:
            self.mouseAngle += 360.
        while self.mouseAngle>360.:
            self.mouseAngle -= 360.

        # this allows mouse to circle the statue by changing the mouseAngle
        return self.center + 100.*unit(self.mouseAngle), self.mouseAngle - 9./(5.*pi)

    def setstate(self, state):
        """Update the state of the turtle."""
        self.position, self.mouseAngle = state

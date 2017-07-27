from Vector import *
from Color import *
from Turtle import Turtle

class Statue(Turtle):
    """This is the  subclass for statue, inherited from Turtle."""

    def __init__(self, center, position, heading, speed = 0, mouseAngle=0, catRadius=0, catAngle=0,
                       outline=black, fill=white, width=1):
        """
        :param center: (see Cat)
        :param position:
        :param heading:
        :param speed:
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
        # many of these equal zero because not needed, but attribute list must agree with other classes

    def getshape(self):
        """Return a list of vectors giving the polygon for this turtle."""
        # this draws a circle
        vectorList=[]
        #created circle below
        for angle in range(720):
            vectorList.append(self.position+100*unit(angle/2))
        return vectorList

    def getnextstate(self):
        """Determine the turtle's next step and return its new state."""
        return self.position, self.heading

    def setstate(self, state):
        """Update the state of the turtle."""
        self.position, self.heading = state


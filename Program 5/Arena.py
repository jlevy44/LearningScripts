from Tkinter import *
from math import sin, cos, pi
from Vector import *
import Turtle
from Color import *

class Arena(Frame):
    """This class provides the user interface for an arena of turtles."""
    time = 0
    changeInColor=0


    def __init__(self, parent, width=1000, height=600, **options):
        Frame.__init__(self, parent, **options)
        self.width, self.height = width, height
        self.canvas = Canvas(self, width=width, height=height)
        self.canvas.pack()
        parent.title("UC Bereley CS9H Turtle Arena")
        Button(self, text='reset', command=self.reset).pack(side=LEFT)
        Button(self, text='step', command=self.step).pack(side=LEFT)
        Button(self, text='run', command=self.run).pack(side=LEFT)
        Button(self, text='stop', command=self.stop).pack(side=LEFT)
        Button(self, text='quit', command=parent.quit).pack(side=LEFT)
        self.Time=Label(self, text='Time: '+str(Arena.time)+' minutes')
        self.Time.pack(side=LEFT)
        self.catRadius=Label(self, text='Cat Radius: ')
        self.catRadius.pack(side=LEFT)
        self.mouseAngle=Label(self, text='Mouse Angle: ')
        self.mouseAngle.pack(side=LEFT)
        self.catAngle=Label(self, text='Cat Angle: ')
        self.catAngle.pack(side=LEFT)
        self.turtles = []
        self.items = {}
        self.running = 0
        self.period = 10 # milliseconds
        self.canvas.bind('<ButtonPress>', self.press)
        self.canvas.bind('<Motion>', self.motion)
        self.canvas.bind('<ButtonRelease>', self.release)
        self.dragging = None
        self.var=StringVar()
        self.check=Checkbutton(self, text="Change cat color blue?:", variable=self.var,onvalue='blue',offvalue='white',)
        self.check.toggle()
        self.check.pack()

# use these functions for dragging the cat, make mouse undraggable, make sure no get inside statue,
    # and sim starts from place where dragged
    def press(self, event):
        #print event.x, event.y
        dragstart = Vector(event.x, event.y)
        for turtle in self.turtles:
            if (dragstart - turtle.position).length() < 10:
                self.stop()
                self.dragging = turtle
                self.dragstart = dragstart
                self.start = turtle.position
                return

    def motion(self, event,defaultFill='white'):
        drag = Vector(event.x, event.y)
        #self.c.var=self.var.get()
        # if drag mouse over cat, change object to black
        for turtle in self.turtles:
            #print (drag - turtle.position).length()
            defaultFill='white'
            hoverFill='white'
            #if turtle.name=='Cat':
             #   defaultFill=self.var
              #  if defaultFill=='white':
              #      hoverFill='black'
              #  else:
               #     hoverFill='white'
            if turtle.name=='Cat':
                turtle.defaultFill=self.var.get()
            if (drag - turtle.position).length() < 10.:
                turtle.style['fill']=black
                self.update(turtle)
            if (drag - turtle.position).length() >= 10.:
                turtle.style['fill']=turtle.defaultFill
                self.update(turtle)
        if self.dragging:
            turtle.style['fill']='black'
            self.dragging.position = self.start + drag - self.dragstart
            self.update(self.dragging)


    def release(self, event):
        drag = Vector(event.x, event.y)
        #print event.x, event.y

        self.dragging = None


    def update(self, turtle,defaultFill='white'):
        """Update the drawing of a turtle according to the turtle object."""
        # this corresponds to listbox for cat color
        if turtle.name=='Cat':
            turtle.defaultFill=self.var.get()
        item = self.items[turtle]
        #relativePosition = turtle.position-turtle.center
        #catRadius=relativePosition.length()
        #if 100. > turtle.catRadius > 0.0:
            #print('Resetting Cat Radius to 150. Do not move cat or mouse inside structure...')
            #self.release(turtle.position)
            #self.reset()
#        turtle.heading = relativePosition.direction
        # update labels for cat and mouse data
        self.catRadius.configure(text='Cat Radius: '+str(int(turtle.catRadius)/100.)+' meters')
        self.mouseAngle.configure(text='Mouse Angle: '+str(int(turtle.mouseAngle)))
        self.catAngle.configure(text='Cat Angle: '+str(int(turtle.catAngle)))
        vertices = [(v.x, v.y) for v in turtle.getshape()]
        self.canvas.coords(item, sum(vertices, ()))
        self.canvas.itemconfigure(item, **turtle.style)

    def add(self, turtle):
        """Add a new turtle to this arena."""
        self.turtles.append(turtle)
        self.items[turtle] = self.canvas.create_polygon(0, 0)
        self.update(turtle)

    def step(self, stop=1, reset=0):
        """Advance all the turtles one step."""
        # add simulation time
        nextstates = {}
        Arena.time+=1./60.
        timeString=str(Arena.time)
        if reset:
            Arena.time=0
            for turtle in self.turtles:
                nextstates[turtle] = turtle.getnextstate(1)
        else:
            for turtle in self.turtles:
                nextstates[turtle] = turtle.getnextstate()
        for turtle in self.turtles:
            turtle.setstate(nextstates[turtle])
            self.update(turtle)

        # format sim time
        if stop:
            self.running = 0
        self.Time.configure(text='Time: '+timeString[:timeString.find('.')]+ \
                                 timeString[timeString.find('.'):timeString.find('.')+2]+' minutes')

    def run(self):
        """Start the turtles running."""
        self.running = 1
        self.loop()

    def loop(self):
        """Repeatedly advance all the turtles one step."""
        self.step(0)
        if self.running:
            self.tk.createtimerhandler(self.period, self.loop)

    def stop(self):
        """Stop the running turtles."""
        self.running = 0

    # reset button
    def reset(self):
        self.running = 0
        self.step(1,1)



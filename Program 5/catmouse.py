import random
from Tkinter import *                  # Import everything from Tkinter

from Mouse2 import Mouse2

from Arena   import Arena            # Import our Arena
from Statue  import Statue             # Import our Turtle
from Vector  import *                  # Import everything from our Vector
from Cat import Cat

# random vector for center of statue
random.seed()
tk = Tk()                              # Create a Tk top-level widget
arena = Arena(tk)                      # Create an Arena widget, arena
arena.pack()                           # Tell arena to pack itself on screen
initialStatPosition=Vector(random.randint(200,600),random.randint(200,400))
#initialCatAngle=random.randint(0,359)
#initialCatRadius=random.randint(200,500)
#initialMouseAngle=random.randint(0,359)
def inputdata():
    """
    :return: instead, input the cat angle, mouse angle, and cat radius manually
    """
    initialCatAngle=float(input('Input Cat angle(degrees):'))

    initialMouseAngle=float(input('Input Mouse angle(degrees):'))
    initialCatRadius=float(input('Input Cat radius (m):'))
    if initialCatRadius<1.:
        return inputdata()
    initialCatRadius *= 100.
    return initialCatRadius, initialMouseAngle, initialCatAngle

# we decide initial positions of cat and mouse relative to the random position of the statue
initialCatRadius, initialMouseAngle, initialCatAngle = inputdata()

# create mouse, statue and cat with initial conditions
statue=Statue(initialStatPosition,initialStatPosition,0,0)
mouse=Mouse2(initialStatPosition,initialStatPosition+100*unit(initialMouseAngle),initialMouseAngle-90,1,
    initialMouseAngle)
cat=Cat(initialStatPosition,initialStatPosition+initialCatRadius*unit(initialCatAngle),initialCatAngle-90,1,
    initialMouseAngle,initialCatRadius,initialCatAngle)

# add these fellas
arena.add(statue) # Add a turtle at (200,200) heading 0=up
arena.add(mouse)
arena.add(cat)


def aboutWidget():
    top = Toplevel(menu=filemenu)
    top.title('About the UC Berkeley CS9H Turtle Arena')


    photo=PhotoImage(file='Joshua.gif')
    smallphoto=photo.subsample(15)
    photoLabel=Label(top,image=smallphoto)
    photoLabel.image= smallphoto
    photoLabel.pack()


    msg = Label(top, text='Joshua Levy; Turtle Arena Project. Who is this foul beast??')
    msg.pack()

    button = Button(top, text='OK', command=top.destroy)
    button.pack()




def hello():
    print "hello!"

menubar = Menu(tk)

# create a pulldown menu, and add it to the menu bar
filemenu = Menu(menubar, tearoff=0)
filemenu.add_command(label="About...", command=aboutWidget)
filemenu.add_separator()
filemenu.add_command(label="Quit", command=tk.quit)
menubar.add_cascade(label="File", menu=filemenu)




# display the menu
tk.config(menu=menubar)
#aboutWidget()

tk.mainloop()                          # Enter the Tkinter event loop
#root.mainloop()
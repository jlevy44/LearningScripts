from Tkinter import *

master = Tk()

var = StringVar()
c = Checkbutton(master, text="Color image", variable=var, onvalue="RGB", offvalue="L")
c.var=var
c.pack()

mainloop()
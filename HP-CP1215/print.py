#!/usr/local/bin/python3

# PDF printing program
import os
import tkinter as tk
from tkinter.filedialog import LoadFileDialog, askopenfilename
from tkinter.messagebox import showinfo, showwarning

# Constants
A4 = (595, 842)

# Main script
gui = tk.Tk()
# gui.minsize(width=300, height=0)
gui.title('Print PDF with HP CP1215')

tk.Label(
    text='Click on "Choose file" to select the file to print.'
).pack(padx=20)

file_name = None
def ask_file():
    global file_name
    file_name = askopenfilename()
    file_name_label.config(text=file_name.replace(os.path.expanduser('~'), '~'))

    with os.popen(f'identify -format "%w %h" "{file_name}[0]"') as p:
        size = tuple(int(s) for s in p.read().split())  # pixels
    if size[0] > A4[0] or size[1] > A4[1]:
        size_in_mm = tuple(float(s) * 2.54 / 72 for s in size)
        showwarning(
            'Warning! File too large!',
            f'''
            The current document is
            {size_in_mm[0]:.1f} × {size_in_mm[1]:.1f} mm
            and may not fit on a
            {A4[0] * 2.54 / 72:.1f} × {A4[1] * 2.54 / 72:.1f} mm
            A4 page.
            '''
        )
fr = tk.Frame(); fr.pack()
tk.Label(fr, text='File to print:').pack(side=tk.LEFT)
load_btn = tk.Button(fr, text='Choose file', command=ask_file)
load_btn.pack(side=tk.RIGHT)

file_name_label = tk.Label(text='')
file_name_label.pack(padx=20)

fr = tk.Frame(bd=5); fr.pack()
mode = tk.StringVar(value='colour')
colour = tk.Radiobutton(fr, text='Colour', variable=mode, value='colour')
colour.pack(anchor='w')
bw = tk.Radiobutton(fr, text='Grey scale', variable=mode, value='grey')
bw.pack()

fr = tk.Frame(bd=1); fr.pack()
duplex = tk.StringVar(value='2')
tk.Radiobutton(fr, text='Single', variable=duplex, value='1').pack(anchor='w')
tk.Radiobutton(fr, text='Duplex long', variable=duplex, value='2').pack(anchor='w')
tk.Radiobutton(fr, text='Duplex short', variable=duplex, value='3').pack(anchor='w')


interpreter = '/Users/atcold/Work/Scratch/Printer/foo2zjs/foo2hp2600-wrapper'
def print_file():
    #showinfo('Compiling document', 'Compiling PDF in printing instructions.')
    showinfo('Printing', 'Compiling PDF and sending instructions to printer.')
    c = '-c' if mode.get() == 'colour' else ''
    os.system(f'{interpreter} -p9 -z1 {c} -d{duplex.get()} "{file_name}" > /tmp/temp.prn && ' + \
	       'lp -o raw /tmp/temp.prn && ' + \
	       'rm /tmp/temp.prn')
    #showinfo('Printing', 'Sending instructions to printer.')
    showinfo('Done', 'All done, you may exit now.')

tk.Button(gui, text='Print', command=print_file).pack()

tk.mainloop()

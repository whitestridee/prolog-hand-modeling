import tkinter

from ui.const import SCREEN_W, SCREEN_H
from ui.events import mouse_motion, mouse_rotate, mouse_scale, \
    key_translate, mesh_switch, valid_points, select_vertex, edit_points
from ui.scene import AppOgl
from ui.io import import_file, export_file

from PIL import ImageTk, Image

if __name__ == "__main__":
    root = tkinter.Tk()
    root.geometry(f'{SCREEN_W}x{SCREEN_H}')
    root.title("Hand Validator")

    app = AppOgl(root, width=SCREEN_W, height=SCREEN_H)
    app.place(relheight=1, relwidth=0.7)

    btn_import = tkinter.Button(
        root,
        text="Загрузить точки",
        padx="60",
        pady="6",
        command=import_file
    )
    btn_import.place(relx=0.76, rely=0.03)

    btn_export = tkinter.Button(
        root,
        text="Выгрузить точки",
        padx="60",
        pady="6",
        command=export_file,
    )
    btn_export.place(relx=0.76, rely=0.09)

    btn_check = tkinter.Button(
        root,
        text="Проверить точки",
        padx="60",
        pady="6",
        command=valid_points
    )
    btn_check.place(relx=0.76, rely=0.15)

    show_edges = tkinter.Checkbutton(text="Отобразить мэш",
                                     command=mesh_switch)
    show_edges.place(relx=0.76, rely=0.21)
    show_edges.select()

    canvas = tkinter.Canvas(root)
    img = ImageTk.PhotoImage(Image.open("img/ui_hands_color.png"))
    # panel = tkinter.Label(root, image=img)
    # panel.place(relx=0.71, rely=0.28, height=235, width=335)
    canvas.create_image(0, 0, anchor='nw', image=img, tags='img')
    canvas.place(relx=0.71, rely=0.28, height=235, width=335)

    label_entry = tkinter.Label(text="Шаг:", font='Times 14')
    label_entry.place(relx=0.71, rely=0.63)
    message_entry = tkinter.Entry(width=10, font='Times 14', )
    message_entry.place(relx=0.78, rely=0.63)
    message_entry.insert(0, "10")

    label_x = tkinter.Label(text="Ось X:", font='Times 14')
    label_x.place(relx=0.71, rely=0.70)
    btn_plus_x = tkinter.Button(
        root,
        text="+",
        font='Times 13',
        command=lambda arg='X+': edit_points(arg, message_entry.get(), x_value)
    )
    btn_plus_x.place(relx=0.76, rely=0.70)
    btn_minus_x = tkinter.Button(
        root,
        text="-",
        font='Times 13',
        command=lambda arg='X-': edit_points(arg, message_entry.get(), x_value)
    )
    btn_minus_x.place(relx=0.82, rely=0.70)

    x_value = tkinter.StringVar()
    label_x_value = tkinter.Label(textvariable=x_value, font='Times 14')
    label_x_value.place(relx=0.85, rely=0.70)

    label_y = tkinter.Label(text="Ось Y:", font='Times 14')
    label_y.place(relx=0.71, rely=0.75)
    btn_plus_y = tkinter.Button(
        root,
        text="+",
        font='Times 13',
        command=lambda arg='Y+': edit_points(arg, message_entry.get(), y_value)
    )
    btn_plus_y.place(relx=0.76, rely=0.75)
    btn_minus_y = tkinter.Button(
        root,
        text="-",
        font='Times 13',
        command=lambda arg='Y-': edit_points(arg, message_entry.get(), y_value)
    )
    btn_minus_y.place(relx=0.82, rely=0.75)

    y_value = tkinter.StringVar()
    label_y_value = tkinter.Label(textvariable=y_value, font='Times 14')
    label_y_value.place(relx=0.85, rely=0.75)

    label_z = tkinter.Label(text="Ось Z:", font='Times 14')
    label_z.place(relx=0.71, rely=0.80)
    btn_plus_z = tkinter.Button(
        root,
        text="+",
        font='Times 13',
        command=lambda arg='Z+': edit_points(arg, message_entry.get(), z_value)
    )
    btn_plus_z.place(relx=0.76, rely=0.80)
    btn_minus_z = tkinter.Button(
        root,
        text="-",
        font='Times 13',
        command=lambda arg='Z-': edit_points(arg, message_entry.get(), z_value)
    )
    btn_minus_z.place(relx=0.82, rely=0.80)

    z_value = tkinter.StringVar()
    label_z_value = tkinter.Label(textvariable=z_value, font='Times 14')
    label_z_value.place(relx=0.85, rely=0.80)

    app.bind("<Motion>", mouse_motion)
    app.bind("<B1-Motion>", mouse_rotate)
    app.bind("<MouseWheel>", mouse_scale)
    root.bind('<Button-1>', lambda event: select_vertex(event, x_value, y_value, z_value, canvas))
    root.bind("<Left>", key_translate)
    root.bind("<Right>", key_translate)
    root.bind("<Down>", key_translate)
    root.bind("<Up>", key_translate)
    app.animate = 1
    app.after(100, app.printContext)
    root.mainloop()

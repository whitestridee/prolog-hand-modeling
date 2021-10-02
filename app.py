import tkinter

from ui.const import SCREEN_W, SCREEN_H
from ui.events import mouse_motion, mouse_rotate, mouse_scale, \
    key_translate, mesh_switch, valid_points, select_vertex, edit_points
from ui.scene import AppOgl
from ui.io import import_file, export_file

from PIL import ImageTk, Image



class MainApplication(tkinter.Frame):
    def __init__(self, parent, *args, **kwargs):
        tkinter.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent
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

        img = ImageTk.PhotoImage(Image.open("img/ui_hands.jpg"))
        panel = tkinter.Label(root, image=img)
        panel.place(relx=0.71, rely=0.28, height=235, width=335)

        label_entry = tkinter.Label(text="Шаг:", font='Times 14')
        label_entry.place(relx=0.71, rely=0.63)
        message_entry = tkinter.Entry(width=10, font='Times 14')
        message_entry.place(relx=0.75, rely=0.63)

        label_point = tkinter.Label(text="Номер Точки:", font='Times 14')
        label_point.place(relx=0.84, rely=0.63)

        message_selected = tkinter.Label(text = "Nan", font='Times 14')
        message_selected.place(relx=0.94, rely=0.63)

        label_x = tkinter.Label(text="Ось X:", font='Times 14')
        label_x.place(relx=0.71, rely=0.70)
        btn_plus_x = tkinter.Button(
            root,
            text="+",
            font='Times 13',
            command=lambda arg='X+': edit_points(arg)
        )
        btn_plus_x.place(relx=0.76, rely=0.70)
        btn_minus_x = tkinter.Button(
            root,
            text="-",
            font='Times 13',
            command=lambda arg='X-': edit_points(arg)
        )
        btn_minus_x.place(relx=0.82, rely=0.70)

        label_y = tkinter.Label(text="Ось Y:", font='Times 14')
        label_y.place(relx=0.71, rely=0.75)
        btn_plus_y = tkinter.Button(
            root,
            text="+",
            font='Times 13',
            command=lambda arg='Y+': edit_points(arg)
        )
        btn_plus_y.place(relx=0.76, rely=0.75)
        btn_minus_y = tkinter.Button(
            root,
            text="-",
            font='Times 13',
            command=lambda arg='Y-': edit_points(arg)
        )
        btn_minus_y.place(relx=0.82, rely=0.75)

        label_z = tkinter.Label(text="Ось Z:", font='Times 14')
        label_z.place(relx=0.71, rely=0.80)
        btn_plus_z = tkinter.Button(
            root,
            text="+",
            font='Times 13',
            command=lambda arg='Z+': edit_points(arg)
        )
        btn_plus_z.place(relx=0.76, rely=0.80)
        btn_minus_z = tkinter.Button(
            root,
            text="-",
            font='Times 13',
            command=lambda arg='Z-': edit_points(arg)
        )
        btn_minus_z.place(relx=0.82, rely=0.80)

        app.bind("<Motion>", mouse_motion)
        app.bind("<B1-Motion>", mouse_rotate)
        app.bind("<MouseWheel>", mouse_scale)
        root.bind('<Button-1>', select_vertex)
        root.bind("<Left>", key_translate)
        root.bind("<Right>", key_translate)
        root.bind("<Down>", key_translate)
        root.bind("<Up>", key_translate)
        app.animate = 1
        app.after(100, app.printContext)
        root.mainloop()


if __name__ == "__main__":
    root = tkinter.Tk()
    MainApplication(root).pack(side="top", fill="both", expand=True)
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

    img = ImageTk.PhotoImage(Image.open("img/ui_hands_color.png"))
    panel = tkinter.Label(root, image=img)
    panel.place(relx=0.71, rely=0.28, height=235, width=335)

    label_entry = tkinter.Label(text="Шаг:", font='Times 14')
    label_entry.place(relx=0.71, rely=0.63)
    message_entry = tkinter.Entry(width=10, font='Times 14')
    message_entry.place(relx=0.78, rely=0.63)

    label_x = tkinter.Label(text="Ось X:", font='Times 14')
    label_x.place(relx=0.71, rely=0.70)
    btn_plus_x = tkinter.Button(
        root,
        text="+",
        font='Times 13',
        command=lambda arg='X+': edit_points(arg)
    )
    btn_plus_x.place(relx=0.76, rely=0.70)
    btn_minus_x = tkinter.Button(
        root,
        text="-",
        font='Times 13',
        command=lambda arg='X-': edit_points(arg)
    )
    btn_minus_x.place(relx=0.82, rely=0.70)

    label_y = tkinter.Label(text="Ось Y:", font='Times 14')
    label_y.place(relx=0.71, rely=0.75)
    btn_plus_y = tkinter.Button(
        root,
        text="+",
        font='Times 13',
        command=lambda arg='Y+': edit_points(arg)
    )
    btn_plus_y.place(relx=0.76, rely=0.75)
    btn_minus_y = tkinter.Button(
        root,
        text="-",
        font='Times 13',
        command=lambda arg='Y-': edit_points(arg)
    )
    btn_minus_y.place(relx=0.82, rely=0.75)

    label_z = tkinter.Label(text="Ось Z:", font='Times 14')
    label_z.place(relx=0.71, rely=0.80)
    btn_plus_z = tkinter.Button(
        root,
        text="+",
        font='Times 13',
        command=lambda arg='Z+': edit_points(arg)
    )
    btn_plus_z.place(relx=0.76, rely=0.80)
    btn_minus_z = tkinter.Button(
        root,
        text="-",
        font='Times 13',
        command=lambda arg='Z-': edit_points(arg)
    )
    btn_minus_z.place(relx=0.82, rely=0.80)

    app.bind("<Motion>", mouse_motion)
    app.bind("<B1-Motion>", mouse_rotate)
    app.bind("<MouseWheel>", mouse_scale)
    root.bind('<Button-1>', select_vertex)
    root.bind("<Left>", key_translate)
    root.bind("<Right>", key_translate)
    root.bind("<Down>", key_translate)
    root.bind("<Up>", key_translate)
    app.animate = 1
    app.after(100, app.printContext)
    root.mainloop()

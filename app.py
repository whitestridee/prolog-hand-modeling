import json
import tkinter

from utils.const import VERTICES_ON_IMG
from utils.scene import Scene, AppOgl, rotate_camera, zoom_camera, \
    translate_camera
from utils.io import import_file, export_file
from utils.prolog import get_answer

from PIL import ImageTk, Image


def mouse_motion(event):
    Scene.mouse_x = event.x
    Scene.mouse_y = event.y


def mouse_rotate(event):
    rel_x = event.x - Scene.mouse_x
    rel_y = event.y - Scene.mouse_y
    rotate_camera(rel_x, rel_y)


def mouse_scale(event):
    if event.num == 5 or event.delta == -120:
        zoom_camera(0.5)
    if event.num == 4 or event.delta == 120:
        zoom_camera(1.5)


def key_translate(event):
    if event.keysym == "Left":
        translate_camera(0.5, 0, 0)
    if event.keysym == "Right":
        translate_camera(-0.5, 0, 0)
    if event.keysym == "Up":
        translate_camera(0, -0.5, 0)
    if event.keysym == "Down":
        translate_camera(0, 0.5, 0)


def mesh_switch():
    Scene.mesh = not Scene.mesh


def valid_points():
    hand_coord_arg = ', '.join([str(x) for x in Scene.Source.vertices])
    statement = ("validate_all('.', Result, " + hand_coord_arg + ")")
    answer1 = get_answer(
        filename='logic/validation.pl', statement=statement,
    )
    for i in answer1:
        print(i)

    Scene.Source.incorrect_coord.clear()
    with open(f'./points.txt', 'r', encoding='utf-8') as f:
        file_data = f.read()
    if file_data is None:
        print('Координаты кистей корректны')
    else:
        file_data = file_data.split('\n')
        for line in file_data:
            if line:
                Scene.Source.incorrect_coord += json.loads(line)
    Scene.incorrect_coord = Scene.Source.incorrect_coord.copy()


def select_vertex(event):
    for i in range(len(VERTICES_ON_IMG)):
        if abs(VERTICES_ON_IMG[i][0] - event.x) < 4 and \
                abs(VERTICES_ON_IMG[i][1] - event.y) < 4:
            Scene.edit_point = i
            break

    # projection = GL.glGetDoublev(GL.GL_PROJECTION_MATRIX)
    # viewport = GL.glGetIntegerv(GL.GL_VIEWPORT)
    # modelview = Scene.modelMatrix
    #
    # winX = float(Scene.mouse_x)
    # winY = float(viewport[3]) - float(Scene.mouse_y)
    # posXF, posYF, posZF = GLU.gluUnProject(
    # winX, winY, 1, model=modelview, proj=projection, view=viewport)
    # posXN, posYN, posZN = GLU.gluUnProject(
    # winX, winY, 0, model=modelview, proj=projection, view=viewport)
    #
    # posZ = 0
    # posX = (posZ - posZN) / (posZF - posZN) * (posXF - posXN) + posXN
    # posY = (posZ - posZN) / (posZF - posZN) * (posYF - posYN) + posYN
    #
    # print(posX, posY, posXF, posYF)
    # #print(Scene.vertices)


def edit_points(move):
    print(Scene.vertices[Scene.edit_point][0])
    if Scene.edit_point is not None:
        if move == 'X+':
            Scene.vertices[Scene.edit_point][0] += 5
        if move == 'X-':
            Scene.vertices[Scene.edit_point][0] -= 5
        if move == 'Y+':
            Scene.vertices[Scene.edit_point][1] += 5
        if move == 'Y-':
            Scene.vertices[Scene.edit_point][1] -= 5
        if move == 'Z+':
            Scene.vertices[Scene.edit_point][2] += 5
        if move == 'Z-':
            Scene.vertices[Scene.edit_point][2] -= 5


def main():
    screen = (1200, 700)

    root = tkinter.Tk()
    root.geometry(f'{screen[0]}x{screen[1]}')

    app = AppOgl(root, width=screen[0], height=screen[1])
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


if __name__ == '__main__':
    main()

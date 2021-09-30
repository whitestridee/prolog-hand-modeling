import json
import tkinter
from OpenGL import GL

from utils.scene import Scene, AppOgl
from utils.io import import_file, export_file
from utils.prolog import get_answer

from PIL import ImageTk, Image


def mouse_motion(event):
    Scene.mouse_x = event.x
    Scene.mouse_y = event.y
    # print(Scene.mouse_x, Scene.mouse_y)


def camera_motion(event):
    rel_x = event.x - Scene.mouse_x
    rel_y = event.y - Scene.mouse_y
    GL.glRotatef(rel_y, 1, 0, 0)
    GL.glRotatef(rel_x, 0, 1, 0)
    #print(rel_x, rel_y)
    mouse_motion(event)


def mouse_scale(event):
    if event.num == 5 or event.delta == -120:
        GL.glScalef(0.5, 0.5, 0.5)
    if event.num == 4 or event.delta == 120:
        GL.glScalef(1.5, 1.5, 1.5)


def key_scale(event):
    if event.keysym == "Left":
        GL.glTranslatef(0.5, 0, 0)
    if event.keysym == "Right":
        GL.glTranslatef(-0.5, 0, 0)
    if event.keysym == "Up":
        GL.glTranslatef(0, -0.5, 0)
    if event.keysym == "Down":
        GL.glTranslatef(0, 0.5, 0)


def update_mesh():
    Scene.mesh = not Scene.mesh
    print(Scene.mesh)


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
        filedate = f.read()
    if filedate is None:
        print('Координаты кистей корректны')
    else:
        filedate = filedate.split('\n')
        for line in filedate:
            if line:
                Scene.Source.incorrect_coord += json.loads(line)
    Scene.incorrect_coord = Scene.Source.incorrect_coord.copy()


def take_vertex(event):
    vertices_img = [
        [11, 55],
        [18, 72],
        [25, 87],
        [34, 105],
        [47, 23],
        [49, 45],
        [51, 68],
        [54, 88],
        [77, 9],
        [79, 34],
        [76, 60],
        [77, 82],
        [115, 25],
        [113, 43],
        [108, 64],
        [101, 84],
        [148, 105],
        [136, 122],
        [117, 143],
        [71, 126],
        [66, 190],
        [179, 105],
        [193, 126],
        [209, 142],
        [209, 22],
        [211, 42],
        [217, 64],
        [221, 83],
        [245, 11],
        [245, 32],
        [247, 57],
        [247, 81],
        [276, 21],
        [276, 45],
        [273, 66],
        [269, 86],
        [313, 53],
        [306, 74],
        [299, 89],
        [290, 106],
        [253, 125],
        [259, 190],
    ]

    for item_points in range(len(vertices_img)):
        if event.x - 4 < vertices_img[item_points][0] < event.x + 4:
            if event.y - 4 < vertices_img[item_points][1] < event.y + 4:
                Scene.edit_point = item_points
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
    # print(Scene.vertices[Scene.edit_point][0])


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

    show_edges = tkinter.Checkbutton(text="Отобразить мэш", command=update_mesh)
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
    app.bind("<B1-Motion>", camera_motion)
    app.bind("<MouseWheel>", mouse_scale)
    root.bind('<Button-1>', take_vertex)
    root.bind("<Left>", key_scale)
    root.bind("<Right>", key_scale)
    root.bind("<Down>", key_scale)
    root.bind("<Up>", key_scale)
    app.animate = 1
    app.after(100, app.printContext)
    root.mainloop()


if __name__ == '__main__':
    main()

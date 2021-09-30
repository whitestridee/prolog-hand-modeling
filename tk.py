import time
import tkinter
from tkinter import filedialog, messagebox
from OpenGL import GL, GLU
from pyopengltk import OpenGLFrame

import utils.read_files as rf
from utils.model import HandModel, RightHandModel
from utils.vector import Vector3

from PIL import ImageTk, Image


class Scene:
    edges = []
    vertices = []
    incorrect_coord = []
    mouse_x = 0
    mouse_y = 0
    mesh_left = None
    mesh_right = None
    mesh = True

    @classmethod
    def set_hands(cls, edges, vertices, incorrect_coord,
                  mesh_left, mesh_right):
        cls.edges = edges.copy()
        cls.vertices = vertices.copy()
        cls.incorrect_coord = incorrect_coord.copy()
        cls.mesh_left = mesh_left
        cls.mesh_right = mesh_right


class AppOgl(OpenGLFrame):
    screen = (800, 600)

    def initgl(self):
        """Initalize gl states when the frame is created"""
        GL.glViewport(0, 0, self.width, self.height)
        GL.glClearColor(190 / 255, 194 / 255, 207 / 255, 0)

        GL.glMatrixMode(GL.GL_PROJECTION)
        GLU.gluPerspective(45, (self.screen[0] / self.screen[1]), 0.1, 4000)

        GL.glMatrixMode(GL.GL_MODELVIEW)
        self.modelMatrix = GL.glGetDoublev(GL.GL_MODELVIEW_MATRIX)

        self.start = time.time()
        self.nframes = 0

        GL.glPushMatrix()
        GL.glLoadIdentity()

    def redraw(self):
        """Render a single frame"""

        GL.glClearColor(190 / 255, 194 / 255, 207 / 255, 0)
        GL.glClear(GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT)

        GL.glMultMatrixf(self.modelMatrix)
        self.modelMatrix = GL.glGetDoublev(GL.GL_MODELVIEW_MATRIX)

        GL.glLoadIdentity()
        GL.glTranslatef(0, 0, -5)
        GL.glMultMatrixf(self.modelMatrix)
        hands(Scene.edges, Scene.vertices, Scene.incorrect_coord,
              Scene.mesh_left, Scene.mesh_right, Scene.mesh)

        GL.glPopMatrix()

        GL.glPushMatrix()
        GL.glLoadIdentity()

        tm = time.time() - self.start
        self.nframes += 1
        # print("fps", self.nframes / tm, end="\r" )


def transform_coord(vertices, error_vertices, mesh_left, mesh_right):
    if vertices and mesh_left and mesh_right:
        left_m_coord = [[v.x, v.y, v.z] for v in mesh_left.coord()]
        right_m_coord = [[v.x, v.y, v.z] for v in mesh_right.coord()]

        max_value = abs(max(max(vertices + left_m_coord + right_m_coord,
                            key=lambda xyz: max(xyz))))
        print(max_value)
        normalize_vertices = [
            [axis / max_value for axis in xyz] for xyz in vertices]
        normalize_error_vertices = [
            [axis / max_value for axis in xyz] for xyz in error_vertices]

        mesh_left.transform(1 / max_value)
        mesh_right.transform(1 / max_value)

    else:
        return [], []
    return normalize_vertices, normalize_error_vertices


# Создаем кисть с помощью вершин и ребер
def hands(edges, verticies, incorrect_coor, mesh_left, mesh_right, mesh):
    GL.glLineWidth(2)
    GL.glPointSize(6)

    GL.glBegin(GL.GL_LINES)
    color_hand1 = [1 / 255, 121 / 255, 111 / 255]  # Зеленый - левая рука
    color_hand2 = [205 / 255, 127 / 255, 50 / 255]  # Коричневый - правая рука
    color_bone = [240 / 255, 240 / 255, 200 / 255]  # Меш
    color_incorrect = [255 / 255, 0 / 255, 0 / 255]
    for edge in edges:
        for vertex in edge:
            if verticies[vertex] not in incorrect_coor:
                GL.glColor3d(color_bone[0], color_bone[1],
                             color_bone[2])
                GL.glVertex3fv(verticies[vertex])
            else:
                GL.glColor3d(color_incorrect[0], color_incorrect[1],
                             color_incorrect[2])
                GL.glVertex3fv(verticies[vertex])

    if mesh:
        if mesh_left:
            mesh_left.draw(color_hand1[0], color_hand1[1], color_hand1[2])
        if mesh_right:
            mesh_right.draw(color_hand2[0], color_hand2[1], color_hand2[2])

    GL.glEnd()

    GL.glBegin(GL.GL_POINTS)
    GL.glColor3d(0, 0, 0)
    for i in verticies:
        GL.glVertex3d(i[0], i[1], i[2])
    GL.glEnd()


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


def import_file():
    path = filedialog.askopenfilename(
        defaultextension=".txt",
        filetypes=(
            ("Txt Files", "*.txt"),
            ("All Files", "*.*")
        )
    )
    if path[-4:] != ".txt" and len(path):
        messagebox.showinfo(message="Неподходящий тип файла",
                            title="Ошибка!")
    elif len(path):
        Scene.vertices = rf.get_vertices(path)
        Scene.edges = rf.get_edges('utils/bone_edges.json')

        vec_hand_coord = [Vector3(x[0], x[1], x[2]) for x in Scene.vertices]
        Scene.mesh_left = HandModel(vec_hand_coord[:21])
        Scene.mesh_right = RightHandModel(vec_hand_coord[21:])


def export_file():
    f = filedialog.asksaveasfile(mode='w', defaultextension=".txt")
    if f is None:
        return

    vertices = Scene.vertices
    text = ''
    for point in vertices:
        text += ';'.join([str(axis) for axis in point]) + '\n'

    f.write(text)
    f.close()


def update_mesh():
    Scene.mesh = not Scene.mesh
    print(Scene.mesh)

def take_vertex(event):
    print(Scene.mouse_x, Scene.mouse_y)
    pass
    # projection = GL.glGetDoublev(GL.GL_PROJECTION_MATRIX)
    # viewport = GL.glGetIntegerv(GL.GL_VIEWPORT)
    # modelview = Scene.modelMatrix
    #
    # winX = float()
    # winY = float(viewport[3]) - float(Scene.mouse_y)
    # posXF, posYF, posZF = GLU.gluUnProject(winX, winY, 1, model=modelview, proj=projection, view=viewport)
    # posXN, posYN, posZN = GLU.gluUnProject(winX, winY, 0, model=modelview, proj=projection, view=viewport)
    #
    # posZ = 0
    # posX = (posZ - posZN) / (posZF - posZN) * (posXF - posXN) + posXN
    # posY = (posZ - posZN) / (posZF - posZN) * (posYF - posYN) + posYN
    #
    # print(posX, posY, posXF, posYF)
    # #print(Scene.vertices)


def app_main(edges, vertices, incorrect_coord, mesh_left, mesh_right):
    vertex, incorrect_coord = transform_coord(vertices, incorrect_coord,
                                              mesh_left, mesh_right)
    screen = (1200, 700)

    Scene.set_hands(edges, vertices, incorrect_coord, mesh_left, mesh_right)

    root = tkinter.Tk()
    root.geometry(f'{screen[0]}x{screen[1]}')

    app = AppOgl(root, width=screen[0], height=screen[1])
    app.place(relheight=1, relwidth=0.8)

    btn_import = tkinter.Button(
        root,
        text="Загрузить точки",
        padx="60",
        pady="6",
        command=import_file
    )
    btn_import.place(relx=0.81, rely=0.03)

    btn_export = tkinter.Button(
        root,
        text="Выгрузить точки",
        padx="60",
        pady="6",
        command=export_file,
    )
    btn_export.place(relx=0.81, rely=0.09)

    btn_check = tkinter.Button(
        root,
        text="Проверить точки",
        padx="60",
        pady="6"
    )
    btn_check.place(relx=0.81, rely=0.15)

    show_edges = tkinter.Checkbutton(text="Отобразить мэш", command=update_mesh)
    show_edges.place(relx=0.81, rely=0.21)
    show_edges.select()

    img = ImageTk.PhotoImage(Image.open("img_hands_small.jpg"))
    panel = tkinter.Label(root, image=img)
    panel.place(relx=0.81, rely=0.28, height=154, width=220)

    label_point = tkinter.Label(text = "No Point Selected", font = 'Times 20')
    label_point.place(relx = 0.81, rely = 0.47)
    label_entry = tkinter.Label(text="Шаг:", font='Times 20')
    label_entry.place(relx=0.81, rely=0.53)
    message_entry = tkinter.Entry(width=5, font='Times 20')
    message_entry.place(relx=0.88, rely=0.53)

    label_x = tkinter.Label(text="Ось X:", font='Times 20')
    label_x.place(relx=0.81, rely=0.62)
    btn_plus_x = tkinter.Button(
        root,
        text="+",
        font='Times 15'
    )
    btn_plus_x.place(relx=0.88, rely=0.62)
    btn_minus_x = tkinter.Button(
        root,
        text="-",
        font='Times 15'
    )

    btn_minus_x.place(relx=0.91, rely=0.62)

    label_y = tkinter.Label(text="Ось Y:", font='Times 20')
    label_y.place(relx=0.81, rely=0.70)
    btn_plus_y = tkinter.Button(
        root,
        text="+",
        font='Times 15'
    )
    btn_plus_y.place(relx=0.88, rely=0.70)
    btn_minus_y = tkinter.Button(
        root,
        text="-",
        font='Times 15'
    )
    btn_minus_y.place(relx=0.91, rely=0.70)

    label_z = tkinter.Label(text="Ось Z:", font='Times 20')
    label_z.place(relx=0.81, rely=0.80)
    btn_plus_z = tkinter.Button(
        root,
        text="+",
        font='Times 15'
    )
    btn_plus_z.place(relx=0.88, rely=0.80)
    btn_minus_z = tkinter.Button(
        root,
        text="-",
        font='Times 15'
    )
    btn_minus_z.place(relx=0.91, rely=0.80)

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
    app_main([], [], [], None, None)
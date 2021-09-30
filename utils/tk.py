import time
import tkinter
from OpenGL import GL, GLU
from pyopengltk import OpenGLFrame


class Scene:
    edges = []
    vertices = []
    incorrect_coord = []
    mouse_x = 0
    mouse_y = 0
    mesh_left = None
    mesh_right = None

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
        self.modelMatrix = GL.glGetFloatv(GL.GL_MODELVIEW_MATRIX)

        self.start = time.time()
        self.nframes = 0

        GL.glPushMatrix()
        GL.glLoadIdentity()

    def redraw(self):
        """Render a single frame"""

        GL.glClearColor(190 / 255, 194 / 255, 207 / 255, 0)
        GL.glClear(GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT)

        GL.glMultMatrixf(self.modelMatrix)
        self.modelMatrix = GL.glGetFloatv(GL.GL_MODELVIEW_MATRIX)

        GL.glLoadIdentity()
        GL.glTranslatef(0, 0, -5)
        GL.glMultMatrixf(self.modelMatrix)
        hands(Scene.edges, Scene.vertices, Scene.incorrect_coord,
              Scene.mesh_left, Scene.mesh_right)

        GL.glPopMatrix()

        GL.glPushMatrix()
        GL.glLoadIdentity()

        tm = time.time() - self.start
        self.nframes += 1
        print("fps", self.nframes / tm, end="\r" )


def transform_coord(coord, incorrect_coord, mesh_left, mesh_right):
    max_elem = None
    min_elem = None

    left_m_coord = [[v.x, v.y, v.z] for v in mesh_left.coord()]
    right_m_coord = [[v.x, v.y, v.z] for v in mesh_right.coord()]

    for xyz in coord + left_m_coord + right_m_coord:
        if max_elem is None or max_elem < max(xyz):
            max_elem = max(xyz)
        if min_elem is None or min_elem > min(xyz):
            min_elem = min(xyz)
    res = abs(max_elem) + abs(min_elem)

    for i in range(len(coord)):
        for j in range(len(coord[i])):
            coord[i][j] = coord[i][j] / res * 2

    for i in range(len(incorrect_coord)):
        for j in range(len(incorrect_coord[i])):
            incorrect_coord[i][j] = incorrect_coord[i][j] / res * 2

    mesh_left.transform(2 / res)
    mesh_right.transform(2 / res)

    return coord, incorrect_coord


# Создаем кисть с помощью вершин и ребер
def hands(edges, verticies, incorrect_coor, mesh_left, mesh_right):
    GL.glLineWidth(2)
    GL.glPointSize(6)

    GL.glBegin(GL.GL_LINES)
    color_hand1 = [1, 121, 111]  # Зеленый - левая рука
    color_hand2 = [205, 127, 50]  # Коричневый - правая рука
    color_hand_mesh = [240 / 255, 240 / 255, 180 / 255]  # Меш
    color_incorrect = [255, 0, 0]
    for edge in edges:
        for vertex in edge:
            if verticies[vertex] not in incorrect_coor:
                if vertex < 21:
                    GL.glColor3d(color_hand1[0] / 255, color_hand1[1] / 255,
                                 color_hand1[2] / 255)
                    GL.glVertex3fv(verticies[vertex])
                else:
                    GL.glColor3d(color_hand2[0] / 255, color_hand2[1] / 255,
                                 color_hand2[2] / 255)
                    GL.glVertex3fv(verticies[vertex])
            else:
                GL.glColor3d(color_incorrect[0] / 255,
                             color_incorrect[1] / 255,
                             color_incorrect[2] / 255)
                GL.glVertex3fv(verticies[vertex])

    mesh_left.draw(color_hand_mesh[0], color_hand_mesh[1], color_hand_mesh[2])
    mesh_right.draw(color_hand_mesh[0], color_hand_mesh[1], color_hand_mesh[2])

    GL.glEnd()

    GL.glBegin(GL.GL_POINTS)
    GL.glColor3d(0, 0, 0)
    for i in verticies:
        GL.glVertex3d(i[0], i[1], i[2])
    GL.glEnd()


def mouse_motion(event):
    Scene.mouse_x = event.x
    Scene.mouse_y = event.y
    print(Scene.mouse_x, Scene.mouse_y)


def camera_motion(event):
    rel_x = event.x - Scene.mouse_x
    rel_y = event.y - Scene.mouse_y
    GL.glRotatef(rel_y, 1, 0, 0)
    GL.glRotatef(rel_x, 0, 1, 0)
    print(rel_x, rel_y)
    mouse_motion(event)


def mouse_scale(event):
    if event.num == 5 or event.delta == -120:
        GL.glScalef(0.5, 0.5, 0.5)
    if event.num == 4 or event.delta == 120:
        GL.glScalef(1.5, 1.5, 1.5)


def key_scale(event):
    print("asd")
    if event.keysym == "Left":
        GL.glTranslatef(0.5, 0, 0)
    if event.keysym == "Right":
        GL.glTranslatef(-0.5, 0, 0)
    if event.keysym == "Up":
        GL.glTranslatef(0, -0.5, 0)
    if event.keysym == "Down":
        GL.glTranslatef(0, 0.5, 0)


def app_main(edges, vertices, incorrect_coord, mesh_left, mesh_right):
    vertex, incorrect_coord = transform_coord(vertices, incorrect_coord,
                                              mesh_left, mesh_right)
    screen = (800, 600)

    Scene.set_hands(edges, vertices, incorrect_coord, mesh_left, mesh_right)

    root = tkinter.Tk()
    app = AppOgl(root, width=screen[0], height=screen[1])
    btn = tkinter.Button(root, text="Kek")
    btn1 = tkinter.Button(root, text="Lol")
    btn2 = tkinter.Button(root, text="Ha")
    app.pack(fill=tkinter.BOTH, expand=tkinter.YES)
    btn.pack(fill=tkinter.BOTH, expand=tkinter.YES)
    btn1.pack(fill=tkinter.BOTH, expand=tkinter.YES)
    btn2.pack(fill=tkinter.BOTH, expand=tkinter.YES)

    app.bind("<Motion>", mouse_motion)
    app.bind("<B1-Motion>", camera_motion)
    app.bind("<MouseWheel>", mouse_scale)
    root.bind("<Left>", key_scale)
    root.bind("<Right>", key_scale)
    root.bind("<Down>", key_scale)
    root.bind("<Up>", key_scale)
    app.animate = 1
    app.after(100, app.printContext)
    root.mainloop()

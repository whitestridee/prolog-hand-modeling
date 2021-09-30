import time

from OpenGL import GL, GLU
from pyopengltk import OpenGLFrame


class Scene:
    class Source:
        vertices = []
        incorrect_coord = []

    edges = []
    vertices = []
    incorrect_coord = []
    mouse_x = 0
    mouse_y = 0
    mesh_left = None
    mesh_right = None
    mesh = True
    edit_point = None

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


def rotate_camera(x, y):
    GL.glRotatef(y, 1, 0, 0)
    GL.glRotatef(x, 0, 1, 0)


def zoom_camera(factor):
    GL.glScalef(factor, factor, factor)


def translate_camera(x, y, z):
    GL.glTranslatef(x, y, z)

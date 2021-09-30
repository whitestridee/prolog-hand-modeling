import time

from OpenGL import GL, GLU
from pyopengltk import OpenGLFrame

from ui.const import COLOR_BG, COLOR_BONE, COLOR_INCORRECT
from ui.model import ComplexModel


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


class AppOgl(OpenGLFrame):
    screen = (800, 600)

    def initgl(self):
        """Initalize gl states when the frame is created"""
        GL.glViewport(0, 0, self.width, self.height)
        GL.glClearColor(COLOR_BG[0], COLOR_BG[1], COLOR_BG[2], 0)

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

        GL.glClearColor(COLOR_BG[0], COLOR_BG[1], COLOR_BG[2], 0)
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
def hands(edges, vertices, incorrect_coord, mesh_left, mesh_right, mesh):
    GL.glLineWidth(2)
    GL.glPointSize(6)

    '''if mesh and mesh_left and mesh_right:
        GL.glBegin(GL.GL_TRIANGLES)
        mesh_left.render_triangles()
        mesh_right.render_triangles()
        GL.glEnd()
        GL.glBegin(GL.GL_QUADS)
        mesh_left.render_quads()
        mesh_right.render_quads()
        GL.glEnd()
        GL.glBegin(GL.GL_POLYGON)
        mesh_left.render_polygons()
        mesh_right.render_polygons()
        GL.glEnd()
        GL.glBegin(GL.GL_LINES)
        mesh_left.render_edges()
        mesh_right.render_edges()
        GL.glEnd()'''

    GL.glBegin(GL.GL_LINES)
    for edge in edges:
        for vertex in edge:
            color = COLOR_BONE
            if vertices[vertex] in incorrect_coord:
                color = COLOR_INCORRECT
            GL.glColor3d(color[0], color[1], color[2])
            GL.glVertex3fv(vertices[vertex])
    if mesh and mesh_left and mesh_right:
        mesh_left.render_edges()
        mesh_right.render_edges()
    GL.glEnd()

    GL.glBegin(GL.GL_POINTS)
    GL.glColor3d(0, 0, 0)
    for i in vertices:
        GL.glVertex3d(i[0], i[1], i[2])
    GL.glEnd()


def rotate_camera(x, y):
    GL.glRotatef(y, 1, 0, 0)
    GL.glRotatef(x, 0, 1, 0)


def zoom_camera(factor):
    GL.glScalef(factor, factor, factor)


def translate_camera(x, y, z):
    GL.glTranslatef(x, y, z)

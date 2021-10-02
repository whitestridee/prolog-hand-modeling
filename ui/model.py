from OpenGL import GL
from pyglet import gl

from ui.const import COLOR_BLACK, COLOR_WHITE
from utils.vector import Vector3


class Vertex(Vector3):
    def __init__(self, x=0, y=0, z=0, color=COLOR_BLACK):
        super().__init__(x, y, z)
        self.color = color


class Edge:
    def __init__(self, v1, v2, color=COLOR_BLACK, width=1):
        self.start = v1
        self.end = v2
        self.color = color
        self.width = width

    def __getitem__(self, item):
        if item == 0:
            return self.start
        if item == 1:
            return self.end

    def list(self):
        return [self.start, self.end]


class Face:
    def __init__(self, vertices, color=COLOR_WHITE):
        self.vertices = vertices.copy()
        self.color = color

    def __getitem__(self, item):
        return self.vertices[item]

    def list(self):
        return self.vertices


class TriangleFace(Face):
    def __init__(self, v1, v2, v3, color=COLOR_WHITE):
        super().__init__([v1, v2, v3], color)


class QuadFace(Face):
    def __init__(self, v1, v2, v3, v4, color=COLOR_WHITE):
        super().__init__([v1, v2, v3, v4], color)


class Model:
    def __init__(self):
        self.vertices = []
        self.edges = []
        self.triangles = []
        self.quads = []
        self.polygons = []

    def render_vertices(self):
        for v in self.vertices:
            GL.glColor3d(v.color[0], v.color[1], v.color[2])
            GL.glVertex3d(v.list())

    def render_edges(self):
        for edge in self.edges:
            color = edge.color
            for vertex in edge.list():
                GL.glColor3d(color[0], color[1], color[2])
                GL.glVertex3fv(self.vertices[vertex].list())

    def render_triangles(self):
        for tr in self.triangles:
            color = tr.color
            for vertex in tr.list():
                GL.glColor3d(color[0], color[1], color[2])
                GL.glVertex3fv(self.vertices[vertex].list())

    def render_quads(self):
        for quad in self.quads:
            color = quad.color
            for vertex in quad.list():
                GL.glColor3d(color[0], color[1], color[2])
                GL.glVertex3fv(self.vertices[vertex].list())

    def render_polygons(self):
        for polygon in self.polygons:
            color = polygon.color
            for vertex in polygon.list():
                GL.glColor3d(color[0], color[1], color[2])
                GL.glVertex3fv(self.vertices[vertex].list())


class ComplexModel(Model):
    def __init__(self, models):
        super().__init__()
        self.models = models.copy()

    def render_vertices(self):
        super().render_vertices()
        for model in self.models:
            model.render_vertices()

    def render_edges(self):
        super().render_edges()
        for model in self.models:
            model.render_edges()

    def render_triangles(self):
        super().render_triangles()
        for model in self.models:
            model.render_triangles()

    def render_quads(self):
        super().render_quads()
        for model in self.models:
            model.render_quads()

    def render_polygons(self):
        super().render_polygons()
        for model in self.models:
            model.render_polygons()

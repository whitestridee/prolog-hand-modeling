from ui.const import COLOR_BLACK, COLOR_WHITE
from utils.vector import Vector3


class Vertex(Vector3):
    def __init__(self, x=0, y=0, z=0, color=COLOR_BLACK):
        super().__init__(x, y, z)
        self.color = color


class Edge:
    def __init__(self, v1, v2, color=COLOR_BLACK):
        self.start = v1
        self.end = v2
        self.color = color

    def __getitem__(self, item):
        if item == 0:
            return self.start
        if item == 1:
            return self.end


class Face:
    def __init__(self, vertices, color=COLOR_WHITE):
        self.vertices = vertices.copy()
        self.color = color

    def __getitem__(self, item):
        return self.vertices[item]


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

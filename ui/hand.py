import math
import colorsys

from OpenGL import GL

from ui.const import PHALANX_W, PHALANX_H
from ui.model import Vertex, Model, Edge, TriangleFace, QuadFace, Face, \
    ComplexModel


class PhalanxModel(Model):
    def __init__(self, start, end, w, h_start, h_end, color):
        super().__init__()
        self.start = start
        self.end = end

        v_dir = self.end - self.start
        angle_z = math.atan2(v_dir.y, v_dir.x)
        angle_y = math.atan2(v_dir.z, v_dir.y)
        angle_x = math.atan2(v_dir.x, v_dir.z)

        x1 = self.start.x
        y1 = self.start.y
        z1 = self.start.z
        x2 = self.end.x
        y2 = self.end.y
        z2 = self.end.z

        # main mesh
        self.vertices = [
            Vertex(x1, y1, z1 - h_start),
            Vertex(x1 - w, y1, z1 + w),
            Vertex(x1 + w, y1, z1 + w),
            Vertex(x2, y2, z2 - h_end),
            Vertex(x2 - w, y2, z2 + w),
            Vertex(x2 + w, y2, z2 + w)
        ]

        '''for v in self.vertices:
            v.rotate(angle_x, angle_y, angle_z, self.start)'''

        self.edges = [
            Edge(0, 1, color), Edge(1, 2, color), Edge(2, 0, color),
            Edge(3, 4, color), Edge(4, 5, color), Edge(5, 3, color),
            Edge(0, 3, color), Edge(1, 4, color), Edge(2, 5, color)
        ]

        # sub-mesh
        '''
        n = 3
        step = v_dir * (1 / (n - 1))
        hsv_color = colorsys.rgb_to_hsv(color[0], color[1], color[2])
        sub_color = colorsys.hsv_to_rgb(hsv_color[0], hsv_color[1] * 0.5,
                                        min(hsv_color[2] * 1.1, 1))

        pos_1 = Vertex(x1, y1, z1 - h_start) + step
        pos_2 = Vertex(x1 - w, y1, z1 + w) + step
        pos_3 = Vertex(x1 + w, y1, z1 + w) + step
        k = 6
        for i in range(n - 1):
            self.vertices.append(Vertex(pos_1.x, pos_1.y, pos_1.z))
            self.vertices.append(Vertex(pos_2.x, pos_2.y, pos_2.z))
            self.vertices.append(Vertex(pos_3.x, pos_3.y, pos_3.z))
            self.edges.append(Edge(k, k + 1, sub_color))
            self.edges.append(Edge(k, k + 2, sub_color))
            self.edges.append(Edge(k + 1, k + 2, sub_color))
            pos_1 += step
            pos_2 += step
            pos_3 += step
            k += 3
        '''

        # faces
        self.triangles = [
            TriangleFace(0, 1, 2, color),
            TriangleFace(3, 4, 5, color)
        ]

        self.quads = [
            QuadFace(0, 3, 4, 1, color),
            QuadFace(0, 3, 5, 2, color),
            QuadFace(1, 4, 5, 2, color)
        ]

    def coord(self):
        return self.vertices.copy()

    def transform(self, factor):
        for i in range(len(self.vertices)):
            self.vertices[i] *= factor

    def render_edges_with_incorrect(self, incorrect_points, incorrect_color):
        for edge in self.edges:
            color = edge.color
            for vertex in edge.list():
                col = color
                if self.start in incorrect_points or self.end in incorrect_points:
                    col = incorrect_color
                GL.glColor3d(col[0], col[1], col[2])
                GL.glVertex3fv(self.vertices[vertex].list())


class EndPhalanxModel(PhalanxModel):
    def __init__(self, start, end, w, h_end, color):
        super().__init__(start, end, w, 0, h_end, color)


class FingerModel(ComplexModel):

    def __init__(self, color, point1, point2, point3, point4=None):
        self.phalanges = [
            EndPhalanxModel(point1, point2, PHALANX_W, PHALANX_H, color),
            PhalanxModel(point2, point3,
                         PHALANX_W, PHALANX_H, PHALANX_H, color)
        ]
        if point4 is not None:
            self.phalanges.append(
                PhalanxModel(point3, point4,
                             PHALANX_W, PHALANX_H, PHALANX_H, color))

        super().__init__(self.phalanges)
        self.vertices = [point1, point2, point3]
        if point4 is not None:
            self.vertices.append(point4)

    def render_edges_with_incorrect(self, incorrect_points, incorrect_color):
        for model in self.models:
            model.render_edges_with_incorrect(
                incorrect_points, incorrect_color)

    def base(self):
        return self.vertices[-1]

    def coord(self):
        res = []
        for ph in self.phalanges:
            res += ph.coord()
        return res

    def transform(self, factor):
        for ph in self.phalanges:
            ph.transform(factor)


class HandModel(ComplexModel):

    def __init__(self, points, color):

        self.fingers = [
            FingerModel(color, points[16], points[17], points[18]),
            FingerModel(color, points[12], points[13], points[14], points[15]),
            FingerModel(color, points[8], points[9], points[10], points[11]),
            FingerModel(color, points[4], points[5], points[6], points[7]),
            FingerModel(color, points[0], points[1], points[2], points[3])
        ]

        super().__init__(self.fingers)

        self.base = points[19]
        self.wrist = points[20]

        base_vertices = [finger.base() for finger in self.fingers] + [
            self.wrist, self.base
        ]

        self.vertices = []
        d = 12
        for v in base_vertices:
            self.vertices.append(Vertex(v.x, v.y, v.z - d))
        for v in base_vertices:
            self.vertices.append(Vertex(v.x, v.y, v.z + d))

        self.edges = [
            Edge(0, 1, color), Edge(1, 2, color), Edge(2, 3, color),
            Edge(3, 4, color), Edge(4, 5, color), Edge(5, 0, color),
            Edge(7, 8, color), Edge(8, 9, color), Edge(9, 10, color),
            Edge(10, 11, color), Edge(11, 12, color), Edge(12, 7, color),
            Edge(0, 7, color), Edge(1, 8, color), Edge(2, 9, color),
            Edge(3, 10, color), Edge(4, 11, color), Edge(5, 12, color),
            Edge(0, 6, color), Edge(1, 6, color), Edge(2, 6, color),
            Edge(3, 6, color), Edge(4, 6, color), Edge(5, 6, color),
            Edge(7, 13, color), Edge(8, 13, color), Edge(9, 13, color),
            Edge(10, 13, color), Edge(11, 13, color), Edge(12, 13, color)
        ]

        self.quads = [
            QuadFace(0, 1, 7, 6, color),
            QuadFace(1, 2, 8, 7, color),
            QuadFace(2, 3, 9, 8, color),
            QuadFace(3, 4, 10, 9, color),
            QuadFace(4, 5, 11, 10, color),
            QuadFace(5, 0, 6, 11, color)
        ]

        self.polygons = [
            Face([0, 1, 2, 3, 4, 5], color),
            Face([6, 7, 8, 9, 10, 11], color)
        ]

    def render_edges_with_incorrect(self, incorrect_points, incorrect_color):
        for model in self.models:
            model.render_edges_with_incorrect(
                incorrect_points, incorrect_color)

    def coord(self):
        res = []
        for finger in self.fingers:
            res += finger.coord()
        return res

    def transform(self, factor):
        for finger in self.fingers:
            finger.transform(factor)
        for i in range(len(self.vertices)):
            self.vertices[i] *= factor


class RightHandModel(HandModel):

    def __init__(self, points, color):
        super().__init__([
            points[15], points[16], points[17], points[18],
            points[11], points[12], points[13], points[14],
            points[7], points[8], points[9], points[10],
            points[3], points[4], points[5], points[6],
            points[0], points[1], points[2],
            points[19], points[20]
        ], color)

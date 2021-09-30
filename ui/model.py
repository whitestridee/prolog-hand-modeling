from OpenGL import GL

from ui.const import PHALANX_W, PHALANX_H
from utils.vector import Vector3
import math


class PhalanxModel:
    def __init__(self, start, end, w, h_start, h_end):
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

        self.vertices = [
            Vector3(x1, y1, z1 - h_start),
            Vector3(x1 - w, y1, z1 + w),
            Vector3(x1 + w, y1, z1 + w),
            Vector3(x2, y2, z2 - h_end),
            Vector3(x2 - w, y2, z2 + w),
            Vector3(x2 + w, y2, z2 + w)
        ]

        '''for v in self.vertices:
            v.rotate(angle_x, angle_y, angle_z, self.start)'''

        self.edges = [
            [0, 1], [1, 2], [2, 0],
            [3, 4], [4, 5], [5, 3],
            [0, 3], [1, 4], [2, 5]
        ]

    def coord(self):
        return self.vertices.copy()

    def transform(self, factor):
        for i in range(len(self.vertices)):
            self.vertices[i] *= factor

    def draw(self, color_r, color_g, color_b):
        for edge in self.edges:
            for vertex in edge:
                GL.glColor3d(color_r, color_g, color_b)
                GL.glVertex3fv(self.vertices[vertex].to_list())


class EndPhalanxModel(PhalanxModel):
    def __init__(self, start, end, w, h_end):
        super().__init__(start, end, w, 0, h_end)


class FingerModel:

    def __init__(self, point1, point2, point3, point4=None):
        self.vertices = [point1, point2, point3]
        self.phalanges = [
            EndPhalanxModel(point1, point2, PHALANX_W, PHALANX_H),
            PhalanxModel(point2, point3, PHALANX_W, PHALANX_H, PHALANX_H)
        ]
        if point4 is not None:
            self.vertices.append(point4)
            self.phalanges.append(
                PhalanxModel(point3, point4, PHALANX_W, PHALANX_H, PHALANX_H))

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

    def draw(self, color_r, color_g, color_b):
        for ph in self.phalanges:
            ph.draw(color_r, color_g, color_b)


class HandModel:

    def __init__(self, points):
        self.fingers = [
            FingerModel(points[16], points[17], points[18]),
            FingerModel(points[12], points[13], points[14], points[15]),
            FingerModel(points[8], points[9], points[10], points[11]),
            FingerModel(points[4], points[5], points[6], points[7]),
            FingerModel(points[0], points[1], points[2], points[3])
        ]

        self.base = points[19]
        self.wrist = points[20]

        self.vertices = []
        self.edges = []
        self.set_palm()

    def set_palm(self):
        base_vertices = [finger.base() for finger in self.fingers] + [
            self.wrist
        ]

        self.vertices = []
        d = 12
        for v in base_vertices:
            self.vertices.append(Vector3(v.x, v.y, v.z - d))
        for v in base_vertices:
            self.vertices.append(Vector3(v.x, v.y, v.z + d))

        self.edges = [
            [0, 1], [1, 2], [2, 3], [3, 4], [4, 5], [5, 0],
            [6, 7], [7, 8], [8, 9], [9, 10], [10, 11], [11, 6],
            [0, 6], [1, 7], [2, 8], [3, 9], [4, 10], [5, 11]
        ]

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

    def draw(self, color_r, color_g, color_b):
        for finger in self.fingers:
            finger.draw(color_r, color_g, color_b)
        for edge in self.edges:
            for vertex in edge:
                GL.glColor3d(color_r, color_g, color_b)
                GL.glVertex3fv(self.vertices[vertex].to_list())


class RightHandModel(HandModel):

    def __init__(self, points):
        super().__init__([
            points[15], points[16], points[17], points[18],
            points[11], points[12], points[13], points[14],
            points[7], points[8], points[9], points[10],
            points[3], points[4], points[5], points[6],
            points[0], points[1], points[2],
            points[19], points[20]
        ])

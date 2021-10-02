import math


class Vector3:

    def __init__(self, x=0, y=0, z=0):
        self.x = x
        self.y = y
        self.z = z
        
    def __getitem__(self, item):
        if item == 0:
            return self.x
        if item == 1:
            return self.y
        if item == 2:
            return self.z

    def list(self):
        return [self.x, self.y, self.z]

    def __add__(self, other):
        return Vector3(self.x + other.x, self.y + other.y, self.z + other.z)

    def __radd__(self, other):
        return Vector3(self.x + other.x, self.y + other.y, self.z + other.z)

    def __sub__(self, other):
        return Vector3(self.x - other.x, self.y - other.y, self.z - other.z)

    def __rsub__(self, other):
        return Vector3(self.x - other.x, self.y - other.y, self.z - other.z)

    def __mul__(self, scalar):
        return Vector3(self.x * scalar, self.y * scalar, self.z * scalar)

    def __rmul__(self, scalar):
        return Vector3(self.x * scalar, self.y * scalar, self.z * scalar)

    def __imul__(self, scalar):
        return Vector3(self.x * scalar, self.y * scalar, self.z * scalar)

    def __neg__(self):
        return Vector3(-self.x, -self.y, -self.z)

    def __pos__(self):
        return Vector3(self.x, self.y, self.z)

    def __xor__(self, other):
        cx = self.y * other.z - self.z * other.y
        cy = self.z * other.x - self.x * other.z
        cz = self.x * other.y - self.y * other.x
        return Vector3(cx, cy, cz)

    def cross(self, other):
        return self ^ other

    def rotate(self, x, y, z, center):
        self.rotate_x(x, center)
        self.rotate_y(y, center)
        self.rotate_z(z, center)

    def rotate_x(self, angle, pc):
        dy = self.y - pc.y
        dz = self.z - pc.z
        sin_a = math.sin(angle)
        cos_a = math.cos(angle)
        self.y = pc.y + dy * cos_a - dz * sin_a
        self.z = pc.z + dy * sin_a + dz * cos_a

    def rotate_y(self, angle, pc):
        dx = self.x - pc.x
        dz = self.z - pc.z
        sin_a = math.sin(angle)
        cos_a = math.cos(angle)
        self.z = pc.z + dz * cos_a - dx * sin_a
        self.x = pc.x + dz * sin_a + dx * cos_a

    def rotate_z(self, angle, pc):
        dx = self.x - pc.x
        dy = self.y - pc.y
        sin_a = math.sin(angle)
        cos_a = math.cos(angle)
        self.x = pc.x + dx * cos_a - dy * sin_a
        self.y = pc.y - dx * sin_a + dy * cos_a

    def __str__(self):
        return "(" + str(self.x) + ", " + str(self.y) + ", " + str(
            self.z) + ")"

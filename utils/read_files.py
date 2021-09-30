import json


def get_vertices(filename):
    verticies = []
    with open(filename) as f:
        for line in f.readlines():
            verticies.append(list(map(float, line.split(';'))))
    return verticies


def get_edges(filename):
    with open(filename) as f:
        edges = json.load(f)
    return edges


if __name__ == '__main__':
    pass
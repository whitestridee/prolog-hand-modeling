import json
from tkinter import filedialog, messagebox

from ui.const import COLOR_LEFT_HAND, COLOR_RIGHT_HAND
from ui.events import generate_mesh
from ui.scene import Scene
from ui.hand import HandModel, RightHandModel
from utils.vector import Vector3


def get_vertices(filename):
    vertices = []
    with open(filename) as f:
        for line in f.readlines():
            vertices.append(list(map(float, line.split(';'))))
    return vertices


def get_edges(filename):
    with open(filename) as f:
        edges = json.load(f)
    return edges


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
        Scene.vertices = get_vertices(path)
        Scene.edges = get_edges('data/bone_edges.json')

        generate_mesh()

        Scene.Source.vertices = Scene.vertices.copy()
        Scene.incorrect_coord.clear()
        Scene.Source.incorrect_coord.clear()


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

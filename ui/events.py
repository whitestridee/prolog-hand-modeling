import json

from ui.const import VERTICES_ON_IMG
from utils.prolog import get_answer
from ui.scene import Scene, rotate_camera, zoom_camera, translate_camera
from tkinter import messagebox
from OpenGL import GL


import main


def mouse_motion(event):
    Scene.mouse_x = event.x
    Scene.mouse_y = event.y


def mouse_rotate(event):
    rel_x = event.x - Scene.mouse_x
    rel_y = event.y - Scene.mouse_y
    rotate_camera(rel_x, rel_y)
    mouse_motion(event)


def mouse_scale(event):
    if event.num == 5 or event.delta == -120:
        zoom_camera(0.5)
    if event.num == 4 or event.delta == 120:
        zoom_camera(1.5)


def key_translate(event):
    if event.keysym == "Left":
        translate_camera(0.5, 0, 0)
    if event.keysym == "Right":
        translate_camera(-0.5, 0, 0)
    if event.keysym == "Up":
        translate_camera(0, -0.5, 0)
    if event.keysym == "Down":
        translate_camera(0, 0.5, 0)


def mesh_switch():
    Scene.mesh = not Scene.mesh


def valid_points():
    hand_coord_arg = ', '.join([str(x) for x in Scene.Source.vertices])
    statement = ("validate_all('.', Result, " + hand_coord_arg + ")")
    answer1 = get_answer(
        filename='logic/validation.pl', statement=statement,
    )
    for i in answer1:
        print(i)

    Scene.Source.incorrect_coord.clear()
    with open(f'./points.txt', 'r', encoding='utf-8') as f:
        file_data = f.read()
    if file_data is None:
        print('Координаты кистей корректны')
    else:
        file_data = file_data.split('\n')
        for line in file_data:
            if line:
                Scene.Source.incorrect_coord += json.loads(line)
    Scene.incorrect_coord = Scene.Source.incorrect_coord.copy()


def select_vertex(event):

    for i in range(len(VERTICES_ON_IMG)):
        if abs(VERTICES_ON_IMG[i][0] - event.x) < 4 and \
                abs(VERTICES_ON_IMG[i][1] - event.y) < 4:
            Scene.edit_point = i
            break

    # projection = GL.glGetDoublev(GL.GL_PROJECTION_MATRIX)
    # viewport = GL.glGetIntegerv(GL.GL_VIEWPORT)
    # modelview = Scene.modelMatrix
    #
    # winX = float(Scene.mouse_x)
    # winY = float(viewport[3]) - float(Scene.mouse_y)
    # posXF, posYF, posZF = GLU.gluUnProject(
    # winX, winY, 1, model=modelview, proj=projection, view=viewport)
    # posXN, posYN, posZN = GLU.gluUnProject(
    # winX, winY, 0, model=modelview, proj=projection, view=viewport)
    #
    # posZ = 0
    # posX = (posZ - posZN) / (posZF - posZN) * (posXF - posXN) + posXN
    # posY = (posZ - posZN) / (posZF - posZN) * (posYF - posYN) + posYN
    #
    # print(posX, posY, posXF, posYF)
    # #print(Scene.vertices)


def edit_points(move):
    #print(Scene.vertices[Scene.edit_point][0])
    if len(Scene.vertices) != 0:
        if Scene.edit_point is not None:
            if move == 'X+':
                Scene.vertices[Scene.edit_point][0] += Scene.step
            if move == 'X-':
                Scene.vertices[Scene.edit_point][0] -= Scene.step
            if move == 'Y+':
                Scene.vertices[Scene.edit_point][1] += Scene.step
            if move == 'Y-':
                Scene.vertices[Scene.edit_point][1] -= Scene.step
            if move == 'Z+':
                Scene.vertices[Scene.edit_point][2] += Scene.step
            if move == 'Z-':
                Scene.vertices[Scene.edit_point][2] -= Scene.step
        else:
            messagebox.showerror("Error", "Click on point that you want to edit in the picture")
    else:
        messagebox.showerror("File error", "Load a file with points first")
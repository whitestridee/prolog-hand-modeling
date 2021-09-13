import pygame
from pygame.locals import *
from OpenGL.GL import *
from OpenGL.GLU import *

def transorm_coor(coor):
    max_elem = None
    min_elem = None
    for xyz in coor:
        if max_elem is None or max_elem < max(xyz):
            max_elem = max(xyz)
        if min_elem is None or min_elem > min(xyz):
            min_elem = min(xyz)
    if abs(max_elem) > abs(min_elem):
        res = abs(max_elem)
    else:
        res = abs(min_elem)
        
    for i in range(len(coor)):
        for j in range(len(coor[i])):
            coor[i][j] = coor[i][j] / res
            
    return coor
    
    
        
        

# Создаем кисть с помощью вершин и ребер
def hands(edges, verticies):
    glLineWidth(3)
    glPointSize(4)    
    
    glBegin(GL_LINES)
    glColor3d(20/255, 20/255, 20/255)
    for edge in edges:
        for vertex in edge:
            glVertex3fv(verticies[vertex])
    glEnd()
    
    glBegin(GL_POINTS)
    glColor3d(0, 0, 0)
    for i in verticies:
        glVertex3d(i[0], i[1], i[2])
    glEnd()
    
def create_visual(edges, vertex):
    vertex = transorm_coor(vertex)
    pygame.init()
    screen = (800, 600)
    
    
    surface = pygame.display.set_mode(screen, DOUBLEBUF|OPENGL)
    pygame.display.flip()
    
    glMatrixMode(GL_PROJECTION)
    gluPerspective(45, (screen[0] / screen[1]), 0.1, 4000)
    button_down = False

    glMatrixMode(GL_MODELVIEW)  
    modelMatrix = glGetFloatv(GL_MODELVIEW_MATRIX)

    while True:
        glPushMatrix()
        glLoadIdentity()

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT:
                    glTranslatef(0.5, 0, 0)
                if event.key == pygame.K_RIGHT:
                    glTranslatef(-0.5, 0, 0)
                if event.key == pygame.K_UP:
                    glTranslatef(0, -0.5, 0)
                if event.key == pygame.K_DOWN:
                    glTranslatef(0, 0.5, 0)
                if event.key == pygame.K_x:
                    glScalef(0.5,0.5,0.5);
                if event.key == pygame.K_z:
                    glScalef(1.5,1.5,1.5);                

            if event.type == pygame.MOUSEMOTION:
                if button_down == True:
                    glRotatef(event.rel[1], 1, 0, 0)
                    glRotatef(event.rel[0], 0, 1, 0)
                    #print(event.rel)

        for event in pygame.mouse.get_pressed():
    #     print(pygame.mouse.get_pressed())
            if pygame.mouse.get_pressed()[0] == 1:
                button_down = True
            elif pygame.mouse.get_pressed()[0] == 0:
                button_down = False

        glClearColor(190/225, 194/255, 207/255, 0)
        glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT)

        glMultMatrixf(modelMatrix)
        modelMatrix = glGetFloatv(GL_MODELVIEW_MATRIX)

        glLoadIdentity()
        glTranslatef(0, 0, -5)
        glMultMatrixf(modelMatrix)
        hands(edges, vertex)
        
        glPopMatrix()
        pygame.display.flip()   
        pygame.time.wait(10)   
        
if __name__ == '__main__':
    from files import get_xyz_point, get_edges
    
    hand_coor = []
    for i in range(42):
        vertices = get_xyz_point(
            filename='brush1.txt',
            filepath=r'C:\Users\green\Documents\GitHub\prolog-hand-modeling\test',
            string_num=i,
        )
        xyz = list(map(lambda x: None if x == 'Nan' else float(x), vertices.split(';')))
        hand_coor.append(xyz)
        
    bone_edges = get_edges(filename='bone_edges.json')
        
    create_visual(bone_edges, hand_coor)    
import pygame
from pygame.locals import *
from OpenGL.GL import *
from OpenGL.GLU import *

def transorm_coor(coor, incorrect_coor):
    max_elem = None
    min_elem = None
    for xyz in coor:
        if max_elem is None or max_elem < max(xyz):
            max_elem = max(xyz)
        if min_elem is None or min_elem > min(xyz):
            min_elem = min(xyz)
    res = abs(max_elem) + abs(min_elem)
    #if abs(max_elem) > abs(min_elem):
        #res = abs(max_elem)
    #else:
        #res = abs(min_elem)
        
    for i in range(len(coor)):
        for j in range(len(coor[i])):
            coor[i][j] = coor[i][j] / res * 2
            
    for i in range(len(incorrect_coor)):
        for j in range(len(incorrect_coor[i])):
            incorrect_coor[i][j] = incorrect_coor[i][j] / res * 2
    return coor, incorrect_coor
    
    
        
        

# Создаем кисть с помощью вершин и ребер
def hands(edges, verticies, incorrect_coor):
    glLineWidth(2)
    glPointSize(6)    
    
    glBegin(GL_LINES)
    color_hand1 = [1, 121, 111] # Зеленый - левая рука
    color_hand2 = [205, 127, 50] # Коричневый - правая рука
    color_incorrect = [255, 0, 0]
    # glColor3d(20/255, 20/255, 20/255)
    for edge in edges:
        for vertex in edge:
            # print(verticies[vertex], incorrect_coor)
            if verticies[vertex] not in incorrect_coor:
                if vertex < 21:
                    glColor3d(color_hand1[0]/255, color_hand1[1]/255, color_hand1[2]/255)
                    glVertex3fv(verticies[vertex])
                else:
                    glColor3d(color_hand2[0]/255, color_hand2[1]/255, color_hand2[2]/255)
                    glVertex3fv(verticies[vertex])
            else:
                glColor3d(color_incorrect[0]/255, color_incorrect[1]/255, color_incorrect[2]/255)
                glVertex3fv(verticies[vertex])                
                
    glEnd()
    
    glBegin(GL_POINTS)
    glColor3d(0, 0, 0)
    for i in verticies:
        glVertex3d(i[0], i[1], i[2])
    glEnd()
    
def create_visual(edges, vertex, incorrect_coor):
    vertex, incorrect_coor = transorm_coor(vertex, incorrect_coor)
    pygame.init()
    screen = (800, 600)
    
    #if vertex[0] < vertex[0] test_success1
    
    
    surface = pygame.display.set_mode(screen, DOUBLEBUF|OPENGL)
    pygame.display.flip()
    
    glMatrixMode(GL_PROJECTION)
    gluPerspective(45, (screen[0] / screen[1]), 0.1, 4000)
    button_down = False

    glMatrixMode(GL_MODELVIEW)  
    modelMatrix = glGetFloatv(GL_MODELVIEW_MATRIX)
    
    starttime_minus = None
    starttime_plus = None

    while True:
        glPushMatrix()
        glLoadIdentity()
        
        keys = pygame.key.get_pressed()
        if keys[pygame.K_MINUS]:
            if not starttime_minus or pygame.time.get_ticks() - starttime_minus > 500:
                glScalef(0.5,0.5,0.5)
                starttime_minus = pygame.time.get_ticks()
        if keys[pygame.K_EQUALS]:
            if not starttime_plus or pygame.time.get_ticks() - starttime_plus > 500:
                glScalef(1.5,1.5,1.5)
                starttime_plus = pygame.time.get_ticks()

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

            if event.type == pygame.MOUSEMOTION:
                if button_down == True:
                    if keys[pygame.K_x]:
                        glRotatef(event.rel[1], 1, 0, 0)
                    elif keys[pygame.K_c]:
                        glRotatef(event.rel[0], 0, 1, 0)
                    elif keys[pygame.K_z]:
                        glRotatef(event.rel[0], 0, 0, 1)
                    else:
                        glRotatef(event.rel[1], 1, 0, 0)    
                        glRotatef(event.rel[0], 0, 1, 0)

        for event in pygame.mouse.get_pressed():
    #     print(pygame.mouse.get_pressed())
            if pygame.mouse.get_pressed()[0] == 1:
                button_down = True
            elif pygame.mouse.get_pressed()[0] == 0:
                button_down = False

        glClearColor(190/255, 194/255, 207/255, 0)
        glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT)

        glMultMatrixf(modelMatrix)
        modelMatrix = glGetFloatv(GL_MODELVIEW_MATRIX)

        glLoadIdentity()
        glTranslatef(0, 0, -5)
        glMultMatrixf(modelMatrix)
        hands(edges, vertex, incorrect_coor)
        
        glPopMatrix()
        pygame.display.flip()   
        pygame.time.wait(10)   
        pygame.event.pump()
        
def test_error1():
    hand_coor = []
    for i in range(42):
        vertices = get_xyz_point(
            filename='example1.txt',
            filepath=r'D:\university\sem7\prolog\prolog-hand-modeling_last_update\test\error',
            string_num=i,
        )
        xyz = list(map(lambda x: None if x == 'Nan' else float(x), vertices.split(';')))
        hand_coor.append(xyz)
        
    bone_edges = get_edges(filename='bone_edges.json')
        
    create_visual(bone_edges, hand_coor)     

def test_success1():
    hand_coor = []
    for i in range(42):
        vertices = get_xyz_point(
            filename='example1.txt',
            filepath=r'D:\university\sem7\prolog\prolog-hand-modeling_last_update\test\success',
            string_num=i,
        )
        xyz = list(map(lambda x: None if x == 'Nan' else float(x), vertices.split(';')))
        hand_coor.append(xyz)
        
    bone_edges = get_edges(filename='bone_edges.json')
        
    create_visual(bone_edges, hand_coor)    
        
def test_success2():
    hand_coor = []
    for i in range(42):
        vertices = get_xyz_point(
            filename='example2.txt',
            filepath=r'D:\university\sem7\prolog\prolog-hand-modeling_last_update\test\success',
            string_num=i,
        )
        xyz = list(map(lambda x: None if x == 'Nan' else float(x), vertices.split(';')))
        hand_coor.append(xyz)
        
    bone_edges = get_edges(filename='bone_edges.json')
        
    create_visual(bone_edges, hand_coor)    
    
if __name__ == '__main__':
    from files import get_xyz_point, get_edges   
    #test_error1()
    #test_success1()
    test_success2()
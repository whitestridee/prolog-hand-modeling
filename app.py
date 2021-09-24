from utils.prolog import get_answer
from utils.files import get_xyz_point, get_edges
from utils.graphics import create_visual

import json

if __name__ == '__main__':
    # Задание
    hand_coor = []
    for i in range(42):
        vertices = get_xyz_point(
            filename='example2.txt',
            filepath=r'./test/error',
            string_num=i,
        )
        xyz = list(map(lambda x: None if x == 'Nan' else float(x), vertices.split(';')))
        hand_coor.append(xyz)
       
    bone_edges = get_edges(
        filename='bone_edges.json',
        filepath='utils'
    )

    hand_coord_arg = ', '.join([str(x) for x in hand_coor])
    statement = ("validate_all('.', Result, " + hand_coord_arg + ")")

    answer1 = get_answer(
        basestored='validation.pl', statement=statement,
    )
    
    print('-- Задание 1. Пролог --')
    print(f'{statement}')
    for i in answer1:
        print(i)
        

    with open(f'./points.txt', 'r', encoding='utf-8') as f:
        filedate = f.read()
    if filedate is None:
        print('Координаты кистей корректны')
    else:
        filedate = filedate.split('\n')
        incorrect_coor = []
        for line in filedate:
            if line:
                incorrect_coor += json.loads(line)
    create_visual(bone_edges, hand_coor, incorrect_coor)

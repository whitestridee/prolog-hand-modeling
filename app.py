from utils.prolog import get_answer
from utils.files import get_xyz_point, get_edges
from utils.graphics import create_visual


if __name__ == '__main__':
    # Задание
    hand_coor = []
    for i in range(42):
        vertices = get_xyz_point(
            filename='example2.txt',
            filepath=r'D:\university\sem7\prolog\prolog-hand-modeling_last_update\test\success',
            string_num=i,
        )
        xyz = list(map(lambda x: None if x == 'Nan' else float(x), vertices.split(';')))
        hand_coor.append(xyz)
        
    statement=f'validatefingerswithpoints({",".join(map(str, ["Result"] + hand_coor))})'
    answer1 = get_answer(
        basestored='validation.pl',
        statement=statement,        
    )
    print('-- Задание 1. Пролог --')
    print(f'{statement}')
    for i in answer1:
        if i["Result"] != b'Ok':
            print('Такой кисти не может существовать')
            exit()
        else:
            print('Сейчас будет нарисована кисть') 
            break
    else:
        exit()
    
    bone_edges = get_edges(
        filename='bone_edges.json',
        filepath='utils'
    )
        
    create_visual(bone_edges, hand_coor)
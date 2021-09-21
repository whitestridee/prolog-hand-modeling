from utils.prolog import get_answer
from utils.files import get_xyz_point, get_edges
from utils.graphics import create_visual

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

    hand_coord_arg = ', '.join([str(x) for x in hand_coor])

    print(hand_coor[7])
    statement = f'validate_all({",".join(map(str, ["Result"] + hand_coor))})'
    statement1 = ("validate_all('.', Result, " + hand_coord_arg + ")")

    answer1 = get_answer(
        basestored='validation.pl', statement=statement1,
    )
    print('-- Задание 1. Пролог --')
    print(f'{statement1}')
    for i in answer1:
        if i["Result"] != b'Ok':
            print('Такой кисти не может существовать')

        else:
            print('Сейчас будет нарисована кисть')
            break

    bone_edges = get_edges(
        filename='bone_edges.json',
        filepath='utils'
    )
        
    create_visual(bone_edges, hand_coor)

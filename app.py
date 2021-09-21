from utils.prolog import get_answer
from utils.files import get_xyz_point, get_edges
from utils.graphics import create_visual




if __name__ == '__main__':
    # Задание
    hand_coor = []
    for i in range(42):
        vertices = get_xyz_point(
            filename='example2.txt',
            filepath=r'./test/success',
            string_num=i,
        )
        xyz = list(map(lambda x: None if x == 'Nan' else float(x), vertices.split(';')))
        hand_coor.append(xyz)

    print(hand_coor[7])
    statement = f'validatefingerswithpoints({",".join(map(str, ["Result"] + hand_coor))})'
    statement1 = ("validatefingerswithpoints('.', Result, " + str(hand_coor[16])) + ", " + str(hand_coor[17]) + ", " + str(hand_coor[18]) + ", "     + str(hand_coor[12]) + ", " \
                 + str(hand_coor[13]) + ", " + str(hand_coor[14]) + ", "    + str(hand_coor[15]) + ", " + str(hand_coor[8]) + ", " \
                 + str(hand_coor[9]) + ", "    + str(hand_coor[10]) + ", " + str(hand_coor[11]) + ", " + str(hand_coor[4]) + ", " \
                 + str(hand_coor[5]) + ", " + str(hand_coor[6]) + ", " + str(hand_coor[7]) + ", "    + str(hand_coor[0]) + ", " \
                 + str(hand_coor[1]) + ", " + str(hand_coor[2]) + ", "    + str(hand_coor[3]) + ", " \
                 + str(hand_coor[19]) + ", " + str(hand_coor[20]) + ", " \
                 + str(hand_coor[21]) + ", " + str(hand_coor[22]) + ", "    + str(hand_coor[23]) + ", " \
                 + str(hand_coor[24]) + ", " + str(hand_coor[25]) + ", " + str(hand_coor[26]) + ", " \
                 + str(hand_coor[27]) + ", " + str(hand_coor[28]) + ", " + str(hand_coor[29]) + ", " \
                 + str(hand_coor[30]) + ", " + str(hand_coor[31]) + ", " + str(hand_coor[32]) + ", " \
                 + str(hand_coor[33]) + ", " + str(hand_coor[34]) + ", " + str(hand_coor[35]) + ", " \
                 + str(hand_coor[36]) + ", " + str(hand_coor[37]) + ", " + str(hand_coor[38]) + ", " \
                 + str(hand_coor[39]) + ", " + str(hand_coor[40]) + ", " + str(hand_coor[41]) + ")"





    answer1 = get_answer(
        basestored='validation.pl',
        statement = statement1,
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
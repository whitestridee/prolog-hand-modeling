import os
import json
import traceback

def get_xyz_point(filename, string_num, filepath=None):
    if filepath is None:
        filepath = ''
    fullpath = os.path.join(filepath, filename)
    try:
        with open(fullpath, 'r', encoding='utf-8') as f:
            filedate = f.read()
        list_string = filedate.split('\n')
        return list_string[string_num]
    except Exception as e:
        print(f'Не удалось открыть файл. Ошибка: {traceback.format_exc()}')
        return ''
    
def get_hand_coordinate(string_num, period, filepath=None):
    hand_coor = []
    for point in range(42):
        if period is None:
            break
        filename = f'xyz_{period}_{point}.txt'

        filedate = get_xyz_point(
            filename=filename,
            filepath=filepath,
            string_num=string_num,
        )
        if filedate:
            xyz = list(map(lambda x: None if x.lower() == 'nan' else float(x), filedate.split(';')))
        else:
            xyz = [None]*3
        hand_coor.append(xyz)

    return hand_coor

def get_edges(filename, filepath=None):
    if filepath is None:
        filepath = ''
    fullpath = os.path.join(filepath, filename)    
    try:
        with open(fullpath) as f:
            edges = json.load(f)  
        return edges
    except:
        return []    

if __name__ == '__main__':
    xyz = get_xyz_point(
        filepath=r'D:\university\sem7\prolog\prolog-hand-modeling_last_update\test',
        filename='brush1.txt', 
        string_num=5
    )
    print(f'XYZ: {xyz} for file: brush1.txt')
    
    hand = get_hand_coordinate(
        period=1,
        string_num=3,
        filepath=r'D:\university\sem7\prolog\prolog-hand-modeling_last_update\points_data',
        
    )
    print(f'hand coordinate = {hand}')
from pyswip import Prolog
import os

def append_base_stored(prolog, filename, filepath=None):
    if filepath is None:
        filepath = ''    
    fullpath = os.path.join(filepath, filename)
    prolog.consult(fullpath)
    
def get_answer(basestored, statement, filepath=None):
    prolog = Prolog()
    append_base_stored(prolog=prolog, 
                       filename=basestored,
                       filepath=filepath)
    return prolog.query(statement)

# Тестирование
if __name__ == '__main__':
    #answer = get_answer(
        #basestored='',
        #statement=''
    #)
    for k in range(1, 43):
        print("Point" + str(k) + ", ", end='')
              
        
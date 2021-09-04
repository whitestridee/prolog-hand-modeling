import os
import glob
#Добавляем точки к каждой line что бы пролог мог нормально прочитать файл)
path = 'C:/Users/green/Documents/GitHub/prolog-hand-modeling/points_data_with_dots'#Меняем на пвпку содержащую все .txt файлы
for filename in glob.glob(os.path.join(path, '*.txt')):
   with open(os.path.join(os.getcwd(), filename), 'r') as f:
       lines = f.read().splitlines()
   with open(os.path.join(os.getcwd(), filename), 'w') as f:
       for line in lines:
           if (line[len(line) - 1]) != ".":
               print(line + ".", file=f)
           else:
               print(line, file=f)
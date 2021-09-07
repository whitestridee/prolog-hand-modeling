:-use_module(read_files),
use_module(helper),
use_module(validation).

mainfile:-
%Тут надо встасить ссылку на свою папку с проектом
working_directory(_, "C:/Users/green/Documents/GitHub/prolog-hand-modeling"),
read_files:loadpoint(Lines, 'xyz_1_5.txt', 1),
helper:getfirstel(Lines,Value),
read_files:loadpoint(Point1, 'xyz_1_13.txt', 1),
read_files:loadpoint(Point2, 'xyz_1_14.txt', 1),
read_files:loadpoint(Point3, 'xyz_1_15.txt', 1),
validation:validatefinger(Point1,Point2,Point3),
write(Value).

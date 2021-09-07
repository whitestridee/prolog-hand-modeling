:-use_module(read_files),
use_module(helper).
mainfile:-
helper:loadpoint(Lines, 'points_data_with_dots/xyz_1_5.txt', 1),
helper:getfirstel(Lines,Value),
write(Value).

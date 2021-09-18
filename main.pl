:-use_module(read_files),
use_module(helper),
use_module(validation).

%Vyzyvaem etu fignyu
mainfile(Interval, Time):-
%Tut vstavlyaem svoyu papktu s proektom
working_directory(_, "C:/Users/green/Documents/GitHub/prolog-hand-modeling"),
% validation:validatefingerswithpoints(Point1, Point2, Point3, Point4,
% Point5, Point6, Point7, Point8, Point9, Point10, Point11, Point12,
% Point13, Point14, Point15, Point16, Point17, Point18, Point19, Point20,
% Point21, Point22, Point23, Point24, Point25, Point26, Point27, Point28,
% Point29, Point30, Point31, Point32, Point33, Point34, Point35, Point36,
% Point37, Point38, Point39, Point40, Point41, Point42),

read_files:tryloadpoint(Point1, 1, 3, 1),
read_files:tryloadpoint(Point2, 1, 5, 1),
read_files:tryloadpoint(Point3, 1, 7, 1),
validation:validatefinger(Point1,Point2,Point3),
validation:validateallfingers(Interval,Time).

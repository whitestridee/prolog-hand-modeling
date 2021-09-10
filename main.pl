:-use_module(read_files),
use_module(helper),
use_module(validation).

%Vyzyvaem etu fignyu
mainfile(Interval, Time):-
%Tut vstavlyaem svoyu papktu s proektom
working_directory(_, "C:/Users/green/Documents/GitHub/prolog-hand-modeling"),
read_files:tryloadpoint(Point1, 1, 3, 1),
read_files:tryloadpoint(Point2, 1, 5, 1),
read_files:tryloadpoint(Point3, 1, 7, 1),
validation:validatefinger(Point1,Point2,Point3),
validation:validateallfingers(Interval,Time).

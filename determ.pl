:- module(determ,[determallfingers/3,get_point/4,det_coords/10,determinefinger/5]).
 :- use_module(read_files),
   use_module(validation),
   use_module(helper).
   
determallfingers(Interval, Time, PointList):-
	read_files:tryloadpoint(Point1, Interval, 1, Time),
	read_files:tryloadpoint(Point2, Interval, 2, Time),
	read_files:tryloadpoint(Point3, Interval, 3, Time),
	read_files:tryloadpoint(Point4, Interval, 4, Time),
	read_files:tryloadpoint(Point5, Interval, 5, Time),
	read_files:tryloadpoint(Point6, Interval, 6, Time),
	read_files:tryloadpoint(Point7, Interval, 7, Time),
	read_files:tryloadpoint(Point8, Interval, 8, Time),
	read_files:tryloadpoint(Point9, Interval, 9, Time),
	read_files:tryloadpoint(Point10, Interval, 10, Time),
	read_files:tryloadpoint(Point11, Interval, 11, Time),
	read_files:tryloadpoint(Point12, Interval, 12, Time),
	read_files:tryloadpoint(Point13, Interval, 13, Time),
	read_files:tryloadpoint(Point14, Interval, 14, Time),
	read_files:tryloadpoint(Point15, Interval, 15, Time),
	read_files:tryloadpoint(Point16, Interval, 16, Time),
	read_files:tryloadpoint(Point17, Interval, 17, Time),
	read_files:tryloadpoint(Point18, Interval, 18, Time),
	read_files:tryloadpoint(Point19, Interval, 19, Time),
	read_files:tryloadpoint(Point20, Interval, 20, Time),
	read_files:tryloadpoint(Point21, Interval, 21, Time),
	read_files:tryloadpoint(Point22, Interval, 22, Time),
	read_files:tryloadpoint(Point23, Interval, 23, Time),
	read_files:tryloadpoint(Point24, Interval, 24, Time),
	read_files:tryloadpoint(Point25, Interval, 25, Time),
	read_files:tryloadpoint(Point26, Interval, 26, Time),
	read_files:tryloadpoint(Point27, Interval, 27, Time),
	read_files:tryloadpoint(Point28, Interval, 28, Time),
	read_files:tryloadpoint(Point29, Interval, 29, Time),
	read_files:tryloadpoint(Point30, Interval, 30, Time),
	read_files:tryloadpoint(Point31, Interval, 31, Time),
	read_files:tryloadpoint(Point32, Interval, 32, Time),
	read_files:tryloadpoint(Point33, Interval, 33, Time),
	read_files:tryloadpoint(Point34, Interval, 34, Time),
	read_files:tryloadpoint(Point35, Interval, 35, Time),
	read_files:tryloadpoint(Point36, Interval, 36, Time),
	read_files:tryloadpoint(Point37, Interval, 37, Time),
	read_files:tryloadpoint(Point38, Interval, 38, Time),
	read_files:tryloadpoint(Point39, Interval, 39, Time),
	read_files:tryloadpoint(Point40, Interval, 40, Time),
	read_files:tryloadpoint(Point41, Interval, 41, Time),
	read_files:tryloadpoint(Point42, Interval, 42, Time),

	PList=[],
	determinefinger(Point1, Point2, Point3, bpabc, PList),
	determinefinger(Point4, Point5, Point6, oabc, PList),
	determinefinger(Point5, Point6, Point7, obcd, PList),
	determinefinger(Point8, Point9, Point10, oabc, PList),
	determinefinger(Point9, Point10, Point11, obcd, PList),
	determinefinger(Point12, Point13, Point14, oabc, PList),
	determinefinger(Point13, Point14, Point15, obcd, PList),
	determinefinger(Point16, Point17, Point18, oabc, PList),
	determinefinger(Point17, Point18, Point19, obcd, PList),

	determinefinger(Point22, Point23, Point24, bpabc, PList),
	determinefinger(Point25, Point26, Point27, oabc, PList),
	determinefinger(Point26, Point27, Point28, obcd, PList),
	determinefinger(Point29, Point30, Point31, oabc, PList),
	determinefinger(Point30, Point31, Point32, obcd, PList),
	determinefinger(Point33, Point34, Point35, oabc, PList),
	determinefinger(Point34, Point35, Point36, obcd, PList),
	determinefinger(Point37, Point38, Point39, oabc, PList),
	determinefinger(Point38, Point39, Point40, obcd, PList),
	PointList=PList.
	
	
get_point(Point, X, Y, Z) :-
	validation:checkforstr(Point),
	helper:getfirstel(Point, X),
	helper:getnthel(Point, Y, 1),
	helper:getnthel(Point, Z, 2).
	

det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	validation:checkugol(Type, Ugol),
	helper:getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Ugol).
	
	
determinefinger(Point1, Point2, Point3, Type, PointList) :-
	get_point(Point1, X1, Y1, Z1),
	get_point(Point2, X2, Y2, Z2),
	get_point(Point3, X3, Y3, Z3),
	det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	add_to_list(PointList, [[X1,Y1],[X2,Y2],[X3,Y3]], PointList).
	
determinefinger(Point1, Point2, Point3, Type, PointList) :-
	not(get_point(Point1, _, _, _)),
	get_point(Point2, X2, Y2, Z2),
	get_point(Point3, X3, Y3, Z3),
	det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	add_to_list(PointList, [[X1,Y1],[X2,Y2],[X3,Y3]], PointList).
	
determinefinger(Point1, Point2, Point3, Type, PointList) :-
	not(get_point(Point2, _, _, _)),
	get_point(Point1, X1, Y1, Z1),
	get_point(Point3, X3, Y3, Z3),
	det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	add_to_list(PointList, [[X1,Y1],[X2,Y2],[X3,Y3]], PointList).
	
determinefinger(Point1, Point2, Point3, Type, PointList) :-
	not(get_point(Point3, _, _, _)),
	get_point(Point2, X2, Y2, Z2),
	get_point(Point1, X1, Y1, Z1),
	det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	add_to_list(PointList, [[X1,Y1],[X2,Y2],[X3,Y3]], PointList).
	
determinefinger(Point1, Point2, Point3, Type, PointList) :-
	not(get_point(Point1, _, _, _)),
	not(get_point(Point2, _, _, _)),
	get_point(Point3, X3, Y3, Z3),
	det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	add_to_list(PointList, [[X1,Y1],[X2,Y2],[X3,Y3]], PointList).
	
determinefinger(Point1, Point2, Point3, Type, PointList) :-
	not(get_point(Point1, _, _, _)),
	not(get_point(Point3, _, _, _)),
	get_point(Point2, X2, Y2, Z2),
	det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	add_to_list(PointList, [[X1,Y1],[X2,Y2],[X3,Y3]], PointList).
	
determinefinger(Point1, Point2, Point3, Type, PointList) :-
	not(get_point(Point2, _, _, _)),
	not(get_point(Point3, _, _, _)),
	get_point(Point1, X1, Y1, Z1),
	det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	add_to_list(PointList, [[X1,Y1],[X2,Y2],[X3,Y3]], PointList).
	
determinefinger(Point1, Point2, Point3, Type, PointList) :-
	not(get_point(Point1, _, _, _)),
	not(get_point(Point2, _, _, _)),
	not(get_point(Point3, _, _, _)),
	det_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	add_to_list(PointList, [[X1,Y1],[X2,Y2],[X3,Y3]], PointList).
	
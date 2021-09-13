:- module(determ,[
	determallfingers/3, get_coords/4, maximize_coord/2, det_finger/7
]).
	
:- use_module(read_files),
   use_module(validation),
   use_module(helper),
   use_module(determ_helper),
   use_module(library(clpr)),
   use_module(library(lists)).
   
%determallfingers - call this to determine missing points
%gives list of all points at given interval and time
%including missing and already good ones
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

	det_finger(Point1, Point2, Point3, bpabc, Coords1, Coords2, Coords3),
	det_finger(Point4, Point5, Point6, oabc, Coords4, Coords5, Coords6),
	det_finger(Point5, Point6, Point7, obcd, Coords5, Coords6, Coords7),
	det_finger(Point8, Point9, Point10, oabc, Coords8, Coords9, Coords10),
	det_finger(Point9, Point10, Point11, obcd, Coords9, Coords10, Coords11),
	det_finger(Point12, Point13, Point14, oabc, Coords12, Coords13, Coords14),
	det_finger(Point13, Point14, Point15, obcd, Coords13, Coords14, Coords15),
	det_finger(Point16, Point17, Point18, oabc, Coords16, Coords17, Coords18),
	det_finger(Point17, Point18, Point19, obcd, Coords17, Coords18, Coords19),
	
	det_finger(Point2, Point3, Point21, bpprived, Coords2, Coords3, Coords21),
	det_finger(Point4, Point7, Point21, oprived, Coords4, Coords7, Coords21),
	det_finger(Point8, Point11, Point21, oprived, Coords8, Coords11, Coords21),
	det_finger(Point12, Point15, Point21, oprived, Coords12, Coords15, Coords21),
	det_finger(Point16, Point19, Point21, oprived, Coords16, Coords19, Coords21),
	det_finger(Point1, Point2, Point3, bppsgib1, Coords1, Coords2, Coords3),
	det_finger(Point2, Point3, Point21, bppsgib2, Coords2, Coords3, Coords21),
	det_finger(Point5, Point4, Point6, o2sgib1, Coords5, Coords4, Coords6),
	det_finger(Point6, Point5, Point7, o2sgib2, Coords6, Coords5, Coords7),
	det_finger(Point7, Point6, Point21, o2sgib3, Coords7, Coords6, Coords21),
	det_finger(Point9, Point8, Point10, o3sgib1, Coords9, Coords8, Coords10),
	det_finger(Point10, Point9, Point11, o3sgib2, Coords10, Coords9, Coords11),
	det_finger(Point11, Point10, Point21, o3sgib3, Coords11, Coords10, Coords21),
	det_finger(Point13, Point12, Point14, o4sgib1, Coords13, Coords12, Coords14),
	det_finger(Point14, Point13, Point15, o4sgib2, Coords14, Coords13, Coords15),
	det_finger(Point15, Point14, Point21, o4sgib3, Coords15, Coords14, Coords21),
	det_finger(Point17, Point16, Point18, o5sgib1, Coords17, Coords16, Coords18),
	det_finger(Point18, Point17, Point19, o5sgib2, Coords18, Coords17, Coords19),
	det_finger(Point19, Point18, Point21, o5sgib3, Coords19, Coords18, Coords21),

	det_finger(Point22, Point23, Point24, bpabc, Coords22, Coords23, Coords24),
	det_finger(Point25, Point26, Point27, oabc, Coords25, Coords26, Coords27),
	det_finger(Point26, Point27, Point28, obcd, Coords26, Coords27, Coords28),
	det_finger(Point29, Point30, Point31, oabc, Coords29, Coords30, Coords31),
	det_finger(Point30, Point31, Point32, obcd, Coords30, Coords31, Coords32),
	det_finger(Point33, Point34, Point35, oabc, Coords33, Coords34, Coords35),
	det_finger(Point34, Point35, Point36, obcd, Coords34, Coords35, Coords36),
	det_finger(Point37, Point38, Point39, oabc, Coords37, Coords38, Coords39),
	det_finger(Point38, Point39, Point40, obcd, Coords38, Coords39, Coords40),
	convlist(maximize_coord, [
		Coords1, Coords2, Coords3, Coords4, Coords5, Coords6, Coords7,
		Coords8, Coords9, Coords10, Coords11, Coords12, Coords13, Coords14,
		Coords15, Coords16, Coords17, Coords18, Coords19, Coords20, Coords21,
		Coords22, Coords23, Coords24, Coords25, Coords26, Coords27, Coords28,
		Coords29, Coords30, Coords31, Coords32, Coords33, Coords34, Coords35,
		Coords36, Coords37, Coords38, Coords39, Coords40, Coords41, Coords42
	], PointList).

%maximize coords variables after determination	
maximize_coord(Coords, [NewX, NewY, NewZ]) :-
	get_coords(Coords, NewX, NewY, NewZ),
	maximize(NewX), maximize(NewY), maximize(NewZ).

%det_finger - entrance func to set X,Y,Z of missing points
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	get_coords(Point1, X1, Y1, Z1),
	get_coords(Point2, X2, Y2, Z2),
	get_coords(Point3, X3, Y3, Z3).


%get_coords - set X,Y,Z if Point exists
get_coords(Point, X, Y, Z) :-
	validation:checkforstr(Point),
	helper:getfirstel(Point, X),
	helper:getnthel(Point, Y, 1),
	helper:getnthel(Point, Z, 2).

%det_finger - set X,Y,Z of missing points based on point connections
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	get_coords(Point1, X1, Y1, Z1),
	get_coords(Point2, X2, Y2, Z2),
	get_coords(Point3, X3, Y3, Z3).
	
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point1, _, _, _)),
	get_coords(Point2, X2, Y2, Z2),
	get_coords(Point3, X3, Y3, Z3),
	determ_helper:det_coords(1, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point2, _, _, _)),
	get_coords(Point1, X1, Y1, Z1),
	get_coords(Point3, X3, Y3, Z3),
	determ_helper:det_coords(2, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point3, _, _, _)),
	get_coords(Point2, X2, Y2, Z2),
	get_coords(Point1, X1, Y1, Z1),
	determ_helper:det_coords(3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point1, _, _, _)),
	not(get_coords(Point2, _, _, _)),
	get_coords(Point3, X3, Y3, Z3),
	determ_helper:det_coords(12, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point1, _, _, _)),
	not(get_coords(Point3, _, _, _)),
	get_coords(Point2, X2, Y2, Z2),
	determ_helper:det_coords(13, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point2, _, _, _)),
	not(get_coords(Point3, _, _, _)),
	get_coords(Point1, X1, Y1, Z1),
	determ_helper:det_coords(23, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
det_finger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point1, _, _, _)),
	not(get_coords(Point2, _, _, _)),
	not(get_coords(Point3, _, _, _)),
	determ_helper:det_coords(123, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
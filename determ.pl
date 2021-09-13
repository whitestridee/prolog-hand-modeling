:- module(determ,[determallfingers/3,get_coords/4,det_angle/2,
	point_constraint/3,coord_constraint/1,determ_coords/10,
	det_coords/11,determinefinger/7,determinefinger/7]).
 :- use_module(read_files),
   use_module(validation),
   use_module(helper),
   use_module(library(clpfd)),
   use_module(library(lists)).
   
%determallfingers - call this to determine missing points
%gives list of all points at given interval and time
%including missing and already good ones
determallfingers(Interval, Time, [
		Coords1, Coords2, Coords3, Coords4, Coords5, Coords6, Coords7,
		Coords8, Coords9, Coords10, Coords11, Coords12, Coords13, Coords14,
		Coords15, Coords16, Coords17, Coords18, Coords19, Coords20, Coords21,
		Coords22, Coords23, Coords24, Coords25, Coords26, Coords27, Coords28,
		Coords29, Coords30, Coords31, Coords32, Coords33, Coords34, Coords35,
		Coords36, Coords37, Coords38, Coords39, Coords40, Coords41, Coords42
	]):-
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

	determinefinger(Point1, Point2, Point3, bpabc, Coords1, Coords2, Coords3),
	determinefinger(Point4, Point5, Point6, oabc, Coords4, Coords5, Coords6),
	determinefinger(Point5, Point6, Point7, obcd, Coords5, Coords6, Coords7),
	determinefinger(Point8, Point9, Point10, oabc, Coords8, Coords9, Coords10),
	determinefinger(Point9, Point10, Point11, obcd, Coords9, Coords10, Coords11),
	determinefinger(Point12, Point13, Point14, oabc, Coords12, Coords13, Coords14),
	determinefinger(Point13, Point14, Point15, obcd, Coords13, Coords14, Coords15),
	determinefinger(Point16, Point17, Point18, oabc, Coords16, Coords17, Coords18),
	determinefinger(Point17, Point18, Point19, obcd, Coords17, Coords18, Coords19),
	
	determinefinger(Point2, Point3, Point21, bpprived, Coords2, Coords3, Coords21),
	determinefinger(Point4, Point7, Point21, oprived, Coords4, Coords7, Coords21),
	determinefinger(Point8, Point11, Point21, oprived, Coords8, Coords11, Coords21),
	determinefinger(Point12, Point15, Point21, oprived, Coords12, Coords15, Coords21),
	determinefinger(Point16, Point19, Point21, oprived, Coords16, Coords19, Coords21),
	determinefinger(Point1, Point2, Point3, bppsgib1, Coords1, Coords2, Coords3),
	determinefinger(Point2, Point3, Point21, bppsgib2, Coords2, Coords3, Coords21),
	determinefinger(Point5, Point4, Point6, o2sgib1, Coords5, Coords4, Coords6),
	determinefinger(Point6, Point5, Point7, o2sgib2, Coords6, Coords5, Coords7),
	determinefinger(Point7, Point6, Point21, o2sgib3, Coords7, Coords6, Coords21),
	determinefinger(Point9, Point8, Point10, o3sgib1, Coords9, Coords8, Coords10),
	determinefinger(Point10, Point9, Point11, o3sgib2, Coords10, Coords9, Coords11),
	determinefinger(Point11, Point10, Point21, o3sgib3, Coords11, Coords10, Coords21),
	determinefinger(Point13, Point12, Point14, o4sgib1, Coords13, Coords12, Coords14),
	determinefinger(Point14, Point13, Point15, o4sgib2, Coords14, Coords13, Coords15),
	determinefinger(Point15, Point14, Point21, o4sgib3, Coords15, Coords14, Coords21),
	determinefinger(Point17, Point16, Point18, o5sgib1, Coords17, Coords16, Coords18),
	determinefinger(Point18, Point17, Point19, o5sgib2, Coords18, Coords17, Coords19),
	determinefinger(Point19, Point18, Point21, o5sgib3, Coords19, Coords18, Coords21),

	determinefinger(Point22, Point23, Point24, bpabc, Coords22, Coords23, Coords24),
	determinefinger(Point25, Point26, Point27, oabc, Coords25, Coords26, Coords27),
	determinefinger(Point26, Point27, Point28, obcd, Coords26, Coords27, Coords28),
	determinefinger(Point29, Point30, Point31, oabc, Coords29, Coords30, Coords31),
	determinefinger(Point30, Point31, Point32, obcd, Coords30, Coords31, Coords32),
	determinefinger(Point33, Point34, Point35, oabc, Coords33, Coords34, Coords35),
	determinefinger(Point34, Point35, Point36, obcd, Coords34, Coords35, Coords36),
	determinefinger(Point37, Point38, Point39, oabc, Coords37, Coords38, Coords39),
	determinefinger(Point38, Point39, Point40, obcd, Coords38, Coords39, Coords40).

%get_coords - set X,Y,Z if Point exists
get_coords(Point, X, Y, Z) :-
	validation:checkforstr(Point),
	helper:getfirstel(Point, X),
	helper:getnthel(Point, Y, 1),
	helper:getnthel(Point, Z, 2).
	
%det_angle - constraints for angle based on finger type
det_angle(bpabc, Angle):- Angle #=< 80, Angle #>= -80.
det_angle(bpbcd, Angle):- Angle #=< 50, Angle #>= -50.
det_angle(bpcde, Angle):- Angle #=< 90, Angle #>= -90.
det_angle(oabc, Angle):- Angle #=< 80, Angle #>= -80.
det_angle(obcd, Angle):- Angle #=< 100, Angle #>= -100.
det_angle(ocde, Angle):- Angle #=< 90, Angle #>= -90.
det_angle(between, Angle):- Angle #=< 30, Angle #>= -30.

det_angle(bpprived, Angle):- Angle #=< 50, Angle #>= -50.
det_angle(oprived, Angle):- Angle #=< 60, Angle #>= -60.
det_angle(bppsgib1, Angle):- Angle #=< 50, Angle #>= -50.
det_angle(bppsgib2, Angle):- Angle #=< 80, Angle #>= -100.

det_angle(o2sgib1, Angle):- Angle #=< 90, Angle #>= -120.
det_angle(o2sgib2, Angle):- Angle #=< 100, Angle #>= -100.
det_angle(o2sgib3, Angle):- Angle #=< 100, Angle #>= -100.

det_angle(o3sgib1, Angle):- Angle #=< 90, Angle #>= -120.
det_angle(o3sgib2, Angle):- Angle #=< 100, Angle #>= -100.
det_angle(o3sgib3, Angle):- Angle #=< 80, Angle #>= -80.

det_angle(o4sgib1, Angle):- Angle #=< 90, Angle #>= -120.
det_angle(o4sgib2, Angle):- Angle #=< 100, Angle #>= -100.
det_angle(o4sgib3, Angle):- Angle #=< 80, Angle #>= -80.

det_angle(o5sgib1, Angle):- Angle #=< 180, Angle #>= -180.
det_angle(o5sgib2, Angle):- Angle #=< 180, Angle #>= -180.
det_angle(o5sgib3, Angle):- Angle #=< 180, Angle #>= -180.

det_angleXY(bpprived, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(bpprived, UgolX).
det_angleXY(oprived, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(oprived, UgolX).
det_angleXY(bppsgib1, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolY(X1, Z1, X2, Z2, X3, Z3, UgolY), det_angle(bppsgib1, UgolY).
det_angleXY(bppsgib2, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolY(X1, Z1, X2, Z2, X3, Z3, UgolY), det_angle(bppsgib2, UgolY).
	
det_angleXY(o2sgib1, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o2sgib1, UgolX).
det_angleXY(o2sgib2, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o2sgib2, UgolX).
det_angleXY(o2sgib3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o2sgib3, UgolX).
	
det_angleXY(o3sgib1, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o3sgib1, UgolX).
det_angleXY(o3sgib2, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o3sgib2, UgolX).
det_angleXY(o3sgib3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o3sgib3, UgolX).
	
det_angleXY(o4sgib1, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o4sgib1, UgolX).
det_angleXY(o4sgib2, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o4sgib2, UgolX).
det_angleXY(o4sgib3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
	helper:getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), det_angle(o4sgib3, UgolX).
	
determ_coords(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Angle):-
	helper:getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Angle).

%dummy to test points list construction
coord_constraint(X) :- 
	X #>= -2000, X #=<2000.

%dummy to test points list construction
point_constraint(X, Y, Z) :-
	coord_constraint(X),
	coord_constraint(Y),
	coord_constraint(Z).
	
%det_coords - determination of coordinates of missing points

det_coords(1, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angle(Type, Angle),
	point_constraint(X1,Y1,Z1),
	determ_coords(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,Angle).
	
det_coords(2, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angle(Type, Angle),
	point_constraint(X2,Y2,Z2),
	determ_coords(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,Angle).
	
det_coords(3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angle(Type, Angle),
	point_constraint(X3,Y3,Z3),
	determ_coords(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,Angle).
	
det_coords(12, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angle(Type, Angle),
	point_constraint(X1,Y1,Z1),
	point_constraint(X2,Y2,Z2),
	determ_coords(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,Angle).
	
det_coords(13, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angle(Type, Angle),
	point_constraint(X1,Y1,Z1),
	point_constraint(X3,Y3,Z3),
	determ_coords(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,Angle).
	
det_coords(23, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angle(Type, Angle),
	point_constraint(X2,Y2,Z2),
	point_constraint(X3,Y3,Z3),
	determ_coords(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,Angle).
	
det_coords(123, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angle(Type, Angle),
	point_constraint(X1,Y1,Z1),
	point_constraint(X2,Y2,Z2),
	point_constraint(X3,Y3,Z3),
	determ_coords(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,Angle).

%determinefinger - set X,Y,Z of missing points based on point connections
determinefinger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	get_coords(Point1, X1, Y1, Z1),
	get_coords(Point2, X2, Y2, Z2),
	get_coords(Point3, X3, Y3, Z3).
	
determinefinger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point1, _, _, _)),
	get_coords(Point2, X2, Y2, Z2),
	get_coords(Point3, X3, Y3, Z3),
	det_coords(1, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
determinefinger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point2, _, _, _)),
	get_coords(Point1, X1, Y1, Z1),
	get_coords(Point3, X3, Y3, Z3),
	det_coords(2, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
determinefinger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point3, _, _, _)),
	get_coords(Point2, X2, Y2, Z2),
	get_coords(Point1, X1, Y1, Z1),
	det_coords(3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
determinefinger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point1, _, _, _)),
	not(get_coords(Point2, _, _, _)),
	get_coords(Point3, X3, Y3, Z3),
	det_coords(12, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
determinefinger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point1, _, _, _)),
	not(get_coords(Point3, _, _, _)),
	get_coords(Point2, X2, Y2, Z2),
	det_coords(13, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
determinefinger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point2, _, _, _)),
	not(get_coords(Point3, _, _, _)),
	get_coords(Point1, X1, Y1, Z1),
	det_coords(23, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
determinefinger(Point1, Point2, Point3, Type,
	[X1,Y1,Z1], [X2,Y2,Z2], [X3,Y3,Z3]) :-
	not(get_coords(Point1, _, _, _)),
	not(get_coords(Point2, _, _, _)),
	not(get_coords(Point3, _, _, _)),
	det_coords(123, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type).
	
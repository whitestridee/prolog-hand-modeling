:- module(validation,[
	validate_all/44,
	validatefinger/3, validatefinger/4, validateallfingers/2,
	validatefingerXY/4, validateugolXY/10, validatefingerswithpoints/44]
).
:- use_module(read_files),
   use_module(write_files),
   use_module(hand),
   use_module(helper).

checkforstr(Point):-
   helper:getfirstel(Point, X),
   number(X).
   
%get_coords - set X,Y,Z if Point exists
get_coords(Point, X, Y, Z) :-
	checkforstr(Point),
	helper:getfirstel(Point, X),
	helper:getnthel(Point, Y, 1),
	helper:getnthel(Point, Z, 2).

%if all 3 points exist
get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	get_coords(Point1, X1, Y1, Z1),
	get_coords(Point2, X2, Y2, Z2),
	get_coords(Point3, X3, Y3, Z3).
	
	
validate_all(Working_Dir, Result,
	Point1, Point2, Point3, Point4, Point5, Point6, Point7,
	Point8, Point9, Point10, Point11, Point12, Point13, Point14,
	Point15, Point16, Point17, Point18, Point19, Point20, Point21,
	Point22, Point23, Point24, Point25, Point26, Point27, Point28,
	Point29, Point30, Point31, Point32, Point33, Point34, Point35,
	Point36, Point37, Point38, Point39, Point40, Point41, Point42
) :-
	working_directory(_, Working_Dir),
	open('points.txt', write, Stream),
	open('angles.txt', write, Stream2),
	close(Stream2),
	close(Stream),
	(	
		(
			validate_hand(
				hand:hand(
					finger(little, Point16, Point17, Point18, Point19),
					finger(ring, Point12, Point13, Point14, Point15),
					finger(middle, Point8, Point9, Point10, Point11),
					finger(index, Point4, Point5, Point6, Point7),
					finger(thumb, Point1, Point2, Point3),
					Point20, Point21
				)
			),
			validate_hand(
				hand:hand(
					finger(little, Point37, Point38, Point39, Point40),
					finger(ring, Point33, Point34, Point35, Point36),
					finger(middle, Point29, Point30, Point31, Point32),
					finger(index, Point25, Point26, Point27, Point28),
					finger(thumb, Point22, Point23, Point24),
					Point41, Point42
				)
			)
		)-> Result = "Ok"; Result = "Not"
	).


validate_hand(hand:hand(Finger5, Finger4, Finger3, Finger2, Finger1, P19, Wrist)):-
	validate_finger(Finger5, P19, Wrist),
	validate_finger(Finger4, P19, Wrist),
	validate_finger(Finger3, P19, Wrist),
	validate_finger(Finger2, P19, Wrist),
	validate_finger(Finger1, P19, Wrist).
	

validate_finger(finger(thumb, P1, P2, P3), P19, Wrist):-
	finger_motion_type(thumb, Abduction, Flex1, Flex2, _),
	validatefinger(P1, P2, P3, bpabc),
	validatefingerXY(Abduction, P3, P2, Wrist),
	validatefingerXY(Flex1, P1, P2, P3),
	validatefingerXY(Flex2, P1, P2, Wrist),
	validatefingerXY(bppz, P1, P2, P3).
	
	
validate_finger(finger(Finger, P1, P2, P3, P4), P19, Wrist):-
	not(Finger == thumb),
	finger_motion_type(Finger, Abduction, Flex1, Flex2, Flex3),
	validatefinger(P1, P2, P3, oabc),
	validatefinger(P2, P3, P4, obcd),
	validatefingerXY(Abduction, P4, P2, Wrist),
	validatefingerXY(Flex1, P2, P1, P3),
	validatefingerXY(Flex2, P4, P2, P3),
	validatefingerXY(Flex3, P4, P3, Wrist),
	validatefingerXY(bppz, P1, P2, P3).
	

validatefingerswithpoints(Working_Dir, Result, Point1, Point2, Point3, Point4, Point5, Point6, Point7, Point8, Point9, Point10, Point11, Point12, Point13, Point14, Point15, Point16, Point17, Point18, Point19, Point20, Point21, Point22, Point23, Point24, Point25, Point26, Point27, Point28, Point29, Point30, Point31, Point32, Point33, Point34, Point35, Point36, Point37, Point38, Point39, Point40, Point41, Point42):-
   working_directory(_, Working_Dir),
   open('points.txt', write, Stream),
   open('angles.txt', write, Stream2),
   close(Stream2),
   close(Stream),
   ((validatefinger(Point1, Point2, Point3, bpabc),
   validatefinger(Point4, Point5, Point6, oabc),
   validatefinger(Point5, Point6, Point7, obcd),
   validatefinger(Point8, Point9, Point10, oabc),
   validatefinger(Point9, Point10, Point11, obcd),
   validatefinger(Point12, Point13, Point14, oabc),
   validatefinger(Point13, Point14, Point15, obcd),
   validatefinger(Point16, Point17, Point18, oabc),
   validatefinger(Point17, Point18, Point19, obcd),

   validatefingerXY(bpprived, Point3, Point2, Point21),
   validatefingerXY(oprived, Point7, Point4, Point21),
   validatefingerXY(oprived, Point11, Point8, Point21),
   validatefingerXY(oprived, Point15, Point12, Point21),
   validatefingerXY(oprived, Point19, Point16, Point21),
   validatefingerXY(bppsgib1, Point1, Point2, Point3),
   validatefingerXY(bppsgib2, Point1, Point2, Point21),
   validatefingerXY(o2sgib1, Point5, Point4, Point6),
   validatefingerXY(o2sgib2, Point6, Point5, Point7),
   validatefingerXY(o2sgib3, Point7, Point6, Point21),
   validatefingerXY(o3sgib1, Point9, Point8, Point10),
   validatefingerXY(o3sgib2, Point10, Point9, Point11),
   validatefingerXY(o3sgib3, Point11, Point10, Point21),
   validatefingerXY(o4sgib1, Point13, Point12, Point14),
   validatefingerXY(o4sgib2, Point14, Point13, Point15),
   validatefingerXY(o4sgib3, Point15, Point14, Point21),
   validatefingerXY(o5sgib1, Point17, Point16, Point18),
   validatefingerXY(o5sgib2, Point18, Point17, Point19),
   validatefingerXY(o5sgib3, Point19, Point18, Point21),
   validatefingerXY(bppz, Point1, Point2, Point3),
   validatefingerXY(bppz, Point4, Point5, Point6),
   validatefingerXY(bppz, Point8, Point9, Point10),
   validatefingerXY(bppz, Point12, Point13, Point14),
   validatefingerXY(bppz, Point16, Point17, Point18),

   validatefinger(Point22, Point23, Point24),
   validatefinger(Point25, Point26, Point27),
   validatefinger(Point26, Point27, Point28),
   validatefinger(Point29, Point30, Point31),
   validatefinger(Point30, Point31, Point32),
   validatefinger(Point33, Point34, Point35),
   validatefinger(Point34, Point35, Point36),
   validatefinger(Point37, Point38, Point39),
   validatefinger(Point38, Point39, Point40),

   validatefinger(Point22, Point23, Point24, bpabc),
   validatefinger(Point25, Point26, Point27, oabc),
   validatefinger(Point26, Point27, Point28, obcd),
   validatefinger(Point29, Point30, Point31, oabc),
   validatefinger(Point30, Point31, Point32, obcd),
   validatefinger(Point33, Point34, Point35, oabc),
   validatefinger(Point34, Point35, Point36, obcd),
   validatefinger(Point37, Point38, Point39, oabc),
   validatefinger(Point38, Point39, Point40, obcd),

   validatefingerXY(bpprived, Point24, Point23, Point42),
   validatefingerXY(oprived, Point28, Point25, Point42),
   validatefingerXY(oprived, Point32, Point29, Point42),
   validatefingerXY(oprived, Point36, Point33, Point42),
   validatefingerXY(oprived, Point40, Point37, Point42),
   validatefingerXY(bppsgib1, Point22, Point23, Point24),
   validatefingerXY(bppsgib2, Point22, Point23, Point42),
   validatefingerXY(o2sgib1, Point27, Point25, Point27),
   validatefingerXY(o2sgib2, Point27, Point26, Point28),
   validatefingerXY(o2sgib3, Point28, Point27, Point42),
   validatefingerXY(o3sgib1, Point30, Point29, Point31),
   validatefingerXY(o3sgib2, Point31, Point30, Point32),
   validatefingerXY(o3sgib3, Point32, Point31, Point42),
   validatefingerXY(o4sgib1, Point34, Point33, Point14),
   validatefingerXY(o4sgib2, Point35, Point34, Point36),
   validatefingerXY(o4sgib3, Point36, Point35, Point42),
   validatefingerXY(o5sgib1, Point38, Point37, Point39),
   validatefingerXY(o5sgib2, Point39, Point38, Point40),
   validatefingerXY(o5sgib3, Point40, Point39, Point42),
   validatefingerXY(bppz, Point22, Point23, Point24),
   validatefingerXY(bppz, Point25, Point26, Point27),
   validatefingerXY(bppz, Point29, Point30, Point31),
   validatefingerXY(bppz, Point33, Point34, Point35),
   validatefingerXY(bppz, Point37, Point38, Point39))->
   Result = "Ok";
   Result = "Not").

validateallfingers(Interval, Time):-

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

   validatefinger(Point1, Point2, Point3, bpabc),
   validatefinger(Point4, Point5, Point6, oabc),
   validatefinger(Point5, Point6, Point7, obcd),
   validatefinger(Point8, Point9, Point10, oabc),
   validatefinger(Point9, Point10, Point11, obcd),
   validatefinger(Point12, Point13, Point14, oabc),
   validatefinger(Point13, Point14, Point15, obcd),
   validatefinger(Point16, Point17, Point18, oabc),
   validatefinger(Point17, Point18, Point19, obcd),

   validatefingerXY(bpprived, Point2, Point3, Point21),
   validatefingerXY(oprived, Point4, Point7, Point21),
   validatefingerXY(oprived, Point8, Point11, Point21),
   validatefingerXY(oprived, Point12, Point15, Point21),
   validatefingerXY(oprived, Point16, Point19, Point21),
   validatefingerXY(bppsgib1, Point1, Point2, Point3),
   validatefingerXY(bppsgib2, Point2, Point3, Point21),
   validatefingerXY(o2sgib1, Point5, Point4, Point6),
   validatefingerXY(o2sgib2, Point6, Point5, Point7),
   validatefingerXY(o2sgib3, Point7, Point6, Point21),
   validatefingerXY(o3sgib1, Point9, Point8, Point10),
   validatefingerXY(o3sgib2, Point10, Point9, Point11),
   validatefingerXY(o3sgib3, Point11, Point10, Point21),
   validatefingerXY(o4sgib1, Point13, Point12, Point14),
   validatefingerXY(o4sgib2, Point14, Point13, Point15),
   validatefingerXY(o4sgib3, Point15, Point14, Point21),
   validatefingerXY(o5sgib1, Point17, Point16, Point18),
   validatefingerXY(o5sgib2, Point18, Point17, Point19),
   validatefingerXY(o5sgib3, Point19, Point18, Point21),

   validatefinger(Point22, Point23, Point24),
   validatefinger(Point25, Point26, Point27),
   validatefinger(Point26, Point27, Point28),
   validatefinger(Point29, Point30, Point31),
   validatefinger(Point30, Point31, Point32),
   validatefinger(Point33, Point34, Point35),
   validatefinger(Point34, Point35, Point36),
   validatefinger(Point37, Point38, Point39),
   validatefinger(Point38, Point39, Point40).


write_angle(Type, Angle):-
	write(Type), write(" angle is "), write(Angle), nl.
	
validateugolXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	hand:angle_det_type(Type, x),
	getugolX(Y1, Z1, Y2, Z2, Y3, Z3, AngleX),
	write_angle(Type, Angle),
	hand:valid_angle(Type, AngleX).

validateugolXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	hand:angle_det_type(Type, y),
	getugolY(X1, Z1, X2, Z2, X3, Z3, AngleY),
	write_angle(Type, Angle),
	hand:valid_angle(Type, AngleY).
	
validateugolXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	hand:angle_det_type(Type, z),
	getugolZ(X1, Y1, X2, Y2, X3, Y3, AngleZ),
	write_angle(Type, Angle),
	hand:valid_angle(Type, AngleZ).
	
validateugolXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	not(hand:angle_det_type(Type, _)),
	getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Angle),
	write_angle(Type, Angle),
	hand:valid_angle(Type, Angle).
	

validate_angle(Type, Ugol, Point1, Point2, Point3) :-
	write_files:write_angle(Ugol),
	checkugol(Type, Ugol),
	write_files:write_angle_is_valid(Type).

validate_angle(Type, Ugol, Point1, Point2, Point3) :-
	write_files:write_angle(Ugol),
	not(checkugol(Type, Ugol)),
	write_files:write_invalid_points(Point1, Point2, Point3).


% validatefinger(Point1, Point2, Point3)

validatefinger(Point1, Point2, Point3):-
	not(get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3)),
	write_files:write_invalid_data().

validatefinger(Point1, Point2, Point3):-
	get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	helper:getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Ugol),
	validate_angle(Type, Ugol, Point1, Point2, Point3).


% validatefinger(Point1, Point2, Point3, Type)

validatefinger(Point1, Point2, Point3, Type):-
	not(get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3)),
	write_files:write_invalid_data().

validatefinger(Point1, Point2, Point3, Type):-
	get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	helper:getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Ugol),
	validate_angle(Type, Ugol, Point1, Point2, Point3).

	
% validatefingerXY
	
validatefingerXY(Type, Point1, Point2, Point3):-
	not(get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3)),
	write_files:write_invalid_data().

validatefingerXY(Type, Point1, Point2, Point3):-
	get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	validateugolXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	write_files:write_angle_is_valid(Type).
	
validatefingerXY(Type, Point1, Point2, Point3):-
	get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	not(validateugolXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3)),
	write_files:write_invalid_points(Point1, Point2, Point3).


checkugol(Type, Angle) :-
	write_files:write_angle(Angle),
	hand:valid_angle(Type, Angle).

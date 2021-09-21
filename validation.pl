:- module(validation,[validate_all/44]).
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
	validate_points(bpabc, P1, P2, P3),
	validate_points(Abduction, P3, P2, Wrist),
	validate_points(Flex1, P1, P2, P3),
	validate_points(Flex2, P1, P2, Wrist),
	validate_points(bppz, P1, P2, P3).
	
	
validate_finger(finger(Finger, P1, P2, P3, P4), P19, Wrist):-
	not(Finger == thumb),
	finger_motion_type(Finger, Abduction, Flex1, Flex2, Flex3),
	validate_points(oabc, P1, P2, P3),
	validate_points(obcd, P2, P3, P4),
	validate_points(Abduction, P4, P2, Wrist),
	validate_points(Flex1, P2, P1, P3),
	validate_points(Flex2, P4, P2, P3),
	validate_points(Flex3, P4, P3, Wrist),
	validate_points(bppz, P1, P2, P3).


% validate_angle
	
validate_angle(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	hand:angle_det_type(Type, x),
	getugolX(Y1, Z1, Y2, Z2, Y3, Z3, AngleX),
	write_files:write_angle(Type, Angle),
	hand:valid_angle(Type, AngleX).

validate_angle(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	hand:angle_det_type(Type, y),
	getugolY(X1, Z1, X2, Z2, X3, Z3, AngleY),
	write_files:write_angle(Type, Angle),
	hand:valid_angle(Type, AngleY).
	
validate_angle(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	hand:angle_det_type(Type, z),
	getugolZ(X1, Y1, X2, Y2, X3, Y3, AngleZ),
	write_files:write_angle(Type, Angle),
	hand:valid_angle(Type, AngleZ).
	
validate_angle(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	not(hand:angle_det_type(Type, _)),
	getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Angle),
	write_files:write_angle(Type, Angle),
	hand:valid_angle(Type, Angle).

	
% validate_points
	
validate_points(Type, Point1, Point2, Point3):-
	not(get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3)),
	write_files:write_invalid_data().

validate_points(Type, Point1, Point2, Point3):-
	get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	validate_angle(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	write_files:write_angle_is_valid(Type).
	
validate_points(Type, Point1, Point2, Point3):-
	get_coords(Point1, Point2, Point3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	not(validate_angle(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3)),
	write_files:write_invalid_points(Point1, Point2, Point3).

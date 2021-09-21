:- module(validation,[validate_all/44]).
:- use_module(write_files),
   use_module(hand),
   use_module(angle).

check_coords([X, Y, Z]):- number(X), number(Y), number(Z).

check_3coords([X1, Y1, Z1], [X2, Y2, Z2], [X3, Y3, Z3]) :-
	check_coords([X1, Y1, Z1]),
	check_coords([X2, Y2, Z2]),
	check_coords([X3, Y3, Z3]).
	
	
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
					finger(little, Point1, Point2, Point3, Point4),
					finger(ring, Point5, Point6, Point7, Point8),
					finger(middle, Point9, Point10, Point11, Point12),
					finger(index, Point13, Point14, Point15, Point16),
					finger(thumb, Point17, Point18, Point19),
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
	
validate_angle(Type, Point1, Point2, Point3) :-
	hand:angle_det_type(Type, Axis),
	get_angle(Axis, Point1, Point2, Point3, Angle),
	write_files:write_angle(Type, Angle),
	hand:valid_angle(Type, Angle).

	
% validate_points
	
validate_points(Type, [X1, Y1, Z1], [X2, Y2, Z2], [X3, Y3, Z3]):-
	not(check_3coords([X1, Y1, Z1], [X2, Y2, Z2], [X3, Y3, Z3])),
	write_files:write_invalid_data().

validate_points(Type, [X1, Y1, Z1], [X2, Y2, Z2], [X3, Y3, Z3]):-
	check_3coords([X1, Y1, Z1], [X2, Y2, Z2], [X3, Y3, Z3]),
	validate_angle(Type, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3)),
	write_files:write_angle_is_valid(Type).
	
validate_points(Type, [X1, Y1, Z1], [X2, Y2, Z2], [X3, Y3, Z3]):-
	check_3coords([X1, Y1, Z1], [X2, Y2, Z2], [X3, Y3, Z3]),
	not(validate_angle(Type, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3))),
	write_files:write_invalid_points([X1, Y1, Z1], [X2, Y2, Z2], [X3, Y3, Z3]).

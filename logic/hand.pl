:- module(hand,[
	point/3, point_list/2, hand/7,
	finger_motion_type/5, finger_angle/4,
	valid_angle/2, valid_cos_angle/2,
	angle_info/4, angle_det_type/2
]).

point(X, Y, Z).
point_list([X, Y, Z], point(X, Y, Z)).

hand(
	finger(little, P0, P1, P2, P3),		%5|finger V
	finger(ring, P4, P5, P6, P7),		%4|finger IV
	finger(middle, P8, P9, P10, P11),	%3|finger III
	finger(index, P12, P13, P14, P15),	%2|finger II
	finger(thumb, P16, P17, P18),		%1|finger I
	P19, P20							%base
).

%finger_motion_type(FingerType, AbductionType, Flexion1, Flexion2, Flexion3).
finger_motion_type(thumb, bpprived, bppsgib1, bppsgib2, bppsgib2).
finger_motion_type(index, oprived, o2sgib1, o2sgib2, o2sgib3).
finger_motion_type(middle, oprived, o3sgib1, o3sgib2, o3sgib3).
finger_motion_type(ring, oprived, o4sgib1, o4sgib2, o4sgib3).
finger_motion_type(little, oprived, o5sgib1, o5sgib2, o5sgib3).


%info about angle limits in degrees for fingers and axis
%angle_info(Finger, MinAngle, MaxAngle, Axis)

angle_info(bpabc, -80, 80, all).
angle_info(bpbcd, -50, 50, all).
angle_info(bpcde, -90, 90, all).
angle_info(oabc, -80, 80, all).
angle_info(obcd, -100, 100, all).
angle_info(ocde, -90, 90, all).
angle_info(between, -30, 30, all).

angle_info(bpprived, -50, 50, x).
angle_info(oprived, -60, 60, x).
angle_info(bppsgib1, -50, 50, y).
angle_info(bppsgib2, -100, 80, y).

angle_info(o2sgib1, -120, 90, x).
angle_info(o2sgib2, -100, 100, x).
angle_info(o2sgib3, -100, 100, x).

angle_info(o3sgib1, -120, 90, x).
angle_info(o3sgib2, -100, 100, x).
angle_info(o3sgib3, -80, 80, x).

angle_info(o4sgib1, -120, 90, x).
angle_info(o4sgib2, -100, 100, x).
angle_info(o4sgib3, -80, 80, x).

angle_info(o5sgib1, -120, 90, x).
angle_info(o5sgib2, -100, 100, x).
angle_info(o5sgib3, -80, 80, x).

angle_info(bppz, -100, 100, z).
angle_info(middle_abduction_deduction, -10, 10, y).


%valid_angle - check if angle is valid for finger
valid_angle(Type, Angle):-
	angle_info(Type, MinAngle, MaxAngle, _),
	MinAngle =< Angle, Angle =< MaxAngle.

%valid_cos_angle - check if angle cosinus is valid for finger
%valid_cos_angle(Type, Cos)
valid_cos_angle(Type, Cos):-
	angle_info(Type, MinAngle, MaxAngle, _),
	MinAngleCos is cos(MinAngle),
	MaxAngleCos is cos(MaxAngle),
	MinCos is min(MinAngleCos, MaxAngleCos),
	MaxCos is max(MaxAngleCos, MinAngleCos),
	MinCos =< Cos, Cos =< MaxCos.

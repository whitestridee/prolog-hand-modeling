:- module(hand,[
	point/3, point_list/2, hand/7,
	finger_motion_type/5, finger_angle/4,
	valid_angle/2, valid_cos_angle/2,
	angle_type_limits/3, angle_det_type/2
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


%angle limits in degrees for fingers
%angle_type_limits(Finger, MinAngle, MaxAngle)

angle_type_limits(bpabc, -80, 80).
angle_type_limits(bpbcd, -50, 50).
angle_type_limits(bpcde, -90, 90).
angle_type_limits(oabc, -80, 80).
angle_type_limits(obcd, -100, 100).
angle_type_limits(ocde, -90, 90).
angle_type_limits(between, -30, 30).

angle_type_limits(bpprived, -50, 50).
angle_type_limits(oprived, -60, 60).
angle_type_limits(bppsgib1, -50, 50).
angle_type_limits(bppsgib2, -100, 80).

angle_type_limits(o2sgib1, -120, 90).
angle_type_limits(o2sgib2, -100, 100).
angle_type_limits(o2sgib3, -100, 100).

angle_type_limits(o3sgib1, -120, 90).
angle_type_limits(o3sgib2, -100, 100).
angle_type_limits(o3sgib3, -80, 80).

angle_type_limits(o4sgib1, -120, 90).
angle_type_limits(o4sgib2, -100, 100).
angle_type_limits(o4sgib3, -80, 80).

angle_type_limits(o5sgib1, -120, 90).
angle_type_limits(o5sgib2, -100, 100).
angle_type_limits(o5sgib3, -80, 80).

angle_type_limits(bppz, -100, 100).
angle_type_limits(middle_abduction_deduction, -10, 10).

%angle_det_type(Type, Axis)

angle_det_type(bpabc, all).
angle_det_type(bpbcd, all).
angle_det_type(bpcde, all).
angle_det_type(oabc, all).
angle_det_type(obcd, all).
angle_det_type(ocde, all).
angle_det_type(between, all).

angle_det_type(middle_abduction_deduction, y).
angle_det_type(bpprived, x).
angle_det_type(oprived, x).
angle_det_type(bppsgib1, y).
angle_det_type(bppsgib2, y).

angle_det_type(o2sgib1, x).
angle_det_type(o2sgib2, x).
angle_det_type(o2sgib3, x).

angle_det_type(o3sgib1, x).
angle_det_type(o3sgib2, x).
angle_det_type(o3sgib3, x).

angle_det_type(o4sgib1, x).
angle_det_type(o4sgib2, x).
angle_det_type(o4sgib3, x).

angle_det_type(o5sgib1, x).
angle_det_type(o5sgib2, x).
angle_det_type(o5sgib3, x).

angle_det_type(bppz, z).

%valid_angle - check if angle is valid for finger
valid_angle(Type, Angle):-
	angle_type_limits(Type, MinAngle, MaxAngle),
	MinAngle =< Angle, Angle =< MaxAngle.

%valid_cos_angle - check if angle cosinus is valid for finger
%valid_cos_angle(Type, Cos)
valid_cos_angle(Type, Cos):-
	angle_type_limits(Type, MinAngle, MaxAngle),
	MinAngleCos is cos(MinAngle),
	MaxAngleCos is cos(MaxAngle),
	MinCos is min(MinAngleCos, MaxAngleCos),
	MaxCos is max(MaxAngleCos, MinAngleCos),
	MinCos =< Cos, Cos =< MaxCos.

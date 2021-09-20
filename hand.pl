:- module(hand,[
	point/3, point_list/2, hand/7,finger_angle/4,
	valid_angle/3, valid_cos_angle/3,
	angle_det_type/2, angle_type_limits/3,
]).
:- use_module(library(clpfd)).

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

finger_angle(little, x, MinAngle, MaxAngle).
finger_angle(little, y, MinAngle, MaxAngle).
finger_angle(little, z, MinAngle, MaxAngle).

finger_angle(ring, x, MinAngle, MaxAngle).
finger_angle(ring, y, MinAngle, MaxAngle).
finger_angle(ring, z, MinAngle, MaxAngle).

finger_angle(middle, x, MinAngle, MaxAngle).
finger_angle(middle, y, MinAngle, MaxAngle).
finger_angle(middle, z, MinAngle, MaxAngle).

finger_angle(index, x, MinAngle, MaxAngle).
finger_angle(index, y, MinAngle, MaxAngle).
finger_angle(index, z, MinAngle, MaxAngle).

finger_angle(thumb, x, MinAngle, MaxAngle).
finger_angle(thumb, y, MinAngle, MaxAngle).
finger_angle(thumb, z, MinAngle, MaxAngle).

%valid_angle - check if angle is valid for finger on specific axis
valid_angle(Finger, Axis, Angle):-
	finger_angle(Finger, Axis, MinAngle, MaxAngle),
	MinAngle =< Angle, Angle =< MaxAngle.
	
%valid_cos_angle - check if angle cosinus is valid for finger on specific axis
%valid_cos_angle(Finger, Axis, Cos)
valid_cos_angle(Finger, Axis, Cos):-
	finger_angle(Finger, Axis, MinAngle, MaxAngle),
	MinAngleCos is cos(MinAngle),
	MaxAngleCos is cos(MaxAngle),
	MinCos is min(MinAngleCos, MaxAngleCos),
	MaxCos is max(MaxAngleCos, MinAngleCos),
	MinCos =< Cos, Cos =< MaxCos.

%angle limits in degrees for fingers
%angle_type_limits(Finger, MinAngle, MaxAngle)

% old

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
:- module(hand,[finger_type/4,valid_angle/2,angle_det_type/2]).
:- use_module(library(clpfd)).

%finger type connection (P1, P2, P3, Type)
%P1,P2,P3 in [1;42]

finger_type(1, 2, 3, bpabc).
finger_type(4, 5, 6, oabc).
finger_type(5, 6, 7, obcd).
finger_type(8, 9, 10, oabc).
finger_type(9, 10, 11, obcd).
finger_type(12, 13, 14, oabc).
finger_type(13, 14, 15, obcd).
finger_type(16, 17, 18, oabc).
finger_type(17, 18, 19, obcd).

finger_type(2, 3, 21, bpprived).
finger_type(4, 7, 21, oprived).
finger_type(8, 11, 21, oprived).
finger_type(12, 15, 21, oprived).
finger_type(16, 19, 21, oprived).
finger_type(1, 2, 3, bppsgib1).
finger_type(2, 3, 21, bppsgib2).
finger_type(5, 4, 6, o2sgib1).
finger_type(6, 5, 7, o2sgib2).
finger_type(7, 6, 21, o2sgib3).
finger_type(9, 8, 10, o3sgib1).
finger_type(10, 9, 11, o3sgib2).
finger_type(11, 10, 21, o3sgib3).
finger_type(13, 12, 14, o4sgib1).
finger_type(14, 13, 15, o4sgib2).
finger_type(15, 14, 21, o4sgib3).
finger_type(17, 16, 18, o5sgib1).
finger_type(18, 17, 19, o5sgib2).
finger_type(19, 18, 21, o5sgib3).

%angle limits in degrees for fingers
%angle_type_limits(Type, MinAngle, MaxAngle)

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


%valid_angle - check if angle is valid for type
%valid_angle(Type, Angle)
valid_angle(Type, Angle):-
	angle_type_limits(Type, MinAngle, MaxAngle),
	MinAngle #=< Angle, Angle #=< MaxAngle.
	
%valid_cos_angle - check if angle cosinus is valid for type
%valid_cos_angle(Type, Cos)
valid_cos_angle(Type, Cos):-
	angle_type_limits(Type, MinAngle, MaxAngle),
	MinAngleCos = cos(MinAngle),
	MaxAngleCos = cos(MaxAngle),
	MinCos = min(MinAngleCos, MaxAngleCos),
	MaxCos = max(MaxAngleCos, MinAngleCos),
	MinCos #=< Cos, Cos #=< MaxCos.

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
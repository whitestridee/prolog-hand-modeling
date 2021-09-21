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

%angle_amplitude(MotionType, MinAngle, MaxAngle)
%for hand palm
angle_amplitude(flexion, 80, 85).
angle_amplitude(extension, 70, 85).
angle_amplitude(abduction, 15, 25).
angle_amplitude(adduction, 30, 45).

%angle_amplitude(Finger, Bone1, Bone2, MotionType, Angle)
%for fingers

angle_amplitude(thumb, metacarpal, wrist, flexion, 20).
angle_amplitude(thumb, metacarpal, wrist, extension, 20).
angle_amplitude(thumb, metacarpal, wrist, abduction, 20).
angle_amplitude(thumb, metacarpal, wrist, adduction, 20).
angle_amplitude(thumb, proximal, metacarpal, flexion, 50).
angle_amplitude(thumb, proximal, metacarpal, extension, 50).
angle_amplitude(thumb, distal, proximal, flexion, 80).
angle_amplitude(thumb, distal, proximal, extension, 100).

angle_amplitude(Finger, proximal, metacarpal, flexion, 90):-
	not(Finger==thumb).
angle_amplitude(Finger, proximal, metacarpal, extension, 120):-
	not(Finger==thumb).
angle_amplitude(Finger, proximal, metacarpal, abduction, 30):-
	not(Finger==thumb),not(Finger==index).
angle_amplitude(Finger, proximal, metacarpal, adduction, 30):-
	not(Finger==thumb),not(Finger==index).
angle_amplitude(index, proximal, metacarpal, abduction, 60).
angle_amplitude(index, proximal, metacarpal, adduction, 60).

angle_amplitude(Finger, medial, proximal, flexion, 100):-
	not(Finger==thumb).
angle_amplitude(Finger, medial, proximal, extension, 100):-
	not(Finger==thumb).
angle_amplitude(Finger, distal, medial, flexion, 80):-
	not(Finger==thumb).
angle_amplitude(Finger, distal, medial, extension, 80):-
	not(Finger==thumb).
	
angle_amplitude(Finger, wrist, metacarpal, MotionType, Angle):-
	angle_amplitude(Finger, metacarpal, wrist, MotionType, Angle).
angle_amplitude(Finger, metacarpal, proximal, MotionType, Angle):-
	angle_amplitude(Finger, proximal, metacarpal, MotionType, Angle).
angle_amplitude(Finger, proximal, distal, MotionType, Angle):-
	angle_amplitude(Finger, distal, proximal, MotionType, Angle).
angle_amplitude(Finger, proximal, medial, MotionType, Angle):-
	angle_amplitude(Finger, medial, proximal, MotionType, Angle).
angle_amplitude(Finger, medial, distal, MotionType, Angle):-
	angle_amplitude(Finger, distal, medial, MotionType, Angle).

%valid_angle - check if angle is valid for finger on specific axis
valid_angle_new(Finger, Axis, Angle):-
	finger_angle(Finger, Axis, MinAngle, MaxAngle),
	MinAngle =< Angle, Angle =< MaxAngle.
	
%valid_cos_angle - check if angle cosinus is valid for finger on specific axis
%valid_cos_angle(Finger, Axis, Cos)
valid_cos_angle_new(Finger, Axis, Cos):-
	finger_angle(Finger, Axis, MinAngle, MaxAngle),
	MinAngleCos is cos(MinAngle),
	MaxAngleCos is cos(MaxAngle),
	MinCos is min(MinAngleCos, MaxAngleCos),
	MaxCos is max(MaxAngleCos, MinAngleCos),
	MinCos =< Cos, Cos =< MaxCos.
	
% old

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

%angle_det_type(Type, Axis)

angle_det_type(bpabc, all).
angle_det_type(bpbcd, all).
angle_det_type(bpcde, all).
angle_det_type(oabc, all).
angle_det_type(obcd, all).
angle_det_type(ocde, all).
angle_det_type(between, all).

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
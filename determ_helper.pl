:- module(determ_helper,[
	angle_cos_constr/7, angle_constraint/10,
	angleY_constraint/7, angleX_constraint/7,
	det_angleXY/10, det_coords/11
	]).
:- use_module(validation),
   use_module(helper),
   use_module(hand),
   use_module(library(clpfd)),
   use_module(library(clpr)).
	
	
angle_cos_constr(Abx, Bcx, Aby, Bcy, Abz, Bcz, Angle) :-
	{Dotprod =:= Abx * Bcx + Aby * Bcy + Abz * Bcz},
	{Magnitudeab =:= pow(Abx * Abx + Aby * Aby + Abz * Abz, 0.5)},
	{Magnitudebc =:= pow(Bcx * Bcx + Bcy * Bcy + Bcz * Bcz, 0.5)},
	{cos(Angle * 3.1415 / 180) =:= Dotprod / (Magnitudeab * Magnitudebc)}.
	
angle_constraint(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Angle):-
	{Abx =:= X2 - X1},
	{Aby =:= Y2 - Y1},
	{Abz =:= Z2 - Z1},
	{Bcx =:= X3 - X2},
	{Bcy =:= Y3 - Y2},
	{Bcz =:= Z3 - Z2},
	angle_cos_constr(Abx, Bcx, Aby, Bcy, Abz, Bcz, Angle).
	
	
angleY_constraint(X1, Z1, X2, Z2, X3, Z3, AngleY):-
	{Abx =:= X2 - X1},
	{Abz =:= Z2 - Z1},
	{Bcx =:= X3 - X2},
	{Bcz =:= Z3 - Z2},
	angle_cos_constr(Abx, Bcx, 0, 0, Abz, Bcz, AngleY).


angleX_constraint(Y1, Z1, Y2, Z2, Y3, Z3, AngleX):-
	{Aby =:= Y1 - Y2},
	{Abz =:= Z1 - Z2},
	{Bcy =:= Y3 - Y2},
	{Bcz =:= Z3 - Z2},
	angle_cos_constr(0, 0, Aby, Bcy, Abz, Bcz, AngleY).

	
det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	hand:angle_det_type(Type, x),
	angleX_constraint(Y1, Z1, Y2, Z2, Y3, Z3, AngleX),
	hand:valid_angle(Type, AngleX).

det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	hand:angle_det_type(Type, y),
	angleY_constraint(X1, Z1, X2, Z2, X3, Z3, AngleY),
	hand:valid_angle(Type, AngleY).
	
det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3) :-
	not(hand:angle_det_type(Type, _)),
	angle_constraint(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Angle),
	hand:valid_angle(Type, Angle).
	
%det_coords - determination of coordinates of missing points

det_coords(1, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3).
	
det_coords(2, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3).
	
det_coords(3, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3).
	
det_coords(12, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3).
	
det_coords(13, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3).
	
det_coords(23, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3).
	
det_coords(123, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Type) :-
	det_angleXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3),
	write('X1: '), write(X1), nl,
	write('Y1: '), write(Y1), nl,
	write('Z1: '), write(Z1), nl.
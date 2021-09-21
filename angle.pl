:- module(angle,[get_angle/5]).

vec_length(vector(X, Y, Z), Len) :- Len is sqrt(X * X + Y * Y + Z * Z).
dot_prod(vector(X1, Y1, Z1), vector(X2, Y2, Z2), DotProd) :-
	DotProd is X1 * X2 + Y1 * Y2 + Z1 * Z2.

rad_to_deg(Radian, Degrees) :- Degrees is Radian * 180 / 3.1415.
deg_to_rad(Degrees, Radian) :- Radian is Degrees * 3.1415 / 180.

angle_between_vectors(Vector1, Vector2, Angle) :-
	vec_length(Vector1, Len1),
	vec_length(Vector2, Len2),
	dot_prod(Vector1, Vector2, DotProd),
	AngleRad is acos(DotProd / (Len1 * Len2)),
	rad_to_deg(AngleRad, Angle).
	
get_angle(all, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3), Angle) :-
	angle_between_vectors(vector(X2 - X1, Y2 - Y1, Z2 - Z1), vector(X3 - X2, Y3 - Y2, Z3 - Z2), Angle).
	
get_angle(x, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3), Angle) :-
	angle_between_vectors(vector(0, Y1 - Y2, Z1 - Z2), vector(0, Y3 - Y2, Z3 - Z2), Angle).
	
get_angle(y, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3), Angle) :-
	angle_between_vectors(vector(X2 - X1, 0, Z2 - Z1), vector(X3 - X2, 0, Z3 - Z2), Angle).
	
get_angle(z, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3), Angle) :-
	angle_between_vectors(vector(X2 - X1, Y2 - Y1, 0), vector(X3 - X2, Y3 - Y2, 0), Angle).

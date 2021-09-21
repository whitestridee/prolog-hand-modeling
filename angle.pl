:- module(angle,[get_angle/5]).

vec_length(vector(X, Y, Z), Len) :- Len is sqrt(X * X + Y * Y + Z * Z).
vec_length_sqr(vector(X, Y, Z), Len) :- Len is X * X + Y * Y + Z * Z.
dot_prod(vector(X1, Y1, Z1), vector(X2, Y2, Z2), DotProd) :-
	DotProd is X1 * X2 + Y1 * Y2 + Z1 * Z2.

rad_to_deg(Radian, Degrees) :- Degrees is Radian * 180 / 3.1415.
deg_to_rad(Degrees, Radian) :- Radian is Degrees * 3.1415 / 180.

angle_between_vectors(Vector1, Vector2, Angle) :-
	vec_length_sqr(Vector1, Len1Sqr),
	vec_length_sqr(Vector2, Len2Sqr),
	dot_prod(Vector1, Vector2, DotProd),
	AngleRad is acos(DotProd / sqrt(Len1Sqr * Len2Sqr)),
	rad_to_deg(AngleRad, Angle).
	
get_angle(all, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3), Angle) :-
	AX is X2 - X1, AY is Y2 - Y1, AZ is Z2 - Z1,
	BX is X3 - X2, BY is Y3 - Y2, BZ is Z3 - Z2,
	angle_between_vectors(vector(AX, AY, AZ), vector(BX, BY, BZ), Angle).
	
get_angle(x, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3), Angle) :-
	AY is Y1 - Y2, AZ is Z1 - Z2,
	BY is Y3 - Y2, BZ is Z3 - Z2,
	angle_between_vectors(vector(0, AY, AZ), vector(0, BY, BZ), Angle).
	
get_angle(y, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3), Angle) :-
	AX is X2 - X1, AZ is Z2 - Z1,
	BX is X3 - X2, BZ is Z3 - Z2,
	angle_between_vectors(vector(AX, 0, AZ), vector(BX, 0, BZ), Angle).
	
get_angle(z, point(X1, Y1, Z1), point(X2, Y2, Z2), point(X3, Y3, Z3), Angle) :-
	AX is X2 - X1, AY is Y2 - Y1,
	BX is X3 - X2, BY is Y3 - Y2,
	angle_between_vectors(vector(AX, AY, 0), vector(BX, BY, 0), Angle).

:- module(helper,[getugol/10,getfirstel/2, getnthel/3, getugolX/7, getugolY/7]).
%Poluchity ugol mezdhu 3emya tochkami
getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Ugol):-

Abx is X1 - X2,
Aby is Y1 - Y2,
Abz is Z1 - Z2,

Bcx is X3 - X2,
Bcy is Y3 - Y2,
Bcz is Z3 - Z2,

Pi is 3.14,

Dotprod is Abx * Bcx + Aby * Bcy + Abz * Bcz,

Magnitudeab is Abx * Abx + Aby * Aby + Abz * Abz,

Magnitudebc is Bcx * Bcx + Bcy * Bcy + Bcz * Bcz,

Ugol is (Dotprod / sqrt(Magnitudeab * Magnitudebc) * 180.0 / Pi).


getugolY(X1, Z1, X2, Z2, X3, Z3, UgolY):-

Aby is X1 - X2,
Abz is Z1 - Z2,

Bcy is X3 - X2,
Bcz is Z3 - Z2,

Dotprod is Aby * Bcy + Abz * Bcz,

Magnitudeab is   Aby * Aby + Abz * Abz,
Magnitudebc is   Bcy * Bcy + Bcz * Bcz,
SkY is Dotprod / sqrt(Magnitudeab * Magnitudebc),

UgolY is acos(SkY).

getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX):-

Aby is Y1 - Y2,
Abz is Z1 - Z2,

Bcy is Y3 - Y2,
Bcz is Z3 - Z2,

Dotprod is Aby * Bcy + Abz * Bcz,

Magnitudeab is   Aby * Aby + Abz * Abz,
Magnitudebc is   Bcy * Bcy + Bcz * Bcz,
SkX is Dotprod / sqrt(Magnitudeab * Magnitudebc),

UgolX is acos(SkX).



%�������� ������ �� ������
getfirstel([Head|_], Value):-
Value = Head.
%�������� n-��� �� ������
getnthel([Head|_] , Head, 0):-
!.
getnthel([_|Tail], H, N):-
N > 0,
N1 is N - 1,
getnthel(Tail, H, N1).


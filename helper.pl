:- module(helper,[getugol/10,getfirstel/2, getnthel/3, getugolX/7, getugolY/7]).
%Poluchity ugol mezdhu 3emya tochkami
getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Ugol):-

Abx is X2 - X1,
Aby is Y2 - Y1,
Abz is Z2 - Z1,

Bcx is X3 - X2,
Bcy is Y3 - Y2,
Bcz is Z3 - Z2,

Pi is 3.14,

Dotprod is Abx * Bcx + Aby * Bcy + Abz * Bcz,

Magnitudeab is sqrt(Abx * Abx + Aby * Aby + Abz * Abz),

Magnitudebc is sqrt(Bcx * Bcx + Bcy * Bcy + Bcz * Bcz),

CosUgol is acos(Dotprod / (Magnitudeab * Magnitudebc)),
Ugol is CosUgol * 180 / 3.14159.


getugolY(X1, Z1, X2, Z2, X3, Z3, UgolY):-

Aby is X2 - X1,
Abz is Z2 - Z1,

Bcy is X3 - X2,
Bcz is Z3 - Z2,

Dotprod is Aby * Bcy + Abz * Bcz,

Magnitudeab is  sqrt(Aby * Aby + Abz * Abz),
Magnitudebc is  sqrt(Bcy * Bcy + Bcz * Bcz),
SkY is acos(Dotprod / (Magnitudeab * Magnitudebc)),

UgolY is SkY * 180 / 3.1415.

getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX):-

Aby is Y1 - Y2,
Abz is Z1 - Z2,

Bcy is Y3 - Y2,
Bcz is Z3 - Z2,

Dotprod is Aby * Bcy + Abz * Bcz,

Magnitudeab is  sqrt(Aby * Aby + Abz * Abz),
Magnitudebc is  sqrt(Bcy * Bcy + Bcz * Bcz),
SkX is acos(Dotprod / (Magnitudeab * Magnitudebc)),

UgolX is 180 * SkX / 3.1415.



%Получить первый ел списка
getfirstel([Head|_], Value):-
Value = Head.
%Получить n-ный ел списка
getnthel([Head|_] , Head, 0):-
!.
getnthel([_|Tail], H, N):-
N > 0,
N1 is N - 1,
getnthel(Tail, H, N1).


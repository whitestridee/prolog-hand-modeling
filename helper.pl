:- module(helper,[getugol/10,getfirstel/2, getnthel/4]).
%Получить угол между 3мя точками
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


getfirstel([Head|_], Value):-
Value = Head.

getnthel(List , Value, ElemNum, CurElem):-
List = [Head|Tail],
CurElem = ElemNum -> Value = [Head]
;
getnthel(Tail, Value, ElemNum, CurElem + 1).



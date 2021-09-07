:- module(validation,[validatefinger/3]).
 :- use_module(read_files),
   use_module(helper).


validatefinger(Point1, Point2, Point3):-
   helper:getfirstel(Point1, X1),
   helper:getnthel(Point1, Y1, 1),
   helper:getnthel(Point1, Z1, 2),
   helper:getfirstel(Point2, X2),
   helper:getnthel(Point2, Y2, 1),
   helper:getnthel(Point2, Z2, 2),
   helper:getfirstel(Point3, X3),
   helper:getnthel(Point3, Y3, 1),
   helper:getnthel(Point3, Z3, 2),
   helper:getugol(X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, Ugol),
   write(Ugol),
   Ugol < 270.

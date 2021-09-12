:- module(validation,[validatefinger/3, validatefinger/4, validateallfingers/2
                     ,validatefingerXY/4,validateugolXY/10, validatefingerswithpoints/43]).
 :- use_module(read_files),
   use_module(helper).

checkforstr(Point):-
   helper:getfirstel(Point, X),
   number(X).

validatefingerswithpoints(Result, Point1, Point2, Point3, Point4, Point5, Point6, Point7, Point8, Point9, Point10, Point11, Point12, Point13, Point14, Point15, Point16, Point17, Point18, Point19, Point20, Point21, Point22, Point23, Point24, Point25, Point26, Point27, Point28, Point29, Point30, Point31, Point32, Point33, Point34, Point35, Point36, Point37, Point38, Point39, Point40, Point41, Point42):-
validatefinger(Point1, Point2, Point3, bpabc)->
   validatefinger(Point4, Point5, Point6, oabc),
   validatefinger(Point5, Point6, Point7, obcd),
   validatefinger(Point8, Point9, Point10, oabc),
   validatefinger(Point9, Point10, Point11, obcd),
   validatefinger(Point12, Point13, Point14, oabc),
   validatefinger(Point13, Point14, Point15, obcd),
   validatefinger(Point16, Point17, Point18, oabc),
   validatefinger(Point17, Point18, Point19, obcd),
   validatefingerXY(bpprived, Point3, Point2, Point21),
   %validatefingerXY(oprived, Point7, Point4, Point21),
   validatefingerXY(oprived, Point11, Point8, Point21),
   validatefingerXY(oprived, Point15, Point12, Point21),
   validatefingerXY(oprived, Point19, Point16, Point21),
   validatefingerXY(bppsgib1, Point2, Point1, Point3),
   validatefingerXY(bppsgib2, Point3, Point2, Point21),
   validatefingerXY(o2sgib1, Point4, Point5, Point6),
   validatefingerXY(o2sgib2, Point5, Point6, Point7),
   validatefingerXY(o2sgib3, Point7, Point6, Point21),
   validatefingerXY(o3sgib1, Point9, Point8, Point10),
   validatefingerXY(o3sgib2, Point10, Point9, Point11),
   validatefingerXY(o3sgib3, Point11, Point10, Point21),
   validatefingerXY(o4sgib1, Point12, Point13, Point14),
   validatefingerXY(o4sgib2, Point14, Point13, Point15),
   validatefingerXY(o4sgib3, Point15, Point14, Point21),
   validatefingerXY(o5sgib1, Point17, Point16, Point18),
   validatefingerXY(o5sgib2, Point18, Point17, Point19),
   validatefingerXY(o5sgib3, Point19, Point18, Point21),

   write("Hand number 1 is ok"), nl,

   validatefinger(Point22, Point23, Point24),
   validatefinger(Point25, Point26, Point27),
   validatefinger(Point26, Point27, Point28),
   validatefinger(Point29, Point30, Point31),
   validatefinger(Point30, Point31, Point32),
   validatefinger(Point33, Point34, Point35),
   validatefinger(Point34, Point35, Point36),
   validatefinger(Point37, Point38, Point39),
   validatefinger(Point38, Point39, Point40),
   write("Hand number 2 is ok"), nl,
   Result = "Ok";
   Result = "Not".
   
validateallfingers(Interval, Time):-

   read_files:tryloadpoint(Point1, Interval, 1, Time),
   read_files:tryloadpoint(Point2, Interval, 2, Time),
   read_files:tryloadpoint(Point3, Interval, 3, Time),
   read_files:tryloadpoint(Point4, Interval, 4, Time),
   read_files:tryloadpoint(Point5, Interval, 5, Time),
   read_files:tryloadpoint(Point6, Interval, 6, Time),
   read_files:tryloadpoint(Point7, Interval, 7, Time),
   read_files:tryloadpoint(Point8, Interval, 8, Time),
   read_files:tryloadpoint(Point9, Interval, 9, Time),
   read_files:tryloadpoint(Point10, Interval, 10, Time),
   read_files:tryloadpoint(Point11, Interval, 11, Time),
   read_files:tryloadpoint(Point12, Interval, 12, Time),
   read_files:tryloadpoint(Point13, Interval, 13, Time),
   read_files:tryloadpoint(Point14, Interval, 14, Time),
   read_files:tryloadpoint(Point15, Interval, 15, Time),
   read_files:tryloadpoint(Point16, Interval, 16, Time),
   read_files:tryloadpoint(Point17, Interval, 17, Time),
   read_files:tryloadpoint(Point18, Interval, 18, Time),
   read_files:tryloadpoint(Point19, Interval, 19, Time),
   read_files:tryloadpoint(Point20, Interval, 20, Time),
   read_files:tryloadpoint(Point21, Interval, 21, Time),
   read_files:tryloadpoint(Point22, Interval, 22, Time),
   read_files:tryloadpoint(Point23, Interval, 23, Time),
   read_files:tryloadpoint(Point24, Interval, 24, Time),
   read_files:tryloadpoint(Point25, Interval, 25, Time),
   read_files:tryloadpoint(Point26, Interval, 26, Time),
   read_files:tryloadpoint(Point27, Interval, 27, Time),
   read_files:tryloadpoint(Point28, Interval, 28, Time),
   read_files:tryloadpoint(Point29, Interval, 29, Time),
   read_files:tryloadpoint(Point30, Interval, 30, Time),
   read_files:tryloadpoint(Point31, Interval, 31, Time),
   read_files:tryloadpoint(Point32, Interval, 32, Time),
   read_files:tryloadpoint(Point33, Interval, 33, Time),
   read_files:tryloadpoint(Point34, Interval, 34, Time),
   read_files:tryloadpoint(Point35, Interval, 35, Time),
   read_files:tryloadpoint(Point36, Interval, 36, Time),
   read_files:tryloadpoint(Point37, Interval, 37, Time),
   read_files:tryloadpoint(Point38, Interval, 38, Time),
   read_files:tryloadpoint(Point39, Interval, 39, Time),
   read_files:tryloadpoint(Point40, Interval, 40, Time),
   read_files:tryloadpoint(Point41, Interval, 41, Time),
   read_files:tryloadpoint(Point42, Interval, 42, Time),

   validatefinger(Point1, Point2, Point3, bpabc),
   validatefinger(Point4, Point5, Point6, oabc),
   validatefinger(Point5, Point6, Point7, obcd),
   validatefinger(Point8, Point9, Point10, oabc),
   validatefinger(Point9, Point10, Point11, obcd),
   validatefinger(Point12, Point13, Point14, oabc),
   validatefinger(Point13, Point14, Point15, obcd),
   validatefinger(Point16, Point17, Point18, oabc),
   validatefinger(Point17, Point18, Point19, obcd),

   validatefingerXY(bpprived, Point3, Point2, Point21),
   validatefingerXY(oprived, Point7, Point4, Point21),
   validatefingerXY(oprived, Point11, Point8, Point21),
   validatefingerXY(oprived, Point15, Point12, Point21),
   validatefingerXY(oprived, Point19, Point16, Point21),
   validatefingerXY(bppsgib1, Point2, Point1, Point3),
   validatefingerXY(bppsgib2, Point3, Point2, Point21),
   validatefingerXY(o2sgib1, Point5, Point4, Point6),
   validatefingerXY(o2sgib2, Point6, Point5, Point7),
   validatefingerXY(o2sgib3, Point7, Point6, Point21),
   validatefingerXY(o3sgib1, Point9, Point8, Point10),
   validatefingerXY(o3sgib2, Point10, Point9, Point11),
   validatefingerXY(o3sgib3, Point11, Point10, Point21),
   validatefingerXY(o4sgib1, Point13, Point12, Point14),
   validatefingerXY(o4sgib2, Point14, Point13, Point15),
   validatefingerXY(o4sgib3, Point15, Point14, Point21),
   validatefingerXY(o5sgib1, Point17, Point16, Point18),
   validatefingerXY(o5sgib2, Point18, Point17, Point19),
   validatefingerXY(o5sgib3, Point19, Point18, Point21),

   write("Hand number 1 is ok"), nl,

   validatefinger(Point22, Point23, Point24),
   validatefinger(Point25, Point26, Point27),
   validatefinger(Point26, Point27, Point28),
   validatefinger(Point29, Point30, Point31),
   validatefinger(Point30, Point31, Point32),
   validatefinger(Point33, Point34, Point35),
   validatefinger(Point34, Point35, Point36),
   validatefinger(Point37, Point38, Point39),
   validatefinger(Point38, Point39, Point40),
   write("Hand number 2 is ok"), nl.

validateugolXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3):-
   Type = bpprived -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 50, UgolX >= -50;
   Type = oprived -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 60, UgolX >= -60;
   Type = bppsgib1 -> getugolY(X1, Z1, X2, Z2, X3, Z3, UgolY), UgolY =< 50, UgolY >= -50;
   Type = bppsgib2 -> getugolY(X1, Z1, X2, Z2, X3, Z3, UgolY), UgolY =< 80, UgolY >= -100;
   Type = o2sgib1 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 90, UgolX >= -120;
   Type = o2sgib2 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 100, UgolX >= -100;
   Type = o2sgib3 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 100, UgolX >= -100;
   Type = o3sgib1 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 90, UgolX >= -120;
   Type = o3sgib2 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 100, UgolX >= -100;
   Type = o3sgib3 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 80, UgolX >= -80;
   Type = o4sgib1 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 90, UgolX >= -120;
   Type = o4sgib2 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 100, UgolX >= -100;
   Type = o4sgib3 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 80, UgolX >= -80;
   Type = o5sgib1 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 90, UgolX >= -120;
   Type = o5sgib2 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 100, UgolX >= -100;
   Type = o5sgib3 -> getugolX(Y1, Z1, Y2, Z2, Y3, Z3, UgolX), UgolX =< 80, UgolX >= -80.
   
validatefinger(Point1, Point2, Point3):-
   checkforstr(Point1), checkforstr(Point2), checkforstr(Point3)   ->
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
   write("Ugol is : "), write(Ugol), nl,
   Ugol < 135,
   Ugol > -135;
   write("Invalid data "), nl.

validatefinger(Point1, Point2, Point3, Type):-
   checkforstr(Point1), checkforstr(Point2), checkforstr(Point3)   ->
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
   write("Ugol is : "), write(Ugol), nl,
   checkugol(Type, Ugol),
   Ugol < 135,
   Ugol > -135;
   write("Invalid data "), nl.

validatefingerXY(Type, Point1, Point2, Point3):-
   checkforstr(Point1), checkforstr(Point2), checkforstr(Point3)   ->
   helper:getfirstel(Point1, X1),
   helper:getnthel(Point1, Y1, 1),
   helper:getnthel(Point1, Z1, 2),
   helper:getfirstel(Point2, X2),
   helper:getnthel(Point2, Y2, 1),
   helper:getnthel(Point2, Z2, 2),
   helper:getfirstel(Point3, X3),
   helper:getnthel(Point3, Y3, 1),
   helper:getnthel(Point3, Z3, 2),
   validateugolXY(Type, X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3);
   write("Invalid data "), nl.


checkugol(Type, Ugol):-
   Type = bpabc -> Ugol =< 80, Ugol >= -80;
   Type = bpbcd -> Ugol =< 50, Ugol >= -50;
   Type = bpcde -> Ugol =< 90, Ugol >= -90;
   Type = oabc -> Ugol =< 80, Ugol >= -80;
   Type = obcd -> Ugol =< 100, Ugol >= -100;
   Type = ocde -> Ugol =< 90, Ugol >= -90;
   Type = between -> Ugol =< 30, Ugol >= -30.



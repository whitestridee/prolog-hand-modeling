:- module(determ,[determine_all/44]).

:- use_module(write_files),
   use_module(validation),
   use_module(hand),
   use_module(angle),
   use_module(library(clpr)),
   use_module(library(lists)).

%determ_allfingers - call this to determine missing points
%gives list of all points
%including missing and already good ones

determine_all(Working_Dir, Result,
	Point1, Point2, Point3, Point4, Point5, Point6, Point7,
	Point8, Point9, Point10, Point11, Point12, Point13, Point14,
	Point15, Point16, Point17, Point18, Point19, Point20, Point21,
	Point22, Point23, Point24, Point25, Point26, Point27, Point28,
	Point29, Point30, Point31, Point32, Point33, Point34, Point35,
	Point36, Point37, Point38, Point39, Point40, Point41, Point42
):-
	working_directory(_, Working_Dir),
	write_files:write_points(Result, "test/determ_result.txt").

:- module(write_files,[
	write_points/2, write_list/2, point_to_str/2,
	write_invalid_data/0, write_angle/1, write_angle/2,
	write_angle_is_valid/1, write_invalid_points/3
]).
:- use_module(determ).

write_points(PList,Filename) :-
    open(Filename, write, Stream),
    convlist(point_to_str, PList, StrList),
	write_list(Stream, StrList),
    close(Stream).
	
write_list(Stream, []).
write_list(Stream, [Head|Tail]) :-
	write(Stream, Head),
	write_list(Stream, Tail).
	
point_to_str(Point, Str) :-
	determ:get_coords(Point, X, Y, Z),
	number_string(X, StrX),
	number_string(Y, StrY),
	number_string(Z, StrZ),
	string_concat(StrX, ";", StrX1),
	string_concat(StrY, ";", StrY1),
	string_concat(StrX1, StrY1, StrXY),
	string_concat(StrXY, StrZ, StrXYZ),
	string_concat(StrXYZ, "\n", Str).


write_invalid_data() :- write("Invalid data "), nl.
write_angle(Angle) :- write("Angle is "), write(Angle), nl.
write_angle(Type, Angle):- write(Type), write(" angle is "), write(Angle), nl.

write_angle_is_valid(Type) :- 
	open('angles.txt', append, Stream2),
	string_concat(Type, " is ok", Msg),
	write(Stream2, Msg), nl(Stream2),
	close(Stream2).
	
write_invalid_points(Point1, Point2, Point3) :-
	open('points.txt', append, Stream),
	write(Stream, [Point1, Point2, Point3]), nl(Stream),
	close(Stream).

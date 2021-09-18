:- module(write_files,[write_points/2, write_list/2, point_to_str/2]).
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

loadpoint(Line, Filename, PointTime) :-
    string_concat("points_data_with_dots/",Filename,Full),
    open(Full, read, Str),
    CurNumber = 0,
    read_line(PointTime, CurNumber, Str, Line),
    close(Str).

tryloadpoint(Line, Interval, PointNumber, PointTime) :-
    name_creator(Interval, PointNumber, Filename) ->
    open(Filename, read, Str),
    CurNumber = 0,
    read_line(PointTime, CurNumber, Str, Line),
    close(Str);
    Line = [_1, _1, _1],write("File not found"), nl.


read_file(Stream, Lines) :-
    read(Stream, Line),               % Читаем строку
    (  at_end_of_stream(Stream)       % Если конец то возвращаем
    -> Lines = []                     %
    ;  Lines = [Line|NewLines],       % Иначе добавляем строку и читаем дальше...
       read_file(Stream, NewLines)
    ).

read_line(PointNumber, CurNumber, Stream, Coordinates):-
    read(Stream, Line),
     (  at_end_of_stream(Stream)       % Если конец то возвращаем
    -> Coordinates = []                     %
    ;  (CurNumber =:= PointNumber) -> Coordinates = Line;       % Иначе добавляем строку и читаем дальше...
       read_line(PointNumber, CurNumber + 1, Stream, Coordinates)
    ).
%Создаем имя файла...
name_creator(Interval, Point, FullName):-
    string_concat("points_data_with_dots/", "xyz_", Var1),
    string_concat(Var1, Interval, Var2),
    string_concat(Var2, "_", Var3),
    string_concat(Var3, Point, Var4),
    string_concat(Var4, ".txt", TryName),
    write(TryName),nl,
    exists_file(TryName) -> FullName = TryName.

:- module(read_files,[loadfile/2, loadpoint/3]).

loadfile(Lines,Filename) :-
    string_concat("points_data_with_dots/",Filename,Full),
    open(Full, read, Str),%Надо поменять working_directory на свой...
    read_file(Str,Lines),
    close(Str).

loadpoint(Line, Filename, PointNumber) :-
    string_concat("points_data_with_dots/",Filename,Full),
    open(Full, read, Str),%Надо поменять working_directory на свой...
    CurNumber = 0,
    read_line(PointNumber, CurNumber, Str, Line),
    close(Str).

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

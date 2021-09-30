:- module(read_files,[loadfile/2, loadpoint/3,tryloadpoint/4]).

loadfile(Lines,Filename) :-
    string_concat("points_data_with_dots/",Filename,Full),
    open(Full, read, Str),
    read_file(Str,Lines),
    close(Str).

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
    read(Stream, Line),               % ������ ������
    (  at_end_of_stream(Stream)       % ���� ����� �� ����������
    -> Lines = []                     %
    ;  Lines = [Line|NewLines],       % ����� ��������� ������ � ������ ������...
       read_file(Stream, NewLines)
    ).

read_line(PointNumber, CurNumber, Stream, Coordinates):-
    read(Stream, Line),
     (  at_end_of_stream(Stream)       % ���� ����� �� ����������
    -> Coordinates = []                     %
    ;  (CurNumber =:= PointNumber) -> Coordinates = Line;       % ����� ��������� ������ � ������ ������...
       read_line(PointNumber, CurNumber + 1, Stream, Coordinates)
    ).
%������� ��� �����...
name_creator(Interval, Point, FullName):-
    string_concat("points_data_with_dots/", "xyz_", Var1),
    string_concat(Var1, Interval, Var2),
    string_concat(Var2, "_", Var3),
    string_concat(Var3, Point, Var4),
    string_concat(Var4, ".txt", TryName),
    write(TryName),nl,
    exists_file(TryName) -> FullName = TryName.

:- module(read_files,[loadfile/2, loadpoint/3]).

loadfile(Lines,Filename) :-
    open(Filename, read, Str),%���� �������� working_directory �� ����...
    read_file(Str,Lines),
    close(Str).

loadpoint(Line, Filename, PointNumber) :-
    open(Filename, read, Str),
    CurNumber = 0,
    read_line(PointNumber, CurNumber, Str, Line),
    close(Str).

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

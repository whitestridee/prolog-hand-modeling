loadfile :-
    working_directory(_, 'C:/Users/yazgul/Documents/GitHub/prolog-hand-modeling'),
    open('C:/Users/yazgul/Documents/GitHub/prolog-hand-modeling/points_data/test2.txt', read, Str),
    read_file(Str,Lines),
    close(Str),
    write(Lines), nl.

read_file(Stream, Lines) :-
    read(Stream, Line),               % Attempt a read Line from the stream
    (  at_end_of_stream(Stream)       % If we're at the end of the stream then...
    -> Lines = []                     % ...lines read is empty
    ;  Lines = [Line|NewLines],       % Otherwise, Lines is Line followed by
       read_file(Stream, NewLines)    %   a read of the rest of the file
    ).

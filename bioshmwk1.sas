Data d1;
  Input #1 @ 1 (sixmon) (3.)
           @ 5 (ninemon) (3.)
           @ 9 (oneyr) (3.);
Cards;
004 008 015
003 005 017
006 008 010
002 003 004
006 009 010
005 005 006
004 006 007
005 006 007
005 005 007
007 007 009
;
proc means data= d1;
run;
proc glm data=d1;
    model sixmon ninemon oneyr = /nouni;
    repeated SBP 10 contrast(3) / summary;
    run;


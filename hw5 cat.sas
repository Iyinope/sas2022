data dos;
set 'C:\Users\iyink\Downloads\DOS.sas7bdat';
run;

proc print data= dos; run;

data dos1;
set dos;
depd=dep;
if dep=2 then depd=1;
if cirsttl>.Z then cirs=1;
if 6 =< cirsttl< 10 then cirs=2;
if cirsttl >=10 then cirs=3;
run;

proc print data= dos1;
run;

proc freq data= dos1;
table cirs*depd / trend;
run;


proc logistic data=dos1 descending;
class cirs/param = REF;
model depd= cirs /covb CLPARM= BOTH expb;
contrast "cirs" cirs 1, cirs 0 1/e estimation= all;
run;

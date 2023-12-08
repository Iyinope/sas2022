proc print data=piu;
run;

proc freq data=piu ;
table brfeed*BrCa/chisq;
exact or;
run;

proc freq data=piu;
table alch*BrCa;
exact or;
run;

proc freq data=piu;
table BrCa*alch/chisq;
exact or;
run;

proc logistic data=piu;
class alch / REF=FIRST;
model BrCa = alch;
run;
quit;

data piu2;
set piu;
where age=1 or age=2 or age=3;
run;
proc freq data=piu2;
table BrCa*brfeed/chisq;
exact or;
run;
proc logistics data=piu2;
model BrCa = brfeed;

data piu3;
set piu;
where age=4 or age=5 or age=6;
run;
proc freq data=piu3;
table BrCa*brfeed/chisq;
exact or;
run;

proc logistic data=piu3;


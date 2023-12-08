
data smoke;
set 'C:\Users\iyink\Downloads\smoke.sas7bdat';
run; 

proc print data = smoke;
run;

data one;
input treat $ employment $ age;
datalines;
0 ft 50
;
run;


proc phreg data=smoke plot(overlay)=s plot(overlay)=cumhaz;
class treat employment ;
model time*status(0)=age treat |employment;
baseline covariates=smoke out=b survival=s lower=lcl
upper=ucl CUMHAZ=cmh;
run;

proc sort data=a;
by time;
run;
proc means data=a;
by time;
var s;
output out=aa;
run;

proc print data=b;
run;

proc print data=b;
run;

proc phreg data=smoke;
class treat employment;
model time*status(0)=age treat|employment;
contrast "2 vs 3" cof 0 0 -1 1/estimate=both;
run;


proc sort data=b;by time;run;
proc means data=b;by time;var s;output out=bb;run;
proc lifetest data=smoke outsurv=c;
time time*status(0) ;
run;
data dd;merge bb c;by time;run;
proc gplot data=dd;
plot SURVIVAL*time s*time / overlay;
symbol1 interpol=stepJ value=dot color=red;
symbol2 interpol=stepJ value=c color=blue;
where _STAT_="MEAN";
run;

proc print data=dd;
run;


proc sort data=b;by treat time;run;
proc means data=b;by treat time;var s;output out=m;run;
proc lifetest data=smoke outsurv=h;
time time*status(0) ;
strata treat;
run;
data ff;merge m h;by treat time;run;
proc gplot data=ff;
plot SURVIVAL*time s*time / overlay;
by treat;
symbol1 interpol=stepJ value=dot color=red;
symbol2 interpol=stepJ value=c color=blue;
where _STAT_="MEAN";
run;



proc phreg data=smoke;
class treat employment ;
model time*status(0)= age | treat employment;
contrast "second"
treat 0 1 employment 1 1 treat*employment 0 0 0 1 0 age 50/estimate;
contrast "first"
cof 0 0 0 1 disease 1 disease * cof 0 0 0 0 0 0 1 age 50/estimate;
contrast "c=3 d=1 vs c=1 d=2"
cof 0 1 0 -1 disease -1 1 disease*cof 0 0 0 1 0 0 -1 age -5
/estimate;
run;




proc phreg data=smoke;
class treat (ref='0') employment (ref='other')/param=ref;
model time*status(0)=treat employment | age;
run;

proc phreg data=smoke;
class treat (ref='0') employment(ref='other') ;
model time*status(0)= age treat|employment;
contrast "second"
age 50 treat 0  employment 0 1 treat*employment 0 1 / estimate;
contrast "first"
age 50 treat 1 employment 0 1 treat*emploment 0 1  / estimate;
contrast "t=1 e=1 vs t=0 e=1"
age 0 treat -1 employment 0 0 treat*employment 0 0 /estimate;
run;

proc phreg data=smoke;
class treat (ref='0') employment(ref='other') ;
model time*status(0)= age treat|employment;
contrast "second"
age 45 treat 0  employment 1 0 treat*employment 1 0 / estimate;
contrast "first"
age 50 treat 1 employment 0 1 treat*emploment 0 1 / estimate;
contrast "t=1 e=1 vs t=0 e=1"
age -5 treat -1 employment 1 -1 treat*employment 1 -1 /estimate;
run;



proc phreg data=smoke;
class employment;
model time*status(0)=employment ;
contrast "other vs ft vs pt" cof 0 0 -1 1,
cof 0 -1 1/estimate;
contrast "cof" cof 0 0 -1 1,
cof 0 -1 1, cof 1,
cof -1 1/estimate;
run;

proc phreg data=ex;
class cof;
model time*status(0)=cof ;


contrast "1 vs 2 vs 3" 
cof 0 0 -1 1,
cof 0 -1 1/estimate;


contrast "cof" 
cof 0 0 -1 1,
cof 0 -1 1, cof 1,
cof -1 1/estimate;
run;

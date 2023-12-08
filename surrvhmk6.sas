data smoke;
set 'C:\Users\iyink\Downloads\smoke.sas7bdat';
emp=.;
if employment = 'ft' then emp = 1;
else if employment = 'other' then emp=0;
else if employment = 'pt' then emp=2;
run;

proc print data=smoke;
run;

proc lifetest data=smoke method=km;
time time*status(0);
strata treat;
run;

proc phreg data=smoke;
class treat;
model time*status(0) = treat / ties=exact;
run;


proc phreg data=smoke;
class treat (ref='0') emp (ref='0');
model time*status(0) = age treat|emp;
run;

proc phreg data=smoke;
class treat (ref='0') emp (ref='0');
model time*status(0) = age treat|emp;
baseline covariates=smoke out=survs survival=survival lower=lcl upper=ucl CUMHAZ=cmh;
run;






proc phreg data=smoke plot(overlay)=s plot(overlay)=cumhaz;
class treat (ref='0') emp(ref='0');
model time*status(0)=age treat | emp;
baseline covariates= out=a survival=s lower=lcl upper=ucl CUMHAZ=cmh;
run;






proc phreg data=smoke;
class treat emplpyment;
model time*status(0)= age treat|employment;
baseline covariates=smoke out=a survival=s ;
run;
proc sort data=a;by treat time;run;
proc means data=a;by treat time;var s;output out=aa;run;
proc lifetest data=smoke outsurv=c;
time time*status(0) ;
strata treat;
run;
data dd;merge aa c;by treat time;run;

proc gplot data=dd;
plot SURVIVAL*time s*time / overlay;
by treat;
symbol1 interpol=stepJ value=dot color=red;
symbol2 interpol=stepJ value=c color=blue;
where _STAT_="MEAN";
run;


data two;
input time status treat emp age count;
datalines;
1 1 0 ft 50;
run;

proc phreg data=two plot(overlay)=s plot(overlay)=cumhaz;
model time*status(0)= age treat|emp;
weight count;
baseline covariates=two out=a survival=s ;
run;


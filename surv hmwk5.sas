data one;
infile 'C:\Users\iyink\Downloads\Survival of liver transplant recipients.dat' firstobs=2;
input patient age gender disease time status cof;
run;

proc print data=one;
run;

proc phreg data=prostatic;
model time*status(0)=size/risklimits;
run;

proc phreg data=one;
model time*status(0)=age/risklimits;
run;

proc phreg data=hypernephroma;
class age ;
model time*status(0)=age;
contrast "group 1 vs 2" age 1 -1/estimate;
where nephrectomy=1;run;

PROC phreg DATA=one; class disease;
model time*status(0) =disease;
where Treatment=1;
run;
? 
proc phreg data=one;
model time*status(0) = treatment;
where gender = 1;
run;


proc phreg data=one;
model time*status(0)=age disease;
run;



proc phreg data=hypernephroma;
class age (ref=first) nephrectomy (ref=first);
model time*status(0)=age|nephrectomy;
hazardratio age / at (nephrectomy="0" "1") diff=ALL;
run;

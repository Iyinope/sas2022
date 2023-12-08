data one; 
input edu dep $ count;
datalines;
1 nodep 481
  maj/min 264
;




data two;
set 'C:\Users\iyink\Downloads\dos.sas7bdat';
run;

data new5;
set two;
if education = . then delete;
run;

data new6;
set new5;
edu=.;
if education <=12 then edu=0;
else if education >12 then edu=1;
depr=.;
if dep =0 then depr=0;
else if dep= 1 or 2 then depr=1;
run;

proc print data= new5 (obs=50);
run;

proc freq data=new6;
table depr*edu / fisher chisq;
run;

proc freq data=new6;
table depr*edu / cmh chisq;
run;








data iud;
input time status;
datalines;
3 1
3 1
3 0
4 0
5 1
5 0
10 1
12 1
18 1
20  1
20 1
20 1
21 1
22 1
22 0
23 1
24 1
48 1
48 0
48 0
;
run;

proc lifetest data=iud method=lt intervals= (12 to 60 by 12) plots=(s d h);
time time*status(0);
run;

proc lifetest data=iud method=km plots= h (bandwidth=10);
time time*status(0);
run;

data ven1;
set 'C:\Users\iyink\Downloads\ppd.sas7bdat';

epii=.;
if epds >=26 then epii= 1;
else if epds <26 then epii=0; run;

proc freq data=ven1;
table Cmajmin*epii/agree;
run;


proc print data=ven1
run;


data zen;
infile 'C:\Users\iyink\Downloads\Survival of liver transplant recipients.dat' firstobs=2 dlm=truncate;
input patient age gender disease time status cof;
run;

proc print data=zen;
run;

PROC LIFETEST DATA=zen method=km plots=s(cl);
TIME time*status(0);
survival out=ci conftype=loglog stderr;
run;
proc print data=ci;
run;





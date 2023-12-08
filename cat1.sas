data one;
input drug time status;
datalines;
1 3 1 
1 3 0
1 4 0
1 5 1
1 10 1
1 12 1
1 20 1
1 20 1
1 21 1
1 24 1
1 48 1
1 48 0
2 3 1
2 5 0
2 18 1
2 20 1 
2 22 1 
2 22 0 
2 23 1 
2 48 0
;
run;

proc lifetest data=one method=km;
time time*status(0);
strata drug;
run;

data two;
infile 'C:\Users\iyink\Downloads\Comparison of two treatments for prostatic cancer.dat' firstobs=2;
input patient treatment time status age shb size index;
run;

proc lifetest data=two method=km;
time time*status(0);
strata treatment;
run;





* Question 1 /*;


proc freq data=intake1 order=data;
table cp47*cp9 /chisq;
run;

proc freq data=intake1 order=data;
table cp47*cp9 /agree;
run;

proc freq data=intake1 order=data;
table cp47*cp9 /cmh;
run;



* Question 3/ ;

data dos;
set 'C:\Users\iyink\Downloads\dos.sas7bdat';
run;

data dos_;
set dos;
if education = . then delete;
edu =.;
if education > 12 then edu=1;
else if education <= 12 then edu=0;
run; 

proc freq data=dos_;
table edu*dep1/ chisq;
exact chisq;
run;

proc print data= dos_; run;

data dos_;
set dos_;
dep1=.;
if dep = 0 then dep1 = 0;
else if dep = 1 then dep1 = 1;
else if dep = 2 then dep1 = 3;
run;

proc freq data=dos_;
table edu*dep1/ cmh;
run;

proc print data=dos_;
run;


proc corr data=dos5;
var edu;
with dep;
run;


data dos5;
set dos;
if education > .z then edu=0;
if education > 12 then edu = 1;
run; 

proc freq data=dos5;
tables edu*dep / cmh;
run;

proc freq data=dos5;
tables edu*dep / chisq;
exact chisq;
run;

proc corr data=dos5;
var edu dep;
run;


* Question 2/ ;

proc print data=intake1;
run;

proc freq data=intake;
table cp48*cp10 / chisq;
run;

proc print data=intake (obs=20);
var cp48 cp10;
run;


proc print data=intake;
run;



data intake_;
set intake;

bloc=.;
if cp9 = 'No' then bloc = 0;
else if cp9= 'Yes' then bloc =1;

bloc1=.;
if cp10 = . then bloc1 = 0;
else if cp10 = 1 then bloc1 = 1;
else if cp10 >1 then bloc1= 2;
keep subject cp48 cp47 cp10 cp9 bloc bloc1 uti;
run;




data intake

proc sort data= intake_ out=intake_sort nodup; by subject; run;

data union;
merge intake_sort;
by subject;
run;


data intake;
set intake;
uti=.;
if cp48 = . then uti = 0;
else if cp48 = 0 then uti = 0;
else if cp48 =1 then uti = 1;
else if cp48 >1 then uti = 2;
run;

proc print data=intake;
run;



proc freq data=intake;
table uti*bloc / chisq;
run;

proc freq data=intake;
table uti*bloc /agree;
run;

proc freq data=intake;
table uti*bloc /cmh;
run;

proc freq data=intake;
table uti*bloc /stuart;
run;








proc print data= intake1;
run;



data intake2;
set intake1;

bloc=.;
if cp9 = 'No' then bloc = 0;
else if cp9= 'Yes' then bloc =1;

bloc1=.;
if cp10 = . then bloc1 = 0;
else if cp10 = 1 then bloc1 = 1;
else if cp10 >1 then bloc1= 2;

bloc2=.;
if cp10= . then bloc2= 0;
else if cp10 >=1 then bloc2 = 1;
run;

proc freq data=intake2;
table bloc*bloc2;
run;

proc freq daat=intake2;
table cp48*bloc2;
run;

proc print data= intake2;
run;


data intake2;
set intake2;
uti=.;
if cp48 = .;
else if cp48 = 0 then uti = 0;
else if cp48 =1 then uti = 1;
else if cp48 >1 then uti = 2;
run;

proc freq data=intake2;
table uti*bloc2;
run;

proc print data=intake2;
run;

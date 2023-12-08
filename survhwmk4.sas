
data one;
input stain time status;
datalines;
1 23 1
1 47 1
1 69 1
1 70 0
1 71 0
1 100 0
1 101 0
1 148 1
1 181 1
1 198 0
1 208 0
1 212 0
1 224 0
2 5 1
2 8 1
2 10 1
2 13 1
2 18 1
2 24 1
2 26 1
2 26 1
2 31 1
2 35 1
2 40 1
2 41 1
2 48 1
2 50 1
2 59 1
2 61 1
2 68 1
2 71 1
2 76 0
2 105 0
2 107 0
2 109 0
2 113 1
2 116 0
2 118 1
2 143 1
2 154 0
2 162 0
2 188 0
2 212 0
2 217 0
2 225 0
;
run;

proc lifetest data=one method=km;
time  time*status(0);
strata stain;
run;



data three;
infile 'C:\Users\iyink\Downloads\Time to death while waiting for a liver transplant.dat' firstobs=2;
input patient time status age gender bmi ukeld;
ag=.;
if age <=50 then ag=1;
else if 51<= age <=60  then ag=2;
else if age >=61 then ag=3;
run;
proc print data= three;
run;


proc lifetest data=three method=km;
time time*status(0);
strata ag;
run;

proc lifetest data=three method=km;
time time*status(0);
strata ag/trend;
run;

proc lifetest data=three method=km;
time time*status(0);
strata ag/ group=gender;
run;

proc lifetest data=three method=km;
time time*status(0);
strata gender/ group=ag;
run;


data four;
input time status gender;
cards;
3 1 1
3 1 2
3 0 1
4 0 1
5 1 1
5 0 2
10 1 1
12 1 1
18 1 2
20 1 1
20 1 1
20 1 2
21 1 1
22 1 2
22 0 2
23 1 2
24 1 1
48 1 1
48 0 1
48 0 2
50 1 1
51 1 2
;
run;

proc lifetest data= four contype=log; time time*status(0); run;

proc lifetest data=four contype=log;
time time*status(0); 
strata gender; 
run;



data two;
infile 'C:\Users\iyink\Downloads\Survival of multiple myeloma patients.dat' firstobs=2;
input patient time status  age sex bun ca hb pcells protein;
run;

proc print data=two;
run;

data two_;
set two;
ag=.;
if age 21-40 then ag=1;
if age 41-60 then ag=2;
if age >61 then ag=3;
run;

proc lifetest data= two method=km;
time time*status(0);
strata age;
run;

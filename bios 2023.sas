
Data d1;
Input #1 @1 (GPA_G) (3.)
@5 (MAT)(2.)
@8(GPA_A)(3.);
Datalines;
3.2 65 2.5
4.1 55 4.5
3.0 65 3.1
2.6 55 3.1
3.7 65 3.6
4.0 65 4.3
4.3 75 4.6
2.7 45 3.0
3.6 65 4.7
4.1 75 5.0
2.7 55 3.7
2.9 55 2.6
2.5 35 3.1
3.0 65 2.7
3.3 85 3.0
3.2 65 2.7
4.1 75 5.0
3.0 65 2.5
2.6 55 3.1
3.7 70 2.6
4.0 75 4.3
4.3 75 5.0
2.7 45 2.4
3.6 65 4.7
4.1 75 3.4
2.7 55 3.7
2.9 55 2.6
2.5 45 3.1
3.0 65 2.7
3.3 75 4.0
;
proc reg data=d1;
model GPA_G = MAT GPA_A;
run;

proc corr data=d1;
var GPA_G GPA_A;
partial MAT;
run;


Data d2;
Input #1 @1 (LP) (5.)
@7 (LA)(2.)
@10(LS)(2.);
Datalines;
069.0 06 08
118.5 10 15
116.5 10 13
125.0 11 14
129.9 13 18
135.0 13 17
139.0 13 15
147.9 17 17
160.0 19 21
169.9 18 19
134.9 13 17
155.0 18 20
169.9 17 21
194.5 20 22
209.9 21 24
;
proc reg data=d2;
model LP= LA LS;
run;



data bios3;
infile 'C:\Users\iyink\Downloads\Data_HW3-3.csv' firstobs=2 DLM=',';
input Y X1 X2 X3 X4 X5;
RUN;

proc print data=bios3; run;
PROC CORR DATA=bios3;
    VAR Y X1 X2 X3 X4 X5;  /* list the relevant variables here */
RUN;


PROC REG DATA=bios3_;
  MODEL SBP = SALT EXERCISE EATING1 EATING2 EATING3 / SOLUTION;
RUN;


data bios3_;
set bios3;
if X5=0 Then do; R1=0; R2=0; R3=0; end;
else if X5=1 then do; R1=1; R2=0; R3=0; end;
else if X5=2 then do; R1=0; R2=1; R3=0; end;
else if X5=3 then do; R1=0; R2=0; R3=1; end;
run;

proc print data=bios3_; run;

proc reg data=bios3_;
model Y= X1 X2 R1 R2 R3;
run;

proc freq data=bios3;
table X5;
run;

proc print data=bios3;
run;







proc print data= bios3_;
run;
proc means data=bios3 n mean std;
var Y X1 X2 X3 X4;
run;

PROC FREQ DATA=bios3;
table X5;
run;

data bios3;
set bios3;
rename Y= SBP X1= DAILYSALTINTAKE X2=HRS_EX X3=AGE X4=WEIGTH X5=FREQ;
RUN;

proc reg data=bios3;
model SBP= DAILYSALTINTAKE HRS_EX FREQ;
run;


proc corr data=bios3;
var Y X4;
partial X3;
run;

proc corr data=bios3;
run;


Data d_n;
Input #1 @1 (GPA_G) (3.)
@5 (GREQ) (3.)
@9 (GREV) (3.)
@13 (MAT)(2.)
@16(GPA_A)(3.);
Datalines;
3.2 145 140 65 2.5
4.1 170 170 55 4.5
3.0 140 150 65 3.1
2.6 130 130 55 3.1
3.7 160 150 65 3.6
4.0 165 155 65 4.3
4.3 130 170 75 4.6
2.7 130 130 45 3.0
3.6 155 165 65 4.7
4.1 170 170 75 5.0
2.7 130 135 55 3.7
2.9 140 135 55 2.6
2.5 130 135 35 3.1
3.0 145 140 65 2.7
3.3 140 150 85 3.0
3.2 155 140 65 2.7
4.1 170 170 75 5.0
3.0 150 140 65 2.5
2.6 130 130 55 3.1
3.7 150 140 70 2.6
4.0 155 135 75 4.3
4.3 170 160 75 5.0
2.7 130 140 45 2.4
3.6 165 155 65 4.7
4.1 170 160 75 3.4
2.7 145 150 55 3.7
2.9 140 145 55 2.6
2.5 140 135 45 3.1
3.0 155 150 65 2.7
3.3 160 160 75 4.0
;
proc stepwise data=d_n;
model GPA_G = GREQ GREV MAT GPA_A /stepwise ;
run;

proc corr data=d_n;
run;

proc stepwise data=bios3;
model Y = X1 X2 X3 X4 / stepwise;
run;

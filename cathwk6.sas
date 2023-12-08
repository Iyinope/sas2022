data one;
input x y count;
datalines;
0 0 12
0 1 0 
1 0 9 
1 1 11
;
run;



proc freq data = one;
table x*y;
weight count;
run;

proc logistic data = one desc;
model y = x;
exact x intercept / estimate = both;
weight count;
run;

proc logistic data = one desc; 
model y = x / firth;
weight count;
run;





data dos;
set 'C:\Users\iyink\Downloads\DOS.sas7bdat';
run;

proc print data = dos;
run;

data dos_;
set dos;
IF DEP>0 THEN DEPD=1; ELSE DEPD=0;
IF DEP<=.Z THEN DEPD=.;
IF MARITAL = 2 THEN MS=1;
IF MARITAL = 6 THEN MS=2;
IF MARITAL = 1 OR 3<=MARITAL<=5 THEN MS=3;
IF MARITAL<=.Z THEN MS=.;
RUN;
PROC LOGISTIC DATA=DOS_ DESCENDING;
CLASS gender/PARAM=glm;
MODEL DEPD = MS| gender/ LINK = LOGIT SCALE=NONE
LACKFIT AGGREGATE;
RUN;

PROC LOGISTIC DATA=DOS_ DESCENDING;
CLASS gender/PARAM=glm;
MODEL DEPD = MS gender/ LINK = LOGIT SCALE=NONE
LACKFIT AGGREGATE;
RUN;

PROC LOGISTIC DATA=DOS_ DESCENDING;
CLASS MS/PARAM=glm;
MODEL DEPD = age MS gender/ LINK = LOGIT SCALE=NONE
LACKFIT AGGREGATE;
RUN;


data dos1_;
set dos_;

la=age*log(age);

PROC LOGISTIC DATA=dos1_ DESCENDING;
class gender ms/param=ref;
MODEL DEPD = gender age la ms / LINK =LOGIT;            

proc logistic data=dos1_ desc;
model depd= age gender ms;
output out = m2 p = prob xbeta = hat;
run;


data m2;
set m2;
hat2=hat*hat;
run;

proc logistic data=m2 desc;
model depd= hat hat2;
run;

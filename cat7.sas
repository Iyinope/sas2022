data dos;
set 'C:\Users\iyink\Downloads\DOS.sas7bdat';
run; 

proc print data = dos;
run; 

data dos_;
set dos;
depd=dep;
if dep=2 then depd=1; 
run;

proc print data = dos_;
run; 

PROC LOGISTIC DATA=dos_ DESCENDING;
CLASS RACE;
MODEL DEPD = AGE GENDER education RACE
/ LINK = probIT LACKFIT;
RUN;

PROC LOGISTIC DATA=dos_;
MODEL DEPD = AGE 
/ LINK = probIT LACKFIT;
RUN;


*question 1b;
PROC LOGISTIC DATA=dos_ DESCENDING;
MODEL DEPD = AGE 
/ LINK = cloglog LACKFIT;
RUN;
PROC LOGISTIC DATA=dos_;
MODEL DEPD = AGE 
/ LINK = cloglog LACKFIT;
RUN;



*question 2;
data heart;
set 'C:\Users\iyink\Downloads\heart.sas7bdat';
run;
data heart_;
set heart;
if kk1 =1 then kk=1;
if kk2 = 1 then kk=2;
if kk3 = 1 then kk=3;
if kk4 = 1 then kk=4;

if age1= 1 then age=1;
if age2=1 then age=2;
if age3=1 then age=3;
if age4=1 then age=4;
run;

proc print data=heart_ (obs=20);
run;










PROC LOGISTIC DATA=heart_ DESCENDING;
class anterior;
MODEL death = hcabg anterior kk2 kk3 kk4 age2 age3 age4  
/ LINK=LOGIT SCALE= NONE 
LACKFIT AGGREGATE;
RUN;


PROC LOGISTIC DATA=heart_ DESCENDING;
class anterior kk  age;
MODEL death = hcabg anterior kk age  
/ LINK=LOGIT SCALE= NONE 
LACKFIT AGGREGATE;
RUN;



PROC LOGISTIC DATA=heart_ DESCENDING; 
CLASS anterior kk age;
MODEL death = hcabg anterior kk age 
/ LINK = probIT LACKFIT;
RUN;


PROC LOGISTIC DATA=heart_ DESCENDING;
CLASS anterior kk age;
MODEL death = hcabg anterior kk age
/ LINK = cloglog LACKFIT;
RUN;

PROC LOGISTIC DATA=heart_;
CLASS anterior kk age;
MODEL death = hcabg anterior kk age
/ LINK = cloglog LACKFIT;
RUN;


PROC genmod DATA=heart_ DESCENDING;
class anterior kk age;
MODEL death = hcabg anterior kk age
/d=binomial LINK =identity;
output out=a pred=p;
RUN;

proc print data=a;
run;












PROC LOGISTIC DATA=heart_ DESCENDING;
class age;
MODEL death = age  
/ LINK=LOGIT SCALE= NONE 
LACKFIT AGGREGATE;
RUN;



PROC LOGISTIC DATA=heart_ DESCENDING; 
CLASS age;
MODEL death = age 
/ LINK = probIT LACKFIT;
RUN;


PROC LOGISTIC DATA=heart_ DESCENDING;
CLASS age;
MODEL death = age
/ LINK = cloglog LACKFIT;
RUN;

PROC LOGISTIC DATA=heart_;
CLASS age;
MODEL death = age
/ LINK = cloglog LACKFIT;
RUN;


PROC genmod DATA=heart_ DESCENDING;
class age;
MODEL death = age
/d=binomial LINK =identity;
output out=a pred=p;
RUN;

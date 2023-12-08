ods rtf file = "C:\Users\iyink\Desktop\Categorical\cathw5.rtf";


data one; 
set 'C:\Users\iyink\Downloads\DOS.sas7bdat';
run;



data one_;
set one;

depd=dep;
if dep=2 then depd=1;

if cirsttl < 6 then cirs3= 1;
else if 6 =< cirsttl < 10 then cirs3= 2;
else if cirsttl >= 10 then cirs3 =3;

if marital = 1 then msd = 1;
else msd = 0;

run;


proc logistic data= one_ desc;
class cirs3 (ref='3')/ param= ref;
model depd=cirs3/ expb;
output out=b4 p=p l=xbeta ;
run;

proc logistic data= one_ desc;
model depd=cirs3 / expb;
output out=b4 p=p l=xbeta ;
run;

proc logistic data= one_ desc;
model depd=cirs3 age msd/ expb;
output out=b4 p=p l=xbeta ;
run;



proc freq data=one_;
table cirs3*depd /trend;
run;


ods rtf close;
run;

data dos;
set 'C:\Users\iyink\Downloads\dos.sas7bdat';
* Use the DOS study data to assess the gender and depression (dichotomized according
to no and minor/major depression) association by stratifying medical burden and ed-
ucation levels, where medical burden has two level (CIRS <= 6 and CIRS > 6), and
education has two levels (edu <= 12 and edu >12). Based on this set of four 2  2
tables, answer the following questions.*;
depd=.;
if dep = 0 then depd=0;
else depd=1;

cirs=.;
if cirsttl <= 6 then cirs= 0;
else if cirsttl > 6 then cirs = 1;

edu=.;
if education > .z then edu= 0;
if education > 12 then edu=1;
run;



proc freq data=dos;
table cirs*gender*depd; 
run;

proc freq data=dos;
table edu*gender*depd; 
run;

proc freq data=dos;
table cirs*edu*gender*depd / cmh bdt; 
exact zelen;
run;


proc freq data=dos;
table cirs*gender*dep / cmh bdt; 
exact zelen;
run;

proc freq data=dos;
table edu*gender*dep / cmh bdt; 
exact zelen;
run;

proc freq data=dos;
table gender*depd / cmh;
EXACT ZELEN;
run;

proc print data=dos;
run;


proc freq data=dos order=data;
table edu*dep;
run;


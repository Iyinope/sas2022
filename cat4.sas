proc print data=not11;
run;

proc freq data=not11;
table cp48;
run;

proc freq data=not11;
table cp9;
run;

proc freq data=not11;
table cp10;
run;

data not1;
set not11;
b1=.;
if cp9= 'No' then b1= 0;
else if cp9= 'Yes' then b1=1;
run;

proc print data=not1;
run;

proc freq data=not1;
table b1;
run;

data not2;
set not1;
b2=.;
if cp10 =. then b2= 0;
else if cp10 = 1 then b2= 1;
else if cp10 > 1 then b2 = 2;
run;

proc print data=not2;
run;






proc freq data=not2;
table b2;
run;

proc freq data=not2;
table b1*b2;
run;

data not3;
set not2;
uti=.;
if cp48= 0 then uti=0;
else if cp48 = 1 then uti = 1;
else if cp48 > 1 then uti = 2;
run;

data this_;
set this;

blockage=.;
if cp9= 'No' then blockage = 0; 
if cp10 = 1 then blockage= 1;
if cp10 >1 then blockage = 2;


uti=.;
if cp48= 0 then uti=0;
else if cp48 = 1 then uti = 1;
else if cp48 > 1 then uti = 2;
run;

proc freq data=this_;
table uti*blockage / agree;
run;

proc print data=not3;
run;

proc freq data= not3;
table uti;
run;

proc freq data = not3;
table b1*uti*b2 / agree;
run;


data one; 
input r c count; 
datalines;
0 0 111
0 1 6
0 2 19
1 0 36
1 1 11
1 2 7
2 0 5
2 1 0
2 2 4
;
run;

data new;
set event;
blockage=.;
if cp9= 'No' then blockage = 0; 
if cp10 = 1 then blockage= 1;
if cp10 >1 then blockage = 2;


uti_=.;
if cp48= 0 then uti_=0;
else if cp48 = 1 then uti_ = 1;
else if cp48 > 1 then uti_ = 2;
run;

proc freq data=new;
table blockage*uti_;
run;

proc freq data=new;




proc print data=event; run;

data okay;
set event;
uti=.;
if cp47= 'Yes' then uti=1;
else if cp47 = 'No' then uti=0;

block=.;
if cp9= 'Yes' then block=1;
else if cp9= 'No' then block=0;
run;

proc freq data=okay order=data;
table uti*block;
run;

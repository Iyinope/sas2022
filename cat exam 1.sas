data one;
input gender dep edu count;
datalines;
1 1 0 85
1 0 0 105
0 1 0 24
0 0 0 48
1 1 1 112
1 0 1 169
0 1 1 42
0 0 1 159
;
run;

proc freq data=one;
table edu*gender*dep;
weight count;
run;

proc freq data=one;
table gender*dep / all;  *page 75, pay attention to levels. - ODDSRATION;
weight count;
run;

proc freq data=one;
table gender*dep / agree;  *page 75, pay attention to levels. - KAPPA;
weight count;
run;
 
proc freq data=one;
table gender*dep / agree;   *MCNEM - TEST FOR MARGINAL HOMOGENITY;
exact mcnem;
weight count;
run;

proc freq data=one;
table gender*dep / cmh chisq;  *TESTING INDEPENDE BET ROW AND COLUMN, FISHERS;
weight count;
run;

proc freq data=two;
table dep / binomial (wald ac); 
exact bin;          
weight count;
run;



data two;
input dis count;
datalines;
1 15
0 5
;
run;

proc freq data=two order=data;
table dis / binomial (wald ac p=0.5 exact);
weight count;
run;

proc freq data=two;
table gen*depd / chisq; * PEARSON CHISQ;
exact chisq;
weight count;
run;

proc freq data=two;
table gen*depd / trend;  *TREND TEST;
exact trend;
weight count;
run;

proc freq data=two;
table depd / testp= (.5 .3 .2)
exact chisq;
run;

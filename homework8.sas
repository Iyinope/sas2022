DM 'out; clear; log; clear';

LIBNAME iyin8 "C:\Users\iyink\Downloads";
RUN;

DATA iyin8.One;
SET "C:\Users\iyink\Downloads\hw8.sas7bdat";
RUN;
PROC PRINT DATA=iyin8.One;
RUN;


*/ Question 1 /*;

PROC FREQ DATA=iyin8.One;
TABLE hypertension/BINOMIAL (p=0.33 LEVEL=2);
RUN;

*/

   H0: p=0.33
   Ha: p^=0.33
   
Confidence Interval is 33.93% ~ 35.79%

P-value for 2-tailed test = <0.0001 < 0.05

Decision: Reject H0.

Conclusion: Proportion of Hypertension in the sample is significantly different from 33%


* Question 2 /*;

PROC FREQ DATA=iyin8.One;
TABLE Gender * hypertension / CHISQ RISKDIFF;
RUN;

* / Proportion of Hypertension for men = 0.3465 = 34.65%
    Proportion of Hypertension for wowen = 0.3509= 35.09%

Are those proportions different?
H0: Proportion of Hypertension for man = Proportion for Hypertension for woman
Ha: Proportion of Hypertension for man^= Proportion of Hyperstension in woman

The difference between those two proportion is 0.44%, with 95% CI (-1.43%, 2.31 %) 
P-value = 0.6436
P-value > 0.05 and 95% CI covers 0, so difference is not significantly different from 0.
Decision: Fail to reject H0. 
Conclusion: Men and wowen have similar prevalence of hypertension.



* Question 3*/

H0: There is no association between smoking and gender
Ha: There is an association between smoking and gender
P-value < 0.05
Decision: Reject H0
Conclusion: There is an association between smoking and gender
;

PROC FREQ DATA=iyin8.One;
TABLE Heavy * Gender / FISHER CHISQ;
RUN;


   

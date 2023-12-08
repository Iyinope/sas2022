DM 'out; clear; log; clear;';
LIBNAME iyinope "C:\Users\iyink\Downloads";
RUN;

DATA iyinope.Ten;
SET "C:\Users\iyink\Downloads\hw7.sas7bdat";
RUN;

PROC PRINT DATA=iyinope.Ten;
RUN;


*/ QUESTION 1 */;

DATA iyinope.Ten;
SET iyinope.Ten;
PROC UNIVARIATE DATA=iyinope.Ten;
VAR bpsystol;
RUN;

PROC MEANS DATA=iyinope.Ten N NMISS MIN P25 P50 P75 MAX MEAN STD MAXDEC=1;
VAR bpsystol;
RUN;

PROC SGPLOT DATA=iyinope.Ten;
HBOX bpsystol/EXTREME;
RUN;

PROC PRINT DATA=iyinope.Ten;
WHERE bpsystol < 114 - 1.5*(142-114)
   OR bpsystol > 142 + 1.5*(142-114);
   VAR ID bpsystol;
   RUN;

PROC PRINT DATA=iyinope.Ten;
WHERE bpsystol < 114 - 3*(142-114)
   OR bpsystol > 142 + 3*(142-114);
   VAR ID bpsystol;
   RUN;

PROC UNIVARIATE DATA=iyinope.Ten PLOT;
VAR bpsystol;
RUN;

ODS GRAPHICS ON;
PROC UNIVARIATE DATA=iyinope.Ten NORMAL;
VAR bpsystol;
HISTOGRAM bpsystol/NORMAL;
PROBPLOT bpsystol;
RUN;
ODS GRAPHICS OFF;

*we can see 18 extreme outliners, 288 outliers, the distribution is somewhat normal , with mean of 130, median of 128, mode 120, standard deviation of 
   23.3 and interquatile of 28;




*/ QUESTION 2 */;

* we want to test Ha - mean SBP is different from 140. Ho - mean is not different from 140. we are using 1-sample t test 
H0: meanSBP=140
Ha: meanSBP^=140 
P-value from the Student's t test = 0.0001<0.05
Reject H0
Conclude that mean BMI is significantly different from 140 */; 



DATA iyinope.Ten;
SET iyinope.Ten;
PROC MEANS DATA=iyinope.Ten MEAN CLM MAXDEC=2;
VAR bpsystol;
RUN;

PROC UNIVARIATE DATA=iyinope.Ten MU0=140;
VAR bpsystol;
RUN;

ODS GRAPHICS ON;
PROC TTEST DATA=iyinope.Ten H0=140 PLOTS(ONLY)=(SUMMARYPLOT);
VAR bpsystol;
RUN; 
ODS GRAPHICS OFF;






*/ 	QUESTION 3 
Test being used Equality of variance test and 2-sample t test 

Step 1:

Equality of variance test:
H0: varainces are the same
Ha: variances are different
P-value = <0.0001<0.05
Reject H0.
Conclusion - The equal variances assumption is not resaonable/;


DATA iyinope.Ten;
SET iyinope.Ten;
BMI=weight/(height/100)**2;
BMI = ROUND(BMI);
RUN;


DATA iyinope.Ten;
SET iyinope.Ten;
IF hypertension=0 THEN Htensive=2;
ELSE IF hypertension=1 THEN Htensive=1;
RUN;

ODS GRAPHICS ON;
PROC TTEST DATA=iyinope.Ten PLOTS(ONLY) = (SUMMARYPLOT);
CLASS Htensive;
VAR BMI;
RUN;
ODS GRAPHICS OFF;

* Step 2 : 2-sample t test using the equal variance method.
H0: BMI(hypertensive) = BMI(normaltensive)
Ha: BMI(hypertensive)^= BMI(normaltensive)
P-value = <0.0001<0.05
Reject H0.
Conclusion: Hypertensive and Normaltensive have different BMIs./*;




* QUESTION 4*;

ODS GRAPHICS ON;
PROC CORR DATA=iyinope.Ten PLOTS(MAXPOINTS=NONE)=MATRIX(HISTOGRAM);
VAR BMI bpsystol;
RUN;
ODS GRAPHICS OFF;

*/ Relationship between BMI and SBP /*
Pearson Correlation coeffeicient = 0.34882
H0: Rho=0 - there is no correlation.
Ha: Rho^=0 - there is correlation.
P-value <0.0001<0.05
Therefore, Positively correlated. Reject H0.
Conclusion: There is a correlation between BMI and SBP.;


ODS GRAPHICS ON;
PROC REG DATA=iyinope.Ten PLOTS(MAXPOINTS=NONE);
MODEL bpsystol=BMI;
RUN;
QUIT;
ODS GRAPHICS OFF;


*/ Y = b0 + b1*X
Model P-value <0.0001. This regression model is significant. We can use Bmi to predict SBP.
R-Square = 0.1217. 12.17% of variation in SBP can be explained by variataion in SBP.
Intercept p-value <0.0001. The parameter estimate of intercept (88.667) is significantly different from 0.
BMI p-value <0.0001. The parameter estimate of BMI(1.65318) is significantly different from 0.
SLR model: SBP= 88.667+1.65318*BMI

As BMI increases 1 unit, predicted SBP increases 1.7 unit;




*/QUESTION 5 /*;


DATA iyinope.Ten;
SET iyinope.Ten;
     IF bpsystol>=160 or bpdiast>=100 THEN DO; SUBTYPE="4-Stage2";          Prehypertension=0; Stage1Hypertension=0; Stage2Hypertension=1; END;
ELSE IF bpsystol>=140 or bpdiast>=90  THEN DO; SUBTYPE="3-Stage1";          Prehypertension=0; Stage1Hypertension=1; Stage2Hypertension=0; END;
ELSE IF bpsystol>=120 or bpdiast>=60  THEN DO; SUBTYPE="2-Prehypertension"; Prehypertension=1; Stage1Hypertension=0; Stage2Hypertension=0; END;
ELSE IF bpsystol<120 or bpdiast<60    THEN DO; SUBTYPE="1-Normal";          Prehypertension=0; Stage1Hypertension=0; Stage2Hypertension=0; END;
RUN;



*/THERE ARE 3 DUMMIES NEEDED*/;


PROC MEANS DATA=iyinope.Ten N NMISS MIN P25 P50 P75 MEAN STD MAX MAXDEC=2;
CLASS SUBTYPE;
RUN;

PROC FREQ DATA=iyinope.Ten;
TABLE SUBTYPE;
RUN;





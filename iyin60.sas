DM 'out; clear; log; clear';

*/ QUESTION 1 */;


LIBNAME epi6 "C:\Users\iyink\Downloads";
RUN;
DATA New;
SET "C:\Users\iyink\Downloads\hw6.sas7bdat";
ARRAY change (6) HEIGHT1 HEIGHT2 WT1 WT2 WAIST1 WAIST2;
DO i= 1 TO 6;
IF change(i)= 9999 THEN change(i)= .;
END;
DROP i;
RUN;



*/ QUESTION 2 */;


DATA New1;
SET New;
ARRAY change (1) BirthMonth;
Do i= 1;
IF change(i)= . THEN change(i)= 6;
END;
DROP i;
RUN;

DATA New1;
SET New1;
DateofBirth= MDY(BirthMonth,15,BirthYear);
FORMAT DateofBirth mmddyy10.;
RUN;
PROC PRINT DATA=New1 NOOBS;
VAR BirthMonth BirthYear DateOfBirth;
RUN;


* QUESTION 3 */;


DATA New1;
SET New1;
IF CVD^=. & DateOfBirth^=. THEN Age= YRDIF(DateOfBirth,DATEPART(CVD),'ACT/ACT');
Age=ROUND(Age);
RUN;
PROC PRINT DATA=New1;
RUN;



*/ QUESTION 4 */;


DATA New1;
SET New1;
Duration= (TIMEB - TIMEA) / 60;
RUN;



*/ QUESTION 5 */;


DATA New1;
SET New1;
WEIGHT= MEAN(WT1,WT2);
HEIGHT= MEAN(HEIGHT1,HEIGHT2);
BMI= WEIGHT/(HEIGHT/100)**2;
BMI=ROUND(BMI);

*/ QUESTION 6 */;

SBP= MEAN(SBP1,SBP2,SBP3);
DBP= MEAN(DBP1,DBP2,DBP3);
MAP=DBP+(SBP-DBP)/3;
MAP=ROUND(MAP);
RUN;
PROC PRINT DATA=New1;
RUN;



*/ QUESTION 7*/;


PROC MEANS DATA=New1;
VAR DateOfBirth Age Duration BMI MAP;
RUN;






*/ QUESTION 8 */;


DATA New1;
SET New1;
IF Sex= 1 THEN Woman= 0;
ELSE IF Sex= 2 THEN Woman= 1;
RUN;
PROC PRINT DATA=New1;
RUN;



*/ QUESTION 9 */;


DATA New1;
SET New1;
IF BMI=. THEN BMICat=.;
ELSE IF BMI<18.5 THEN BMICat=1;
ELSE IF 18.5<=BMI<25 THEN BMICat=2;
ELSE IF 25<=BMI<30 THEN BMICat=3;
ELSE IF BMI>=30 THEN BMICat=4;

IF BMICat=1 THEN DO; underweight=1; normal=0; overweight=0; END;
IF BMICat=2 THEN DO; underweight=0; normal=1; overweight=0; END;
IF BMICat=3 THEN DO; underweight=0; normal=0; overweight=1; END;
IF BMICat=4 THEN DO; underweight=0; normal=0; overweight=0; END;
RUN;
PROC PRINT DATA=New1;
RUN;

*/ 3 DUMMIES */;


*/ QUESTION 10 */;


PROC FREQ DATA=New1;
tables woman underweight;
tables woman normal;
tables woman overweight;
RUN;

PROC FREQ DATA=New1;
tables woman*underweight;
tables woman*normal;
tables woman*overweight;
RUN;


*/ QUESTION 11 */;
PROC RANK DATA=New1 OUT=New1_rank GROUPS=3;
VAR HEIGHT;
RANKS HEIGHTRANK;
RUN;

PROC FREQ DATA=New1_rank;
table HEIGHTRANK/NOCUM;
RUN;

PROC MEANS DATA=New1_rank MIN MAX MAXDEC=2;
CLASS HEIGHTRANK;
VAR HEIGHT;
RUN;

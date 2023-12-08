DM "out; clear; log; clear;";
DATA B1;
INFORMAT DOB mmddyy10.;

INFILE "C:\Users\iyink\Downloads\fa22_demog.txt" DLM=',' DSD FIRSTOBS=2;

INPUT ID Gender $ AgeOld  Married  Employed  Urban  SBP DOB;

FORMAT DOB mmddyy10.;

RUN;

PROC PRINT DATA=B1;
RUN;

*/ THERE ARE 8 variables and 200 Observations in B1 */;









LIBNAME iyin634 "C:\Users\iyink\Downloads";
RUN;

PROC PRINT DATA=iyin634.Fa22_others;
RUN;


PROC SORT DATA=B1 NODUP; BY ID; RUN;
PROC SORT DATA=iyin634.Fa22_others NODUP; BY ID; RUN;

DATA B2;
MERGE B1(IN=a) iyin634.Fa22_others(IN=b);
BY ID;
IF a=1 OR b=1 THEN OUTPUT B2;
RUN;

PROC PRINT DATA=B2;
RUN;

*/ THERE ARE 14 variables and 200 observations in B2 */;












DATA B2_f;
SET B2;
IF Gender= 'Female' THEN OUTPUT;
RUN;

DATA B2_f1;
SET B2_f;
IF Urban= '1' THEN OUTPUT;
RUN;                                */ this portion is showing me "character values have been converted to numberic values...." and this shouldn't be. So how do I pick observations for the female and Urban=1 variables to output into B2_f. I ran them differently, is that what I should have done?*/ ;

*/ THERE ARE 14 variables and 112 observations in B2_F1 */;














PROC MEANS DATA=B2 n mean std;
CLASS AgeOld;
VAR cho cr hdl_c ldl_c;
RUN;                                               */ then this part output looked like 1 and 0 but I want it to have Ageold as 'Old' for where the out put shows '1' and Young where the MEANS procedure shows '0' */;












PROC FREQ DATA=B2;
TABLE AgeOld*GoodLipid;
RUN;

*/ proportion of those with GoodLipid status 
  For the Old Population = 26/37 (70.27%)
  For the Young Population = 130/155 (83.87%)
  For the Overall Population = 156/192 (81.25%) */;

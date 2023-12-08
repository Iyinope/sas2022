




%MACRO gMcNemar(DSIN = , /* INPUT DATASET*/
ROWV = , /* ROW VARAIBLE NAME */
COLV = , /* COLUMN VARIABLE NAME */
COUNT = ); /* CELL COUNT VARIABLE NAME OF R X R SQUARE TABLE*/
PROC FREQ DATA = &DSIN NOPRINT;
WEIGHT &COUNT;
TABLES &ROWV * &COLV /OUT = FREQ (DROP = PERCENT);
PROC SUMMARY DATA = FREQ;
CLASS &ROWV &COLV;
FREQ COUNT;
OUTPUT OUT = FREQ1 (WHERE = (_TYPE_ > 0 ));
%GLOBAL LEVEL;
PROC SQL NOPRINT;
SELECT MAX(&ROWV) INTO: LEVEL
FROM FREQ1;
QUIT;
DATA TEMP1 (DROP = &ROWV RENAME = (RC = CT) )
TEMP2 (DROP = &COLV RENAME = (RC = RT) ) TEMP3;
SET FREQ1 (DROP = _TYPE_ RENAME = (_FREQ_ = RC) );
IF &ROWV = . AND &COLV NE . THEN OUTPUT TEMP1;
IF &ROWV NE . AND &COLV = . THEN OUTPUT TEMP2;
IF &ROWV NE . AND &COLV NE . THEN OUTPUT TEMP3;
PROC SORT DATA = TEMP1;
BY &COLV;
PROC SORT DATA = TEMP3;
BY &COLV;
DATA TEMP13;
MERGE TEMP3 TEMP1;
BY &COLV;
PROC SORT DATA = TEMP2;
BY &ROWV;
PROC SORT DATA = TEMP13;
BY &ROWV;
DATA TEMP123;
MERGE TEMP13 TEMP2;
BY &ROWV;
IF &ROWV = &COLV THEN VIJ = RT + CT - 2*RC;
DIFF = &ROWV - &COLV;
IF DIFF > 0 THEN SEQ = COMPRESS(&ROWV||&COLV);
ELSE SEQ = COMPRESS(&COLV||&ROWV);
PROC SORT DATA = TEMP123;
BY SEQ;
PROC SQL NOPRINT ;
CREATE TABLE TEMP4 AS
SELECT SEQ, (-1)*SUM(RC) AS VIJ
FROM TEMP123
WHERE DIFF NE 0
GROUP BY SEQ
ORDER BY SEQ;
QUIT;
DATA TEMP4 (DROP = I);
SET TEMP4;
DO I = 1 TO 2;
OUTPUT;
END;
DATA TEMP1234 (KEEP = &ROWV &COLV VIJ);
MERGE TEMP123 TEMP4;
BY SEQ;
IF &ROWV < &LEVEL AND &COLV < &LEVEL;
PROC SORT DATA = TEMP1234;
BY &COLV &ROWV ;
PROC SORT DATA = TEMP1 OUT = TEMP1_1(RENAME = (&COLV = &ROWV));
BY &COLV;
DATA RC;
MERGE TEMP2 TEMP1_1;
BY &ROWV;
D = RT - CT;
IF &ROWV < &LEVEL;
PROC IML;
USE TEMP1234;
READ ALL VAR{VIJ} INTO A;
X = J(&LEVEL - 1,&LEVEL - 1,0); /* CREATE A COLUMN MATRIX OF 1�S */
%DO I = 1 %TO (&LEVEL - 1);
X[,&I] = A[(&LEVEL - 1)*&I - (&LEVEL - 2) : (&LEVEL - 1)*&I, 1];
%END;
INVX = INV(X);
CLOSE TEMP1234;
USE RC;
READ ALL VAR{D} INTO DIJ;
GMN = DIJ` * INVX * DIJ;
DF = &LEVEL - 1;
QCHI95 = CINV(0.95,(&LEVEL - 1));
QCHI99 = CINV(0.99,(&LEVEL - 1));
PROBCHI = 1 - PROBCHI(GMN, (&LEVEL - 1));
PRINT GMN DF PROBCHI, QCHI95 QCHI99;
PROC DATASETS NOLIST KILL LIBRARY = WORK MEMTYPE = ALL;
QUIT;
%MEND;


data cathwk; 
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

%gMcNemar(dsin = cathwk, rowv = r, colv = c, count = count);

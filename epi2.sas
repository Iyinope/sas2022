PROC IMPORT OUT= WORK.piu 
            DATAFILE= "C:\Users\iyink\Downloads\PS2_SP2023.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

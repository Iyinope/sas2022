PROC IMPORT OUT= WORK.this 
            DATAFILE= "C:\Users\iyink\Downloads\intake.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

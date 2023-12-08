PROC IMPORT OUT= WORK.intake1 
            DATAFILE= "C:\Users\iyink\Downloads\intake.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

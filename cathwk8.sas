data seeds;
infile 'C:\Users\iyink\Downloads\seeds.dat' firstobs=2;
input pot n r cult soil;

proc print data=seeds;
run;

proc freq data=seeds;
table n r;
run; 

proc logistic data=seeds;
class cult (ref='0') soil (ref='0') / param =ref;
model r/n = cult | soil
/ link = logit scale = none lackfit;
run;

proc logistic data=seeds;
class cult (ref='0') soil (ref='0') / param =ref;
model r/n = cult | soil
/ link = logit scale = pearson lackfit;
run;

proc logistic data=seeds;
class cult (ref='0') soil (ref='0') / param =ref;
model r/n = cult | soil
/ link = logit scale = williams lackfit;
run;

data child;
set 'C:\Users\iyink\Downloads\child_ill.sas7bdat';
run;

proc print data=child;
run;


data child_;
set child;
n_ill = num_ill;
if num_ill = 0 then n_ill = 1;
if num_ill = 1 then n_ill = 2;
if num_ill = 2 then n_ill = 2;
if num_ill >= 3 then n_ill = 3;

if gender = 'm' then gender = 1
run; 

proc print data=child_;
run;



PROC LOGISTIC DATA=child DESCENDING;
CLASS gender/ PARAM=ref;
MODEL n_ill = gender / LINK = gLOGIT ;
contrast "gender 1 vs 3" gender 1;
gender_1v3: test gender1_2=gender1_1=0;
gender_all: test gender1_2=gender1_1=0, gender2_2=gender2_1=0;
contrast "gender 2 vs 3" gender 0 1;
contrast "gender 1 vs 2" gender 1 -1;
gender_1v2: test gender1_2-gender2_2=0, gender2_1=gender1_1;
contrast "gender" gender 1 , gender 0 1;
estimate "gender 1" intercept 1 gender 1;
estimate "gender 1" intercept 1 gender 1/CATEGORY='1';
gender_dep0v2: test gender2_1=gender1_1=0;
RUN;

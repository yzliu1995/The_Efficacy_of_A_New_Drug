LIBNAME final '/rhome/yl499/714/final'; 
FILENAME newdata '/rhome/yl499/714/final/final.dat'; 
run; 
 
ODS RTF FILE="/rhome/yl499/714/final/final.rtf" STYLE=PearlJ; 
ODS listing; 
run; 
 
*read in data; 
DATA final.newdata; 
INFILE newdata; 
INPUT initial months6 months12 gender treatment count; 
run; 
 
proc format; 
value severity 
1 = 'least severe' 
2 = 'initial severity 2' 
3 = 'initial severity 3' 
; 
value gender 
1 = 'Male' 
0 = 'Female'; 
value trt 
1 = 'Drug' 
0 = 'Place'; 
run; 
 
proc sort data=final.newdata; 
by descending months12 descending months6 descending gender  
descending treatment descending initial; 
run; 
 
*check proportional assumptions first; 
proc catmod data=final.newdata order=data; 
weight count; 
population gender treatment initial; 
response clogit; 
model months12*months6 = gender treatment _response_ initial 
gender*treatment gender*_response_ gender*initial treatment*_response_ treatment*initial initial*_response_  
gender*treatment*_response_ gender*treatment*initial gender*initial*_response_ 
treatment*initial*_response_ gender*treatment*initial*_response_/design; 
repeated occassion 2/_response_=occassion; 
run; 
 
*Marginal cumulative logit model with proportional assumption; 
 
*variable selection; 
*keep gender*treatment*occasion treatment*initial*occasion; 
*keep gender*treatment gender*occasion treatment*occassion treatment*initial initial*occassion; 
*check proportional assumptions first; 
proc catmod data=final.newdata order=data; 
weight count; 
population gender treatment initial; 
response clogit; 
model months12*months6 = gender treatment _response_ initial 
gender*treatment gender*_response_ treatment*_response_ treatment*initial initial*_response_  
gender*treatment*_response_ treatment*initial*_response_ /design; 
repeated occassion 2/_response_=occassion; 
contrast 'test for porportionailty in sex' all_parms 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
contrast 'test for porportionailty in treatment' all_parms 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
contrast 'test for porportionailty in occasion' all_parms 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
contrast 'test for porportionailty in initial' all_parms 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
contrast 'test for porportionailty in sex*treatment' all_parms 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0; 
contrast 'test for porportionailty in sex*occasion' all_parms 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0; 
contrast 'test for porportionailty in treatment*occasion' all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0; 
contrast 'test for porportionailty in treatment*initial' all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0; 
contrast 'test for porportionailty in occasion*initial' all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0; 
contrast 'test for porportionailty in gender*treatment*occassion' all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0; 
contrast 'test for porportionailty in treatment*initial*occassion' all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1; 
contrast 'test for overall proportionality'  
all_parms 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0,  
all_parms 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0,  
all_parms 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0, 
all_parms 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0, 
all_parms 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0, 
all_parms 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0, 
all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0, 
all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0, 
all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0, 
all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0, 
all_parms 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1; 
run; 
 
 
*keep proportional assumption; 
*not having proportional assumption, give more betas; 
*sex occasion treatment*occasion; 
*gender treatment _response_ initial 
gender*treatment gender*_response_ treatment*_response_ treatment*initial initial*_response_  
gender*treatment*_response_ treatment*initial*_response_; 
proc catmod data=final.newdata order=data; 
weight count; 
population gender treatment initial; 
response clogit; 
model months12*months6 =  
( 
1 0 1 0 1 1 0 1 1 1 1 0 1 1 1 1, 
0 1 0 1 1 0 1 1 1 1 0 1 1 1 1 1, 
1 0 1 0 1 -1 0 1 1 -1 -1 0 1 -1 -1 -1, 
0 1 0 1 1 0 -1 1 1 -1 0 -1 1 -1 -1 -1, 
 
1 0 1 0 1 1 0 -1 1 1 1 0 -1 -1 1 -1, 
0 1 0 1 1 0 1 -1 1 1 0 1 -1 -1 1 -1, 
1 0 1 0 1 -1 0 -1 1 -1 -1 0 -1 1 -1 1, 
0 1 0 1 1 0 -1 -1 1 -1 0 -1 -1 1 -1 1, 
 
1 0 1 0 -1 1 0 1 -1 1 -1 0 -1 1 -1 -1, 
0 1 0 1 -1 0 1 1 -1 1 0 -1 -1 1 -1 -1, 
1 0 1 0 -1 -1 0 1 -1 -1 1 0 -1 -1 1 1, 
0 1 0 1 -1 0 -1 1 -1 -1 0 1 -1 -1 1 1, 
 
1 0 1 0 -1 1 0 -1 -1 1 -1 0 1 -1 -1 1, 
0 1 0 1 -1 0 1 -1 -1 1 0 -1 1 -1 -1 1, 
1 0 1 0 -1 -1 0 -1 -1 -1 1 0 1 1 1 -1, 
0 1 0 1 -1 0 -1 -1 -1 -1 0 1 1 1 1 -1, 
 
1 0 -1 0 1 1 0 1 -1 -1 1 0 1 1 -1 1, 
0 1 0 -1 1 0 1 1 -1 -1 0 1 1 1 -1 1, 
1 0 -1 0 1 -1 0 1 -1 1 -1 0 1 -1 1 -1, 
0 1 0 -1 1 0 -1 1 -1 1 0 -1 1 -1 1 -1, 
 
1 0 -1 0 1 1 0 -1 -1 -1 1 0 -1 -1 -1 -1, 
0 1 0 -1 1 0 1 -1 -1 -1 0 1 -1 -1 -1 -1, 
1 0 -1 0 1 -1 0 -1 -1 1 -1 0 -1 1 1 1, 
0 1 0 -1 1 0 -1 -1 -1 1 0 -1 -1 1 1 1, 
 
1 0 -1 0 -1 1 0 1 1 -1 -1 0 -1 1 1 -1, 
0 1 0 -1 -1 0 1 1 1 -1 0 -1 -1 1 1 -1, 
1 0 -1 0 -1 -1 0 1 1 1 1 0 -1 -1 -1 1, 
0 1 0 -1 -1 0 -1 1 1 1 0 1 -1 -1 -1 1, 
 
1 0 -1 0 -1 1 0 -1 1 -1 -1 0 1 -1 1 1, 
0 1 0 -1 -1 0 1 -1 1 -1 0 -1 1 -1 1 1, 
1 0 -1 0 -1 -1 0 -1 1 1 1 0 1 1 -1 -1, 
0 1 0 -1 -1 0 -1 -1 1 1 0 1 1 1 -1 -1      
) 
(1 2 ='cutpoints', 3 4 = 'sex', 5= 'treatment', 6 7 = 'occasion', 8 = 'initial', 
9 = 'sex*treatment',10 = 'sex*occasion', 11 12 = 'treatment*occasion', 13 = 'treatment*initial', 
14= 'occasion*initial', 15 = 'sex*treatment*occasion',16 = 'treatment*occasion*initial')/design oneway; 
 
* treatment effects; 
contrast '(1+2)/3 active vs placebo at months 6 at initial 2 for female'  
all_parms 0 0 0 0 2 0 0 0 -2 0 -2 0 -2 0 2 2/est=exp; 
contrast '1/(2+3) active vs placebo at months 6 at initial 2 for female'  
all_parms 0 0 0 0 2 0 0 0 -2 0 0 -2 -2 0 2 2/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 12 at initial 2 for female'  
all_parms 0 0 0 0 2 0 0 0 -2 0 2 0 -2 0 -2 -2/est=exp; 
contrast '1/(2+3) active vs placebo at months 12 at initial 2 for female'  
all_parms 0 0 0 0 2 0 0 0 -2 0 0 2 -2 0 -2 -2/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 6 at initial 3 for female'  
all_parms 0 0 0 0 2 0 0 0 -2 0 -2 0 2 0 2 -2/est=exp; 
contrast '1/(2+3) active vs placebo at months 6 at initial 3 for female'  
all_parms 0 0 0 0 2 0 0 0 -2 0 0 -2 2 0 2 -2/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 12 at initial 3 for female'  
all_parms 0 0 0 0 2 0 0 0 -2 0 2 0 2 0 -2 2/est=exp; 
contrast '1/(2+3) active vs placebo at months 12 at initial 3 for female'  
all_parms 0 0 0 0 2 0 0 0 -2 0 0 2 2 0 -2 2/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 6 at initial 2 for male'  
all_parms 0 0 0 0 2 0 0 0 2 0 -2 0 -2 0 -2 2/est=exp; 
contrast '1/(2+3) active vs placebo at months 6 at initial 2 for male'  
all_parms 0 0 0 0 2 0 0 0 2 0 0 -2 -2 0 -2 2/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 12 at initial 2 for male'  
all_parms 0 0 0 0 2 0 0 0 2 0 2 0 -2 0 2 -2/est=exp; 
contrast '1/(2+3) active vs placebo at months 12 at initial 2 for male'  
all_parms 0 0 0 0 2 0 0 0 2 0 0 2 -2 0 2 -2/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 6 at initial 3 for male'  
all_parms 0 0 0 0 2 0 0 0 2 0 -2 0 2 0 -2 -2/est=exp; 
contrast '1/(2+3) active vs placebo at months 6 at initial 3 for male'  
all_parms 0 0 0 0 2 0 0 0 2 0 0 -2 2 0 -2 -2/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 12 at initial 3 for male'  
all_parms 0 0 0 0 2 0 0 0 2 0 2 0 2 0 2 2/est=exp; 
contrast '1/(2+3) active vs placebo at months 12 at initial 3 for male'  
all_parms 0 0 0 0 2 0 0 0 2 0 0 2 2 0 2 2/est=exp; 
 
 
*after treatment months 12 vs. months 6; 
contrast '(1+2)/3 months 12 vs months 6 trt = 1 for female at initial 2'  
all_parms 0 0 0 0 0 2 0 0 0 -2 2 0 0 -2 -2 -2/est=exp; 
contrast '1/(2+3) months 12 vs months 6 trt = 1 for female at initial 2'  
all_parms 0 0 0 0 0 0 2 0 0 -2 0 2 0 -2 -2 -2/est=exp; 
 
contrast '(1+2)/3 months 12 vs months 6 trt = 1 for female at initial 3'  
all_parms 0 0 0 0 0 2 0 0 0 -2 2 0 0 2 -2 2/est=exp; 
contrast '1/(2+3) months 12 vs months 6 trt = 1 for female at initial 3'  
all_parms 0 0 0 0 0 0 2 0 0 -2 0 2 0 2 -2 2/est=exp; 
 
contrast '(1+2)/3 months 12 vs months 6 trt = 1 for male at initial 2'  
all_parms 0 0 0 0 0 2 0 0 0 2 2 0 0 -2 2 -2/est=exp; 
contrast '1/(2+3) months 12 vs months 6 trt = 1 for male at initial 2'  
all_parms 0 0 0 0 0 0 2 0 0 2 0 2 0 -2 2 -2/est=exp; 
 
contrast '(1+2)/3 months 12 vs months 6 trt = 1 for male at initial 3'  
all_parms 0 0 0 0 0 2 0 0 0 2 2 0 0 2 2 2/est=exp; 
contrast '1/(2+3) months 12 vs months 6 trt = 1 for male at initial 3'  
all_parms 0 0 0 0 0 0 2 0 0 2 0 2 0 2 2 2/est=exp; 
 
*sex effects after treatment months 12 vs. months 6; 
contrast '(1+2)/3 months 12 vs months 6 trt = 1 for male vs female at initial 2' 
all_parms 0 0 0 0 0 0 0 0 0 4 0 0 0 0 4 0/est=exp; 
contrast '1/(2+3) months 12 vs months 6 trt = 1 for male vs female at initial 2' 
all_parms 0 0 0 0 0 0 0 0 0 4 0 0 0 0 4 0/est=exp; 
 
contrast '(1+2)/3 months 12 vs months 6 trt = 1 for male vs female at initial 3'  
all_parms 0 0 0 0 0 0 0 0 0 4 0 0 0 0 4 0/est=exp; 
contrast '1/(2+3) months 12 vs months 6 trt = 1 for male vs female at initial 3'  
all_parms 0 0 0 0 0 0 0 0 0 4 0 0 0 0 4 0/est=exp; 
 
*sex effects; 
contrast '(1+2)/3 active vs placebo at months 6 at initial 2 for male vs female'  
all_parms 0 0 0 0 0 0 0 0 4 0 0 0 0 0 -4 0/est=exp; 
contrast '1/(2+3) active vs placebo at months 6 at initial 2 for male vs female'  
all_parms 0 0 0 0 0 0 0 0 4 0 0 0 0 0 -4 0/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 12 at initial 2 for male vs female'  
all_parms 0 0 0 0 0 0 0 0 4 0 0 0 0 0 4 0/est=exp; 
contrast '1/(2+3) active vs placebo at months 12 at initial 2 for male vs female'   
all_parms 0 0 0 0 0 0 0 0 4 0 0 0 0 0 4 0/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 6 at initial 3 for male vs female'  
all_parms 0 0 0 0 0 0 0 0 4 0 0 0 0 0 -4 0/est=exp; 
contrast '1/(2+3) active vs placebo at months 6 at initial 3 for male vs female'  
all_parms 0 0 0 0 0 0 0 0 4 0 0 0 0 0 -4 0/est=exp; 
 
contrast '(1+2)/3 active vs placebo at months 12 at initial 3 for male vs female'  
all_parms 0 0 0 0 0 0 0 0 4 0 0 0 0 0 4 0/est=exp; 
contrast '1/(2+3) active vs placebo at months 12 at initial 3 for male vs female'  
all_parms 0 0 0 0 0 0 0 0 4 0 0 0 0 0 4 0/est=exp; 
 
*occasion effects; 
contrast '(1+2)/3 active vs placebo at initial 2 for female at months 12 vs months 6'  
all_parms 0 0 0 0 0 0 0 0 0 0 4 0 0 0 -4 -4/est=exp; 
contrast '1/(2+3) active vs placebo at initial 2 for female at months 12 vs months 6'  
all_parms 0 0 0 0 0 0 0 0 0 0 4 0 0 0 -4 -4/est=exp; 
 
contrast '(1+2)/3 active vs placebo at initial 3 for female at months 12 vs months 6'  
all_parms 0 0 0 0 0 0 0 0 0 0 4 0 0 0 -4 4/est=exp; 
contrast '1/(2+3) active vs placebo at initial 3 for female at months 12 vs months 6'  
all_parms 0 0 0 0 0 0 0 0 0 0 0 4 0 0 -4 4/est=exp; 
 
contrast '(1+2)/3 active vs placebo at initial 2 for male at months 12 vs months 6'  
all_parms 0 0 0 0 0 0 0 0 0 0 4 0 0 0 4 -4/est=exp; 
contrast '1/(2+3) active vs placebo at initial 2 for male at months 12 vs months 6'  
all_parms 0 0 0 0 0 0 0 0 0 0 0 4 0 0 4 -4/est=exp; 
 
contrast '(1+2)/3 active vs placebo at initial 3 for male at months 12 vs months 6'  
all_parms 0 0 0 0 0 0 0 0 0 0 4 0 0 0 4 4/est=exp; 
contrast '1/(2+3) active vs placebo at initial 3 for male at months 12 vs months 6'  
all_parms 0 0 0 0 0 0 0 0 0 0 0 4 0 0 4 4/est=exp; 
 
run;

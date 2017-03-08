data hmk07;
	input gpa test black hispanic;
	datalines;
3.0 5.5 0 0
2.3 4.8 0 0
3.0 4.7 1 0
1.9 3.9 1 0
2.5 4.5 1 0
3.7 6.2 0 1
3.5 6.0 0 1
2.6 5.2 0 0
2.8 4.7 1 0
1.6 4.3 0 0
2.0 4.9 0 0
2.9 5.4 0 1
2.3 5.0 0 0
3.2 6.3 0 1
1.8 4.6 0 0
1.4 4.3 0 0
2.0 5.0 1 0
3.8 5.9 0 1
2.2 4.1 0 0
1.5 4.7 0 0
;

ods graphics on;
proc reg data=hmk07 plots(only)=none alpha=0.5;
	title 'Dummy Coding of Ethnicity';
	model gpa = test black hispanic / p r covb;
	output out=hmk07res residual=res rstudent=sres predicted=pre; 
run;
proc univariate data=hmk07res plots(only)=FITPLOT;
	var sres;
run;
ods graphics off;
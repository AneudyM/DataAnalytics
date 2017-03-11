data hmk7;
	input gpa test ethnic;
	/* Segmentation for Dummy Coding */
	if ethnic = 0 then white = 0;
	if ethnic in (1,2) then white = 0;
	if ethnic = 1 then black = 1;
	if ethnic in (0,2) then black = 0;
	if ethnic = 2 then hispanic = 1;
	if ethnic in (0,1) then hispanic = 0;

	/* Interaction between ethnicity and test scores */
	test_white = white * test;
	test_black = blak * test;
	test_hispanic = hispanic * test;
	
	/* Raw data */
	datalines;
	3.0 5.5 0
	2.3 4.8 0
	3.0 4.7 1
	1.9 3.9 1
	2.5 4.5 1
	3.7 6.2 2
	3.5 6.0 2
	2.6 5.2 0
	2.8 4.7 1
	1.6 4.3 0
	2.0 4.9 0
	2.9 5.4 2
	2.3 5.0 0
	3.2 6.3 2
	1.8 4.6 0
	1.4 4.3 0
	2.0 5.0 1
	3.8 5.9 2
	2.2 4.1 0
	1.5 4.7 0
	;
	/* Assigning labels to the levels of the ethnic variable */
	proc format;
		value ethnf 0 = "White" 1 = "Black" 2 = "Hispanic";
	run;
run;
/* Getting descriptive statistics */
proc means mean std data=hmk7;
	format ethnic ethnf.;
	class ethnic;
run;
ods graphics on;	* Needed for SAS University Edition to generate graphs;
/* Perform Regression Analysis */
proc reg data=hmk7 plots(only)=none;
	title 'Regression Analysis to Predict GPA';
	model gpa = test black hispanic / r covb;
	output out=diagnostics predicted=pre rstudent=res;
run;
ods graphics off;

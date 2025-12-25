/*** HELP START ***//*

Macro:     typ_dataset_csv  
 Purpose:   Extract rows from a SAS dataset based on a WHERE condition and output the values in a CSV-like format that can be directly embedded into a Typst table().  
 Parameters:  
   ds       = Input SAS dataset name  
   wh       = WHERE condition to filter observations (use %nrbquote if needed)  
   varlist  = List of variables to output (space-delimited)  
 Details:  
   Outputs comma-separated values suitable for Typst tables  
 Data Handling:  
   All values are quoted  
   Double quotation marks (") inside character variables are replaced with Unicode right double quotation mark (U+201D)  
   A warning is issued if such replacement occurs  

Useage:  
 %typ_dataset_csv(ds=sashelp.class,wh=%nrbquote(AGE<=15),varlist=NAME AGE SEX WEIGHT)

*//*** HELP END ***/

%macro typ_dataset_csv(ds=,wh=,varlist=);
%let varlist=%sysfunc(compbl(&varlist));
%let varnum = %sysfunc( count( &varlist, %str ( ) ))+1;
%do i = 1 %to &varnum+1;
 %local  var&i ;
 %let var&i =  %sysfunc(scan( &varlist,&i, %str ( ) ));
 %put &&var&i;
%end;
%macro dloop;
  %do i =1 %to &varnum;
	  call symputx(cats("mvar&i._",_N_),quote(strip(vvalue(&&var&i))));
  %end;
%mend;
%let _rc = %sysfunc(dosubl(%str(
data tmp;
 set &ds;
 where &wh;
run;
data _NULL_;
  if 0 then set tmp nobs=NOBS;
  call symputx("yobs", NOBS);
  stop;
run;
data _null_;
 set tmp;
 dum="";
 array ch _character_;
 do over ch;
  if index(ch,'"') then put "WARNING:Double quotation marks were found within variables, and Unicode conversion processing will be performed. Please ensure the original dataset's length has sufficient margin." +2 ch=;
  ch =tranwrd(ch,'"',"\u{201D}");
 end;
 %dloop;
run;
)));
%do h=1 %to &yobs.;
 %do i = 1 %to &varnum;
&&mvar&i._&h,
  %symdel mvar&i._&h ;
 %end;
%end;
%mend;

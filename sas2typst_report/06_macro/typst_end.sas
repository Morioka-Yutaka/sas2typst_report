/*** HELP START ***//*

Macro:     typst_end  
 Purpose:   Finalize Typst source file generation and properly close PROC STREAM output.  
 Details:  
   Terminates PROC STREAM using explicit delimiter (;;;;)  
   Clears the associated FILENAME reference  
   Must be used in conjunction with typst_start  
 Notes:  
   Always call this macro to ensure a valid Typst file

*//*** HELP END ***/

%macro typst_end();
;;;;
run;
filename typout clear;
%mend;

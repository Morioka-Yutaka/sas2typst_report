/*** HELP START ***//*

Macro:     typst_start  
 Purpose:   Initialize Typst source file generation using PROC STREAM and prepare the output environment.  
 Parameters:  
   outdir   = Output directory (currently not used)  
   outfile  = Name of the Typst output file (default: sample.typ)  
 Global Macro Variables:  
   nw       = Line break token for Typst output.
 Note: In general, native Typst code can be written directly as-is. However, due to Typst syntax requirements, explicit line breaks must be inserted using &nw at positions where a line break is required.  
 Usage:  
   %typst_start(outfile=my_listing.typ);  
     <Typst source code>  
   %typst_end();

*//*** HELP END ***/

%macro typst_start(outdir = ., outfile=sample.typ);
filename typout "&outdir\&outfile." lrecl=32767 encoding="utf-8";
%global nw;
%let nw=__ NEWLINE;
proc stream outfile=typout resetdelim="__";
begin
%mend;

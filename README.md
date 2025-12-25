# sas2typst_report
sas2typst_report is a SAS macro package that enables direct generation of Typst (.typ) files from within SAS. Typst is a modern, declarative typesetting system designed for fast and precise document layout. This package allows users to write native Typst code inline in SAS programs and seamlessly stream SAS dataset contents into Typst tables.

<img width="317" height="303" alt="image" src="https://github.com/user-attachments/assets/bb5e718a-d596-4dc3-bfb9-52616091a822" />

~~~sas
data ADSL;
length SUBJID SITEID REGION $200. AGE 8. SEX RACE ETHNIC $200. ; 
SUBJID="101-301"; SITEID="101"; REGION="North America"; AGE=57;SEX= "F";RACE= "White";ETHNIC="Not Hispanic or Latino"; WEIGHTBL=58.1; HEIGHTBL=160.8;output;
SUBJID="102-303"; SITEID="102"; REGION="North America"; AGE=61;SEX= "M";RACE= "White";ETHNIC="Not Reported"; WEIGHTBL=104.9; HEIGHTBL=188.0;output;
SUBJID="111-303"; SITEID="111"; REGION="North America"; AGE=43;SEX= "M";RACE= "White";ETHNIC="Not Hispanic or Latino"; WEIGHTBL=85.5; HEIGHTBL=182.5;output;
run;
~~~
<img width="724" height="78" alt="image" src="https://github.com/user-attachments/assets/0c7e9441-058d-4329-a65d-ce5ac09752ad" />

~~~sas
%typst_start(outdir = D:\Users\10089669\Desktop\clibor, outfile=Listing_1_1.typ)
#set page(paper: "a4", flipped: true,
  header: [#grid(columns: (1fr, 1fr), align: top,
    [#align(left)[Protocol: ABC-123]],
    [#align(right)[Page #context counter(page).display()]],
  )],
)
&nw;

= Listing 1. Demographics and Baseline Characteristics
&nw;

#text(size: 10pt)[Safety Analysis Population]
&nw;

#table(
  columns: (
    18mm,
    10mm,
    28mm,
    15mm,
    10mm,
    18mm,
    52mm,
    26mm,
    26mm 
  ),
  stroke: none,

  table.header(
    table.hline(stroke: 1pt + black),
    "Subject",
     "Site",
     "Region",
     "Age (years)",
     "Sex",
    "Race",
    "Ethnic",
     "Baseline Weight~(kg)", 
     "Baseline Height~(cm)",
    table.hline(stroke: 1pt + black),
  ),

%typ_dataset_csv(ds=ADSL,wh=%nrbquote(SEX="M"),varlist=SUBJID SITEID REGION AGE SEX RACE ETHNIC WEIGHTBL HEIGHTBL)

  table.footer(
    table.hline(stroke: 1pt + black),
  ),
)
#v(-15pt)
#text(size: 8pt)[
Age is calculated at baseline.
#par()[Baseline weight/height are measured at Visit 1 (Day 1).]
]
%typst_end();
~~~
Listing_1_1.typ
<img width="1693" height="256" alt="image" src="https://github.com/user-attachments/assets/164119df-58cf-4acf-b742-0f19565996ed" />

The generated .typ file can be previewed using the web-based viewer, from which you can also download the output as a PDF.  
https://typst.app/play/
<img width="1879" height="499" alt="image" src="https://github.com/user-attachments/assets/7adcf1be-ffbc-48aa-87a7-dcc7a4bc4a22" />

Alternatively, after installing Typst via the Command Prompt or PowerShell using
~~~text
typst compile sample.typListing_1_1.typ
~~~

you can generate a PDF file by running
~~~text
typst compile Listing_1_1.typ
~~~
<img width="178" height="54" alt="image" src="https://github.com/user-attachments/assets/e812d125-8d56-46d3-9145-11fbf6bd6225" />

<img width="783" height="256" alt="image" src="https://github.com/user-attachments/assets/c0b71ebd-2e87-489e-a7f6-010b88272cda" />  
  
on your local machine.

For installation methods on operating systems other than Windows, as well as various ways to run Typst, please refer to the official documentation:
https://typst.app/docs/


## `%typst_start()` macro <a name="typststart-macro-3"></a> ######

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

  
---

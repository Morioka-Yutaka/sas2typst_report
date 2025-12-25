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
#set page(
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
<img width="1709" height="221" alt="image" src="https://github.com/user-attachments/assets/b20248a6-1473-44fe-bffd-0007970cad05" />

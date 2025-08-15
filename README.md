# Polygenic Risk Scoring for ASD 
Here is some of the source code I used for my MDS Capstone project at the University of Michigan. This repo will be subject to occasional updates to fix bugs in my code or add new information. 

## Data sets and sampling  

[Saudi Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE221098)
- Cases: n = 22
- Controls: n = 51 

[Japanese Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE144918) & [Converted PLINK binary format](https://drive.google.com/drive/folders/1lvV8p_2tUnx8iuFxe6-sSpm8CBmYSJs4) - credit to Genarchivist forum user teepean 
- Cases: n = 68
- Controls: n = 124

[LaSalle Dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi)
- Cases: n = 29
- Controls: n = 26

## Cloud Computing Resources ☁️

- Great Lakes: I found this cluster to be especially useful when working with command lines (see next section), particularly with PLINK.
- Galaxy: This solves the issue of waiting for hours for your Python or R job to start in Great Lakes! You can sign up with your university (or any other) Google account and get 250 GB of free storage. Galaxy includes R (4.4) and Bioconductor (3.12), which saves the trouble of installing Bioconductor dependencies on your Great Lakes cluster. 

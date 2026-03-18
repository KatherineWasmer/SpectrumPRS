# Polygenic Risk Scoring for ASD 

My independent study examined the predictive power of polygenic risk scoring for autism, using 119 cases and 201 controls. 

### [Download Final Report](https://katherinewasmer.github.io/papers/Capstone_Report.pdf) 

⚠️ **Project Status:** This repository is under active development to ensure proper documentation and reproducibility of the entire machine learning pipeline. The analyses and results for the project can be found in the Final Report.

## Repository Structure

```
SpectrumPRS/
│
├── data/         
|   ├── hdgp_ref 
|   ├── study_samples.md            
├── notebooks/    
|   ├── exploratory_PRS.ipynb    
├── src/                 
│   ├── preprocessing   
│   ├── features
│   ├── models
│   └── evaluation
├── scripts/     # command line scripts to use         
├── results/     # model outputs       
└── README.md
```

`data/hgdp_ref:` Contains a comparative reference panel from the Human Genome Diversity Project, which was used to help estimate the admixture for the American samples. 

`data/study_samples.md:` Contains information on the samples in the study. 

`notebook/exploratory_PRS.ipynb:` Before exploring the different methods for calculating the PRS, I ran a sample experiment on the Michigan Imputation Server (v2) with a random set of samples from the HGDP project. This shows the expected distribution of scores given a random sample, but the samples did not contain phenotypes for evaluating predictive power. 

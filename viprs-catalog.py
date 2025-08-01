import viprs as vp
import magenpy as mgp
import pandas as pd
import numpy as np

# set random seed for consistency 
np.random.seed(42) 

# rename data columns, fix allele casing, etc. 
def clean_gwas_cat(catTSV: str):
  '''Reads in a .tsv file downloaded from GWASCatalog and converts it into a format compatible with VIPRS and magenpy. 
  TXT files are also acceptable. 

  Parameters: 
  catTSV -- The GWAS summary statistics file, which can be downloaded from the FTP hyperlink on the "Studies" page of 
  the trait you want to study (second tab from the left). 
  '''
  catTSV["SNP"] = catTSV["MarkerName"].str.split("_").str.get(1)
  catTSV["Allele1"] = catTSV["Allele1"].str.upper() 
  catTSV["Allele2"] = catTSV["Allele2"].str.upper()
  catTSV = catTSV.drop(columns=["MarkerName", "Direction"])
  catTSV = catTSV.rename(columns={'Allele1': 'A1', 
                                'Allele2': 'A2', 
                                'Position': 'POS', 
                                'Chromosome': 'CHR', 
                                'TotalSampleSize': 'N',
                                'Effect': 'BETA',
                                'StdErr': 'SE',
                                'P-value': 'P'})
  return catTSVFixed

def split_TSV_by_chromosome(catTSVFixed: str):
  '''
  VIPRS only calculates the PRS for a single chromosome, so you must split the GWAS files to avoid 
  an inter-chromosome LD error. This splits and downloads TSV files for all autosomes. Files will 
  show up in your current directory. 

  Parameters: 
  catTSVFixed -- The cleaned GWAS catalog file in VIPRS-friendly format. Can also have .txt extension. 
  '''
  for i in range(1, 23): 
    catTSVFixed[catTSVFixed["CHR"] == i].to_csv(f"chr{i}_{catTSVFixed}", sep=" ", index=False)

def get_bayesian_PRS(chrom: int, bed: str, stats: str):
  '''Returns the bayesian PRS array for a single chromosome. Can be looped for every chromosome'''
  gdl = mgp.GWADataLoader(bed_files = bed, sumstats_files = stats, sumstats_format = "GWASCatalog")
  gdl.compute_ld(estimator="sample", output_dir="output")
  v = vp.VIPRS(gdl)
  v.fit()
  results = v.predict()
  return results 
  

import glob
import pandas as pd

# set random seed for consistency 
np.random.seed(42) 

# Data cleaning and handling 

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
  return catTSV

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

# Computing PRS 


def get_PRS_files(filePath: str) -> list:
    '''Returns a list of data frames for each .prs file in the directory. File path should
    have the format results/*.prs'''
    all_files = glob.glob(filePath)
    df_files = []
    for f in all_files:
        myFile = pd.read_csv(f, sep="\t")
        newName = f.split("_")[2]
        myFile = myFile.rename(columns={"PRS": newName})
        df_files.append(myFile)
    return df_files

def get_PRS_df(filePath: str) -> pd.DataFrame: 
    '''Reads in the PRS for each chromosome and assigns it to an identifiable column name.
    Returns a data frame of 22 scores with corresponding IDs.
    
    Parameters: 
    filePath: The directory for all of your prs files. 
    Should have the pattern path-to-directory/*.prs
    '''
    df_files = get_PRS_files(filePath)
    merged = pd.concat(df_files, axis=1)
    # filters out excessive columns 
    prs = merged.filter(like=".prs")
    # subset IIDs from the original data frame
    IDs = pd.DataFrame(merged.iloc[:, 1]) 
    df_prs = pd.concat([IDs, prs], axis=1)
    return df_prs

def get_PRS_df_with_phenotype(filePath: str, famFile: str) -> pd.DataFrame: 
    '''Reads in the PRS for each chromosome and assigns it to an identifiable column name.
    Returns a data frame of 22 scores with corresponding IDs and phenotypes. 
    
    Parameters: 
    filePath - The directory for all of your prs files. Should have the pattern path-to-directory/*.prs
    famFile - Can be any of the .fam files generated for your VIPRS training. Should have the format {myPop}.fam
    '''
    # extracts the phenotype column from the fam file (5th col)
    df_prs = get_PRS_df(filePath)
    pheno = pd.read_csv(famFile, sep=" ", header=None).iloc[:, 5]
    df_w_pheno = pd.concat([df_prs, pheno], axis=1)
    # rename phenotype column for clarity 
    df_w_pheno = df_w_pheno.rename(columns={5: 'pheno'})
    return df_w_pheno

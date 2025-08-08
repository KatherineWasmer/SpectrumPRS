import glob
import pandas as pd

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

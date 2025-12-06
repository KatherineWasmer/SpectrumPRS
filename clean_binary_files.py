# Helper functions for PLINK/vcf data handling 
import pandas as pd 

def remove_underscores_from_ids(id_with_underscores: str) -> str:
    '''Removes any underscores from the individual ids in the .fam file

    Parameters: 
    id_with_underscores: An identifier containing underscores, which is not compatible with vcf data. 
    
    Examples: GSM4300828_13HI5K-048_GenomeWideSNP_6 -> GSM4300828
    '''
    ids = id_with_underscores.split("_") 
    return ids[0]

def correct_fam_file(my_file) -> None:
  '''If the individual ids in the .fam file contain underscores, you cannot effectively convert plink binary to vcf. 

  Parameters: 
  my_file: The .fam file that needs to have underscores removed. We can treat this file like reading in any other csv file in pandas. 
  Since .fam files do not have headers, the columns will be read in as 0, ..., 6 in pandas. 
  '''
  fam_df = pd.read_csv(my_file, sep = " ", header = None)
  fam_df["id"] = fam_df.iloc[:, 1].apply(get_new_ids) # create a dummy column for new ids 
  fam_df.iloc[:, 1] = fam_df["id"] # replace column 1 ids with the new ids 
  fam_df = fam_df.drop(columns="id") # drop the dummy column
  fam_df.to_csv(my_file, header = False, index = False, sep = " ") # replaces old .fam file with new .fam file 
  
def get_hg38_bim(old_bim: str, liftover_output: str, new_bim: str):
    '''This function is used to lift over a .bim file 
    in hg19/GrCh37 format to the more recent hg38/
    GrCh38 build. Returns a .bim file in the PLINK 
    binary format that can be used for statistical tests 
    and analyses. 
    
    Parameters:
    old_bim -- The .bim file in the GrCh37 format
    liftover_output -- The output file from the liftOver tool in 
    Linux/MacOS. This file may have the extension .bed, 
    but it is not the same as a binary PLINK .bed file.
    new_bim -- The name of the new .bim file in hg38 format. 
    '''
    old = pd.read_csv(old_bim, sep="\t", header = None)
    new = pd.read_csv(liftover_output, sep="\t", header= None)
    # rename columns in bim files for merging efficiency 
    old.columns = ["chr", "rsid", "pos", "bp", "allele1", "allele2"]
    new.columns = ["chr", "start", "end", "rsid"]
    merged = pd.merge(new, old, on="rsid")
    # drop unnecessary columns 
    merged = merged.drop(columns=["end", "chr_y", "bp"])
    # swap columns to be in the correct .bim format 
    columns_to_reindex = ["chr_x", "rsid", "pos", "start", "allele1", "allele2"]
    merged = merged.reindex(columns=columns_to_reindex)
    merged.to_csv(new_bim, header=False, index=False, sep = " ")
  

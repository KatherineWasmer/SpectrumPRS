# Helper functions for PLINK/vcf data handling 
import pandas as pd 

def get_new_ids(id_with_underscores: str) -> str:
    '''Removes any underscores from the individual ids in the .fam file

    Parameters: 
    id_with_underscores: An identifier containing underscores, which is not compatible with vcf data. 
    
    Examples: GSM4300828_13HI5K-048_GenomeWideSNP_6 -> GSM4300828
    '''
    ids = id_with_underscores.split("_") 
    return ids[0]

def update_fam_file(my_file) -> None:
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
  
  
  

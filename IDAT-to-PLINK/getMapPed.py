import pandas as pd 

def remove_brackets(df, value): 
    '''Helper function for separating alleles in [A/A], [A/B], or [B/B] format 
    Useful for converting to PED.'''
    df[value] =  df[value].apply(lambda x: x.replace('[','').replace(']',''))
    return(df)

def get_merged_file(processed_file: str, merged_rsids: str, manifest_file: str):
    '''
    Performs 2 joins to return an autosomal genotype file that can be converted to MAP or PED format. 
    
    Parameters:
    processed_file - This is the .txt file containing "processed" in the 
    Supplementary Materials section of your GEO accession page. For the Almandil study, 
    this file would be GSE221098_processed.txt.gz
    merged_rsids - The .txt file returned from the getInfoFromRSID() function. 
    manifest_file - The manifest file for the IDAT chip your data uses. 
    '''
    df_processed = pd.read_csv(processed_file, sep='\t')
    df_sorted = df_processed.sort_values(by=["Chr", "Position"])
    rsids = pd.read_csv(merged_rsids, sep=",") 
    merged_v1 = pd.merge(df_sorted, rsids, left_on=["Chr", "Position"], 
                      right_on=["chr_name", "chrom_start"])
    manifest = pd.read_csv(manifest_file, sep="\t")
    manifestKeeps = manifest.iloc[:, 0:4] # filters columns to only get the chromosome number, position, RSID, and alleles 
    merged_v2 = pd.merge(manifestKeeps, merged_v1, left_on=["Name"], 
                      right_on=["refsnp_id"])
    merged_autosomes = merged_new[~merged_new["Chr_x"].isin(["X", "XY", "Y", "MT"])]
    return(merged_autosomes)
    

def idat_to_map(processed_file, merged_rsids, manifest_file, map_file_name: str) -> None:
    '''
    Converts an IDAT file to a MAP file and writes the file to your directory. 
    
    Parameters:
    processed_file - This is the .txt file containing "processed" in the 
    Supplementary Materials section of your GEO accession page. For the Almandil study, 
    this file would be GSE221098_processed.txt.gz
    merged_rsids - The .txt file returned from the getInfoFromRSID() function. 
    manifest_file - The manifest file for the IDAT chip your data uses. 
    map_file_name - This is the output name for your MAP file. 
    '''
    df = get_merged_file(processed_file, merged_rsids, manifest_file)
    df = df.iloc[:, :3]
    df = df.sort_values(by=[df.columns[1], df.columns[2]])
    df["new"] = 0 
    # reorder in .map format https://www.cog-genomics.org/plink/1.9/formats#map
    cols = [df.iloc[:, 1].name, df.iloc[:, 0].name, "new", df.iloc[:, 2].name]
    to_map = df.reindex(columns=cols)
    to_map.to_csv(map_file_name, sep = " ", index=False, header=False)
    

def idat_to_ped(): 

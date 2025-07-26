import pandas as pd 

def idat_to_map(df: pd.DataFrame, map_file_name: str) -> None:
    '''
    df: a merged data frame containing the chromosome number, rsid, 
    base position, and genotypes for each individual. If only the rsID 
    is available, please refer to IDAT-to-PLINK/getLocation.R 
    map_file_name: the output file name. Should have the .map extension. 
    '''
    df = df.sort_values(by=["Chr", "Position"])
    df = df.iloc[:, :3]
    df["new"] = 0 # corresponds to centimorgan length (0 is default) 
    # reorder in .map format https://www.cog-genomics.org/plink/1.9/formats#map
    cols = ["chr_name", "refsnp_id", "new", "chrom_start"]
    to_map = df.reindex(columns=cols)
    to_map.to_csv(map_file_name, sep = " ", index=False, header=False)

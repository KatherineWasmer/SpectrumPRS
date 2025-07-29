import pandas as pd 

def idat_to_map(df: pd.DataFrame, map_file_name: str) -> None:
    '''
    df: a merged data frame containing each SNP with its corresponding 
    chromosome number and position 
    map_file_name: the output file name. Should have the .map extension. 
    '''
    df = df.iloc[:, :3]
    df = df.sort_values(by=[df.columns[1], df.columns[2]])
    df["new"] = 0 
    # reorder in .map format https://www.cog-genomics.org/plink/1.9/formats#map
    cols = [df.iloc[:, 1].name, df.iloc[:, 0].name, "new", df.iloc[:, 2].name]
    to_map = df.reindex(columns=cols)
    to_map.to_csv(map_file_name, sep = " ", index=False, header=False)

def idat_to_ped(): 

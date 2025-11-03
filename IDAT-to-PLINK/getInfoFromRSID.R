BiocManager::install("biomaRt")
library(biomaRt) 

# Function objective: Retrieves chromosome numbers, major/minor alleles, and base pair locations based off of an rsID. 
# Default paramenters - Human Genome Reference Build 37
getInfoFromRSID <- function(rsidFile, outputFile, build, species){
  if (missing(build)) {
    build = "https://grch37.ensembl.org"
  }
  if (missing(species)) {
    species = "hsapiens_snp"
  }
  snp_mart <- useMart(biomart="ENSEMBL_MART_SNP", host=build, path = "/biomart/martservice", dataset=species)
  rsids <- read.csv("rsids.txt", sep = "\t")
  new_df <- getBM(attributes = c('refsnp_id', 'chr_name', 'chrom_start', 'allele'), 
             filters = c('snp_filter'), 
             values = list(rsids$RsID), 
             mart = snp_mart)
  write.table(new_df, outputFile, quote = FALSE, row.names = FALSE) # compatible with PLINK format 
}

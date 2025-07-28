BiocManager::install("biomaRt")
library(biomaRt) 

getInfoFromRSID <- function(rsidFile, outputFile){
  snp_mart <- useMart(biomart="ENSEMBL_MART_SNP", host="https://grch37.ensembl.org", path = "/biomart/martservice", dataset="hsapiens_snp")
  rsids <- read.csv("rsids.txt", sep = "\t")
  new_df <- getBM(attributes = c('refsnp_id', 'chr_name', 'chrom_start', 'allele'), 
             filters = c('snp_filter'), 
             values = list(rsids$RsID), 
             mart = snp_mart)
  write.table(new_df, outputFile, quote = FALSE, row.names = FALSE) # compatible with PLINK format 
}

snp_mart <- useMart(biomart="ENSEMBL_MART_SNP", host="https://grch37.ensembl.org", path = "/biomart/martservice", dataset="hsapiens_snp")

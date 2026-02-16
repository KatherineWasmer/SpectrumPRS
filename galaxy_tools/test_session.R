# running Glados functions within Galaxy tools and creating a PCA with the human genome project samples 
devtools::install_from_github("KatherineWasmer/glados") 
library(glados)

glados::galaxy_install_plink()
glados::galaxy_rename_file("1_chr1_1KG.vcf.gz.vcf_bgzip", "chr1.vcf.gz")
glados::galaxy_create_bed("chr1.vcf.gz", "chr1")

# still need to add to library
get_pca <- function(filename, n_components, output_name){
  system(glue::glue("~/bin/plink --bfile {filename} --keep-allele-order --pca {n_components} --out {output_name}"))
}

get_pca("chr1", 25, "chr1")

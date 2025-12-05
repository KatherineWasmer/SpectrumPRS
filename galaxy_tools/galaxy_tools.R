# Helper functions for running an RStudio session through Galaxy 
library(stringr)
library(glue)

# OPTIONAL: install plink version 1.9 
install_plink <- function(){
  system("wget -P ~/bin/ https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20231211.zip")
  system("unzip ~/bin/plink_linux_x86_64_20231211.zip -d ~/bin/")
}

# Updates the file name through the command line. Parameters are in string format, i.e., straight double quotes 
change_file_name <- function(oldName, newName){
  system(glue::glue("mv ~/galaxy_inputs/{oldName} ~/galaxy_inputs/{newName}"))
}

# Returns a BED, BIM, and FAM file for the VCF file 
create_bed <- function(filename, output_name){
  system(glue::glue("~/bin/plink --vcf galaxy_inputs/{filename} --make-bed --out {output_name}"))
}

# Returns an output file called {output_name}.eigenvec 
get_pca <- function(filename, n_components, output_name){
  system(glue::glue("~/bin/plink --bfile {filename} --keep-allele-order --pca {n_components} --out {output_name}"))
}

# ------------------------
# BELOW: code that needs to be edited 

chr3 = read.table("chr3PCA.eigenvec")
plot(chr3$V3, chr3$V4) # plot the first two principal components 

ancestries = read.table("galaxy_inputs/samples1KG.panel", header = TRUE) # file can be found at data/samples1KG.panel 

head(ancestries)

colnames(ancestries)[1] <- "V1"
merged <- merge(chr3, ancestries, by="V1")

library(ggplot2)
library(viridis) # provides color-blind friendly palettes
colors = viridis(5)
super_pop_levels <- c("AFR", "AMR", "EAS", "EUR", "SAS") # color groups by continental level ancestry 
names(colors) <- super_pop_levels

ggplot(data=merged, aes(x=V3, y=V4, col=super_pop)) + geom_point() + 
  scale_color_manual(values=colors)

unique(merged$pop)

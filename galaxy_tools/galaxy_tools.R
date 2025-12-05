# Helper functions for running an RStudio session through Galaxy 
library(stringr)
library(glue)
library(ggplot2)
library(viridis)

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

# --------------------------------------------------------
# BELOW: Code that still needs to be tested on the server

plot_simple_PCA <- function(pca_output, pca_x, pca_y){
  eigen = read.table(pca_output)
  x_dim = pca_x - 2 
  y_dim = pca_y - 2
  plot(eigen$x_dim, y_dim) 
}

# Returns a data frame with the IDs from the 1000 Genomes reference panel and their PC coordinates 
merge_PCA_with_reference <- function(pca_output, reference_panel){
  ancestries = read.table(reference_panel, header=TRUE) 
  colnames(ancestries)[1] <- "V1"
  merged <- merge(pca_output, ancestries, by="V1")
  return(merged) 
}

plot_clustered_PCA <- function(pca_output, reference_panel, pca_x, pca_y) {
  merged <- merge_PCA_with_reference(pca_output, reference_panel) 
  colors <- viridis(5) # update for flexible color palette 
  super_pop_levels <- c("AFR", "AMR", "EAS", "EUR", "SAS") # color groups by continental level ancestry 
  names(colors) <- super_pop_levels
  x_dim = glue::glue(V{pca_x - 2})
  y_dim = glue::glue(V{pca_y - 2}) 
  ggplot(data=merged, aes(x=x_dim, y=y_dim, col=super_pop)) + geom_point() + 
    scale_color_manual(values=colors)
}

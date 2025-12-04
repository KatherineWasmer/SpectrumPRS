# for this PCA (only using Chromosome 3), we will be using the file https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr3.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz
# Upload this file to your Galaxy account and rename it chr3.vcf.gz and create a session in R 
# Add this file to the galaxy_inputs folder in your R session 

# OPTIONAL: install plink 
system("wget -P ~/bin/ https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20231211.zip")
system("unzip ~/bin/plink_linux_x86_64_20231211.zip -d ~/bin/")

system("~/plink --vcf galaxy_inputs/chr3.vcf.gz --make-bed --out chr3") 
system("~/plink --bfile chr3 --keep-allele-order --pca 20 --out chr3PCA") # outputs a file called chr3PCA.eigenvec 

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


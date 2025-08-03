system("~/plink --vcf galaxy_inputs/chr3.vcf.gz --make-bed --out chr3")
system("~/plink --bfile chr3 --keep-allele-order --pca 20 --out chr3PCA")

chr3 = read.table("chr3PCA.eigenvec")
plot(chr3$V3, chr3$V4)

ancestries = read.table("galaxy_inputs/ancestries.panel", header = TRUE)

head(ancestries)

colnames(ancestries)[1] <- "V1"
merged <- merge(chr3, ancestries, by="V1")

library(ggplot2)
library(viridis)
colors = viridis(5)
super_pop_levels <- c("AFR", "AMR", "EAS", "EUR", "SAS")
names(colors) <- super_pop_levels

ggplot(data=merged, aes(x=V3, y=V4, col=super_pop)) + geom_point() + 
  scale_color_manual(values=colors)

unique(merged$pop)


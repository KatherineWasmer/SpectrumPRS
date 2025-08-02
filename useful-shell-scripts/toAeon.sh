
input_file = $1
base_name=$(basename "$input_file" .vcf.gz)

annot_file = ${base_name}${"chr.vcf.gz"}

ancestry_output = ${annot_file}${"ancestry"}

# create file for renaming chromosomes in aeon annotation 
if [ ! -f rename_chr.txt ] then; 
  for i in {1..22}; do echo -e "$i\tchr$i"; done > rename_chr.txt

# Step 1: annotate 
bcftools annotate --rename-chrs rename_chr.txt -Oz -o annot_file input_file
# Step 2: index 
bcftools index --csi annot_file
# Step 3: compute ancestry 
aeon annot_file -o ancestry_output --v

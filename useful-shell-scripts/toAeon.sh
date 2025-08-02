
input_file = $1
if [[ $input_file == "*.gz"]]; then 
  base_name=$(basename "$input_file" .vcf.gz)
else 
  base_name=$(basename "$input_file" .vcf)

# Step 1: annotate 
bcftools annotate --rename-chrs rename_chr.txt -Oz -o japan_autism_v2_chr.qc.vcf japan_autism_v2.qc.vcf
# Step 2: index 
bcftools index --csi 0_GSM4300828_chr.vcf.gz
# Step 3: compute ancestry 
aeon 0_GSM4300828.vcf.gz -o 0_GSM4300828_ancestry --v

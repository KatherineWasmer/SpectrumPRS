### Useful command lines 

Working with Linux on an HPC is a learning curve, so I compiled a masterlist of commands that are common in computational genomics. These may be helpful if you do any sort of scientific computing at the University of Michigan! These scripts are interactive. Before running any of these bash scripts, make sure to input ```chmod +x {myScript}.sh``` in your terminal. Otherwise, you might get a "Permission denied" message. 

Successfully tested ✔️ 

hg38ToHg19.sh 

```(base) [kwasmer@gl-login2 Capstone]$ ./hg38ToHg19.sh LaSalle/A102092.vcf.gz```

getAutosomes.sh 

```(base) [kwasmer@gl-login4 Capstone]$ ./getAutosomes.sh A102092_lifted_sorted.vcf.gz```

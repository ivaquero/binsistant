declare -a gcf_files
declare -a gene_objects

# your gcf files
gcf_files=(011058795.1_ASM1105879v1_cds)
# your gene gene_objects
gene_objects=(dnaA)
# your output folder
output="genes"

if [[ ! -d $output ]]; then
    mkdir -p $output
fi

for gcf_file in ${gcf_files[@]}; do
    for gene_object in ${gene_objects[@]}; do
        cat data/GCF_${gcf_file}_from_genomic.fna | rg -U ">lcl.+gene=${gene_objects}.+[\w\n]+" >${output}/${gene_object}.txt
    done
done

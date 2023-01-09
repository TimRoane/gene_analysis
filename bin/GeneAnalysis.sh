#!/bin/bash

echo Now processing gene $geneid
echo Using fasta file $fastaFile
echo Using gff file $gffFile

grep GeneID:$geneid $gffFile > ../data/$geneid.gff

grep -v X2 ../data/$geneid.gff | grep -v X3 | grep -v X4 | grep -v X5 | grep -v X6 | grep -v X7 | grep -v X8 | grep -v X9 | grep -v X10 > ../data/$geneid.X1.gff

grep CDS ../data/$geneid.X1.gff > ../data/$geneid.X1.cds.gff

gt gff3 -sort -tidy -force -o ../data/$geneid.sorted.gff ../data/$geneid.X1.gff
gt stat -genelengthdistri -exonlengthdistri -intronlengthdistri -cdslengthdistri -addintrons -force -o ../results/$geneid.sorted.counts.gff ../data/$geneid.sorted.gff

bedtools getfasta -s -fi $fastaFile -fo ../data/$geneid.X1.cds.fa -bed ../data/$geneid.X1.cds.gff

union ../data/$geneid.X1.cds.fa -outseq ../results/$geneid.X1.cds.union.fa
transeq ../results/$geneid.X1.cds.union.fa -outseq ../results/$geneid.X1.aa.fa


# docker-4dn-mergebed

Concatenates sorted or unsorted gzipped bed files into a sorted merged gzipped bed file.
* docker images: `4dndcic/4dn-mergebed:v1`

## Input
* A list of gzipped bed file, either sorted or unsorted, without header

## Output
* A gzipped bed file, merged and sorted (either chr1, chr10, chr11, ... or chr1, chr2, chr3, ... see **Options**)

## Options
* `sortv=0` : Chromosome sorting is chr1, chr10, chr11, ...
* `sortv=1` : Chromosome sorting is chr1, chr2, chr3, ...

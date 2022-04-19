#!/usr/bin/env nextflow

/* 
 * Script to merge chromosome-wise VCF files into single VCF file
 */

nextflow.enable.dsl=2

process bgzip {
  container "stackleader/bgzip-utility"

  input:
  path(vcf_file)

  output:
  path("*.bzip"), emit: bgzip

  script: 
  """
    bgzip -t ${vcf_file}
  """
}

process tabix {
  container "ensemblorg/ensembl-vep" 

  input:
  path(vcf_file)

  output:
  path("${ vcf_file }.tbi"), emit: tabix

  script: 
  """
    tabix -p vcf -f ${vcf_file}
  """
}


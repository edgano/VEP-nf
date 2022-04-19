#!/usr/bin/env nextflow

/* 
 * Script to merge chromosome-wise VCF files into single VCF file
 */

nextflow.enable.dsl=2



process bzip {
  input:
  path(vcf_file)

  script: 
  """
    bgzip -t ${vcf_file}
  """
}

process tabix {
  input:
  path(vcf_file)

  output:
  path("${ vcf_file }.tbi"), emit: tabix

  script: 
  """
    tabix -p vcf -f ${vcf_file}
  """
}

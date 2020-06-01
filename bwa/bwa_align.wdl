version 1.0

workflow testBWA {
    call BWA_align

    output{
        File output_sam = BWA_align.output_sam
    }
}

task BWA_align {
    input {
        String docker_image
        String bwa_opt
        Int threads
        File ref_fasta
        File ref_fasta_fai
        File ref_fasta_amb
        File ref_fasta_ann
        File ref_fasta_bwt
        File ref_fasta_pac
        File ref_fasta_sa
        File read1_fastq
        File read2_fastq
        String output_sam
    }

    command {
        bwa mem ${bwa_opt} ${threads} ${ref_fasta} ${read1_fastq} ${read2_fastq} > ${output_sam}
    }

    output{
        File output_sam = "${output_sam}"
    }

    runtime {
        docker: docker_image
    }
}

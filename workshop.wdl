version 1.0

workflow align_and_metrics {
    call BWA_Align

    call Flagstat {
        input:
            input_sam = BWA_Align.output_sam
    }

    output{
        File output_sam = BWA_Align.output_sam
        File output_metrics = Flagstat.flagstat_metrics
    }

}

task BWA_Align {
    input {
        String sample_name
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
    }

    String output_sam = "${sample_name}" + ".sam"

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

task Flagstat {
    input {
        String docker_image
        File input_sam
    }
    String sample_name = basename(input_sam, ".sam") + ".flagstat.metrics"

    command {
        samtools flagstat ${input_sam} > ${sample_name}
    }

    output{
        File flagstat_metrics = "${sample_name}"
    }

    runtime {
        docker: docker_image
    }

}

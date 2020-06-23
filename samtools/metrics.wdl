version 1.0

workflow metrics {
    call Flagstat

    output{
        File flagstat_metrics = Flagstat.flagstat_metrics
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
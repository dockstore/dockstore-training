version 1.0

workflow samtools_flagstat {
    call flagstat

    output{
        File flagstat_metrics = flagstat.flagstat_metrics
    }
}

task flagstat {
    input {
        String docker_image
        File input_sam
    }

    command {
        samtools flagstat ${input_sam}
    }

    output{
        File flagstat_metrics = stdout()
    }

    runtime {
        docker: docker_image
    }
}
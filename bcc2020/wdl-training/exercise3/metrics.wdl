###############################################################################################
#launch locally with DockstoreCLI:
#   dockstore workflow launch --local-entry metrics.wdl --json metrics.json
###############################################################################################
version 1.0
workflow metrics {
    call flagstat
    output{
        File alignment_metrics = flagstat.metrics
    }
}
task flagstat {
    input {
        File input_sam
        String docker_image
    }
    String stats = basename(input_sam) + ".metrics"
    command {
        samtools flagstat ${input_sam} > ${stats}
    }
    output{
        File metrics =  "${stats}"
    }
    runtime {
        docker: docker_image
    }
}
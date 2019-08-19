#!/usr/bin/env nextflow

params.input_files = "./test_data/glutathione.mgf"
params.outdir = "$baseDir/output_nf"

files_ch = Channel.fromPath(params.input_files).map { file -> tuple(file.baseName, file) }


process run_annotate {
    echo true

    publishDir "$params.outdir", mode: 'copy'

    input:
    set file_id, file(query_file) from files_ch

    output:
    set val(file_id), file("${file_id}_outputdir") into records

    """
    magma light -f mgf -s hmdb $query_file
    """

}
# date of download: 2026/10/30
#
# The salmon counts (nf-core/rnaseq) were quantified against
# GENCODE vM25 (GRCm38, Ensembl 100), primary assembly annotation:
# all 55,487 versioned gene ids in data/nfcore_rnaseq/counts match this GTF.
# Current BioMart releases are GRCm39 and GRCm38 archives are offline, so the
# gene annotation is taken from the GTF itself and frozen as a csv.
# Not part of 0_QC.qmd: run once from the project root.

library(rtracklayer)
library(here)

gtf_url <- paste0(
  "https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/",
  "gencode.vM25.primary_assembly.annotation.gtf.gz"
)
gtf_file <- here("data", "gencode.vM25.primary_assembly.annotation.gtf.gz")

if (!file.exists(gtf_file)) {
  download.file(gtf_url, gtf_file, mode = "wb")
}

gtf <- import(gtf_file, feature.type = "gene")

annot <- data.frame(
  gene_id = gtf$gene_id,
  ensembl_gene_id = sub("\\..*", "", gtf$gene_id),
  external_gene_name = gtf$gene_name,
  gene_biotype = gtf$gene_type,
  chromosome_name = as.character(seqnames(gtf)),
  start_position = start(gtf),
  end_position = end(gtf),
  strand = as.character(strand(gtf)),
  mgi_id = gtf$mgi_id
)


# --- save ----

write.csv(
  annot,
  here("0_QC", "outputs", "files", "annot.csv"),
  row.names = FALSE
)
writeLines(
  c(paste("source:", gtf_url), paste("md5:", tools::md5sum(gtf_file))),
  here("0_QC", "outputs", "files", "annot_source.txt")
)

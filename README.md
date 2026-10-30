# cyp27a1_bulk

Analysis of bulk RNA-seq from FACS-sorted mouse colon epithelial cells, *Cyp27a1* KO (n = 3) vs WT (n = 3). Reads were aligned to mm10/GRCm38 and quantified with salmon (nf-core/rnaseq) using the GENCODE vM25 primary assembly annotation.

The repository is structured in one folder per analysis step, each containing the scripts for that step and an `outputs/` folder with `figures/` and `files/`. Analyses are written as Quarto documents and run in the `cyp_bulk` conda environment (a clone of `bulkRNAseq`, see `env/`):

```bash
mamba activate cyp_bulk
quarto render 0_QC/0_QC.qmd
quarto render 1_Cyp27a1_coverage/1_Cyp27a1_coverage.qmd
```

> [!TIP]
> Each script generates a sessionInfo.txt file that contains the session information.


### 0_QC

* `downloadAnnotation.R`: downloads the GENCODE vM25 primary assembly GTF (the exact annotation used for quantification: all 55,487 versioned gene ids match) and freezes the gene annotation as `outputs/files/annot.csv`. The source URL and md5 are recorded in `outputs/files/annot_source.txt`. It's not part of `0_QC.qmd`.

* `0_QC.qmd`: sample-level QC (library size, detected genes, biotype composition, mitochondrial fraction, most abundant genes), checks specific to sorted epithelium (sort purity, colon vs small intestine identity, epithelial lineage markers, dissociation stress genes), sex check and *Cyp27a1* expression. Keeps protein-coding nuclear genes, collapses to gene symbols, filters lowly expressed genes with `filterByExpr`, normalises with edgeR (TMM + logCPM) and builds a `SummarizedExperiment`. Outputs the SE (`se.rds`), a DGEList (`dge.rds`), per-sample QC metrics (`qc_metrics.csv`) and QC figures.


### 1_Cyp27a1_coverage

* `1_Cyp27a1_coverage.qmd`: per-base coverage over the *Cyp27a1* locus and the exons of the canonical transcript (ENSMUST00000027356, 9 exons) from the sense-strand nf-core bigwigs (stranded library), scaled to reads per million with the TMM effective library sizes from `0_QC`. Plots coverage by genotype (mean and range) and per sample, over the full locus and over concatenated exons, and summarises mean and relative coverage per exon. Outputs the exon table, per-sample per-exon coverage and KO vs WT ratios.


### data

* `nfcore_rnaseq/`: nf-core/rnaseq outputs (`counts/`, `bigwig/`, `reference/`, `size_factors/`).
* `gencode.vM25.primary_assembly.annotation.gtf.gz`: annotation downloaded by `0_QC/downloadAnnotation.R`.

### metadata

* `metadata.csv`: sample id, mouse, genotype, cell type and tissue.

### functions

* `formatting_ggplot.R`: shared ggplot2 themes (`my_theme`, `hmtheme`) and colour helpers.

### config.yaml

Colour palettes shared across steps (e.g. `genotype_colors`).

### env

* `env.yml`: contains the packages included in the environment that was used to run the analysis.

* `env_nobuilds.yml`: contains the packages included in the environment that was used to run the analysis without the build string.

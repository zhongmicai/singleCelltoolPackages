#' Get Information of SplatPop
#'
#' @param ... ...
#'
#' @return A list contains the information of method and default parameters
#' @import simutils
#' @importFrom splatter newSplatPopParams
#' @export
#'
#' @examples
#' SplatPop_method_definition <- SplatPop_method_definition()

SplatPop_method_definition <- function(...){
  SplatPop_parameters <- parameter_sets(
    param_reference(
      id = "input_refernece",
      type = c("matrix"),
      default = NULL,
      process = "estimation",
      description = "The reference data to go through estimation and evaluation process. Usually, no reference data is also OK.",
      function_name = "splatPopEstimate"
    ),
    param_others(
      id = "SplatPopParams",
      type = "SplatPopParams",
      default = "splatter::newSplatPopParams()",
      process = "estimation",
      description = "Usually it is default by splatter::newSplatPopParams function. Users can change the parameters by splatter::setParam function.",
      function_name = "splatPopEstimate"
    ),
    param_Boolean(
      id = "paths",
      default = FALSE,
      description = "Whether to simulation trajectory datasets",
      function_name = "splatPopSimulate"
    ),
    param_others(
      id = "vcf",
      type = "VariantAnnotation object",
      default = "mockVCF()",
      description = "VariantAnnotation object containing genotypes of samples.",
      function_name = "splatPopSimulate"
    ),
    param_others(
      id = "gff",
      type = "NULL or data.frame",
      default = NULL,
      description = "Either NULL or a data.frame object containing a GFF/GTF file.",
      function_name = "splatPopSimulate"
    ),
    param_others(
      id = "key",
      default = NULL,
      type = "NULL or data.frame",
      description = "Either NULL or a data.frame object containing a full or partial splatPop key.",
      function_name = "splatPopSimulate"
    ),
    param_character(
      id = "method",
      default = "single",
      alternatives = c("single", "groups", "paths"),
      description = "Which simulation method to use. Options are 'single' which produces a single population, 'groups' which produces distinct groups (eg. cell types), 'paths' which selects cells from continuous trajectories (eg. differentiation processes).",
      function_name = "splatPopSimulate"
    ),
    param_dataframe(
      id = "eqtl",
      process = "estimation",
      description = "data.frame with all or top eQTL pairs from a real eQTL analysis. Must include columns: 'gene_id', 'pval_nominal', and 'slope'.",
      function_name = "splatPopSimulate"
    ),
    param_others(
      id = "means",
      type = "matrix",
      process = "estimation",
      description = "Matrix of real gene means across a population, where each row is a gene and each column is an individual in the population.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "similarity.scale",
      default = 1,
      lower = 0,
      border = FALSE,
      description = "Scaling factor for pop.cv.param.rate, where values larger than 1 increase the similarity between individuals in the population and values less than one make the individuals less similar.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "pop.mean.shape",
      default = 0.34,
      lower = 0,
      border = FALSE,
      description = "Shape parameter for the mean (i.e. bulk) expression gamma distribution.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "pop.mean.rate",
      default = 0.008,
      lower = 0,
      border = FALSE,
      description = "Rate parameter for the mean (i.e. bulk) expression gamma distribution.",
      function_name = "splatPopSimulate"
    ),
    param_Boolean(
      id = "pop.quant.norm",
      default = TRUE,
      description = "Logical to run the quantile normalization function, which fits the distribution of gene means for each individual to the distribution estimated from the single-cell data, the parameter can be set to FALSE.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "pop.cv.bins",
      default = 10L,
      lower = 0,
      border = FALSE,
      description = "The number of bins to include when estimating population scale variance parameters.",
      function_name = "splatPopSimulate"
    ),
    param_dataframe(
      id = "pop.cv.param",
      type = "data.frame",
      description = "A dataframe of bins of start, end, shape, rate.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.n",
      default = 0.5,
      lower = 0,
      border = FALSE,
      description = "The number (>1) or percent (<=1) of genes to assign eQTL effects.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.dist",
      default = 1e+06,
      lower = 0,
      border = FALSE,
      description = "Maximum distance between eSNP and eGene.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.maf.min",
      default = 0.05,
      lower = 0,
      upper = 1,
      description = "Minimum Minor Allele Frequency of eSNPs.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.maf.max",
      default = 1,
      lower = 0,
      upper = 1,
      description = "Maximum Minor Allele Frequency of eSNPs.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.coreg",
      default = 0,
      lower = 0,
      upper = 1,
      description = "Proportion of eGenes to have a shared eSNP (i.e., co-regulated genes).",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.ES.shape",
      default = 3.6,
      lower = 0,
      border = FALSE,
      description = "Shape parameter for the effect size gamma distribution.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.ES.rate",
      default = 12,
      lower = 0,
      border = FALSE,
      description = "Rate parameter for the effect size gamma distribution.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.group.specific",
      default = 0.2,
      lower = 0,
      upper = 1,
      description = "Percent of eQTL effects to simulate as group specific.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.condition.specific",
      default = 0.2,
      lower = 0,
      upper = 1,
      description = "Percent of eQTL effects to simulate as condition specific.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "batch.size",
      default = 10L,
      lower = 1,
      description = "The number of donors in each pool/batch.",
      function_name = "splatPopSimulate"
    ),
    param_Boolean(
      id = "nCells.sample",
      default = FALSE,
      description = "True/False if nCells should be set as nCells or sampled from a gamma distribution for each batch/donor.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "eqtl.condition.specific",
      default = 0.2,
      lower = 0,
      upper = 1,
      description = "Percent of eQTL effects to simulate as condition specific.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "nCells.shape",
      default = 1.5,
      description = "Shape parameter for the nCells per batch per donor distribution.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "nCells.rate",
      default = 0.015,
      description = "Rate parameter for the nCells per batch per donor distribution.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "nConditions",
      default = 1L,
      lower = 1,
      description = "The number of conditions/treatments to divide samples into.",
      function_name = "splatPopSimulate"
    ),
    param_vector(
      id = "condition.prob",
      default = 1,
      description = "Probability that a sample belongs to each condition/treatment group. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_vector(
      id = "cde.prob",
      default = 0.1,
      description = "Probability that a gene is differentially expressed in a condition group. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_vector(
      id = "cde.downProb",
      default = 0.5,
      description = "Probability that a conditionally differentially expressed gene is down-regulated. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_vector(
      id = "cde.facLoc",
      default = 0.1,
      description = "Location (meanlog) parameter for the conditional differential expression factor log-normal distribution. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_vector(
      id = "cde.facScale",
      default = 0.4,
      description = "Scale (sdlog) parameter for the conditional differential expression factor log-normal distribution. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "nBatches",
      default = 1L,
      lower = 1L,
      description = "The number of batches to simulate. Set batchCells instead to change the value of nBatches",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "batchCells",
      default = 100L,
      lower = 1L,
      description = "Vector giving the number of cells in each batch.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "batch.facLoc",
      default = 0.1,
      lower = 0,
      border = FALSE,
      upper = 1,
      description = "Location (meanlog) parameter for the batch effect factor log-normal distribution. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "batch.facScale",
      default = 0.1,
      lower = 0,
      border = FALSE,
      upper = 1,
      description = "Scale (sdlog) parameter for the batch effect factor log-normal distribution. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_Boolean(
      id = "batch.rmEffect",
      default = FALSE,
      description = "Logical, removes the batch effect and continues with the simulation when TRUE. This allows the user to test batch removal algorithms without having to calculate the new expected cell means with batch removed.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "mean.shape",
      default = 0.6,
      lower = 0,
      border = FALSE,
      description = "Shape parameter for the mean gamma distribution.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "mean.rate",
      default = 0.3,
      lower = 0,
      border = FALSE,
      description = "Rate parameter for the mean gamma distribution.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "lib.loc",
      default = 11L,
      lower = 1L,
      description = "Location (meanlog) parameter for the library size log-normal distribution, or mean parameter if a normal distribution is used.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "lib.scale",
      default = 0.2,
      lower = 0,
      border = FALSE,
      description = "Scale (sdlog) parameter for the library size log-normal distribution, or sd parameter if a normal distribution is used.",
      function_name = "splatPopSimulate"
    ),
    param_Boolean(
      id = "lib.norm",
      default = FALSE,
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "out.prob",
      default = 0.05,
      lower = 0,
      upper = 1,
      border = FALSE,
      description = "Probability that a gene is an expression outlier.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "out.facLoc",
      default = 4L,
      lower = 0,
      border = FALSE,
      description = "Location (meanlog) parameter for the expression outlier factor log-normal distribution.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "out.facScale",
      default = 0.5,
      lower = 0,
      border = FALSE,
      upper = 1,
      description = "Scale (sdlog) parameter for the expression outlier factor log-normal distribution.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "nGroups",
      default = 1L,
      lower = 1L,
      description = "The number of groups or paths to simulate. Set prob.group instead to change the value of nGroups",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "group.prob",
      default = 1,
      lower = 0,
      upper = 1,
      description = "Probability that a cell comes from a group.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "de.prob",
      default = 0.1,
      lower = 0,
      upper = 1,
      description = "Probability that a gene is differentially expressed in a group. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "de.downProb",
      default = 0.5,
      lower = 0,
      upper = 1,
      description = "Probability that a differentially expressed gene is down-regulated. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "de.facLoc",
      default = 0.1,
      lower = 0,
      border = FALSE,
      description = "Location (meanlog) parameter for the differential expression factor log-normal distribution. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "de.facScale",
      default = 0.4,
      lower = 0,
      border = FALSE,
      description = "Scale (sdlog) parameter for the differential expression factor log-normal distribution. Can be a vector.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "bcv.common",
      default = 0.1,
      lower = 0,
      border = FALSE,
      description = "Underlying common dispersion across all genes.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "bcv.df",
      default = 60L,
      lower = 1L,
      description = "Degrees of Freedom for the BCV inverse chi-squared distribution.",
      function_name = "splatPopSimulate"
    ),
    param_character(
      id = "dropout.type",
      default = "none",
      alternatives = c("none", "experiment", "batch", "group", "cell"),
      description = "The type of dropout to simulate. 'none' indicates no dropout, 'experiment' is global dropout using the same parameters for every cell, 'batch' uses the same parameters for every cell in each batch, 'group' uses the same parameters for every cell in each groups and 'cell' uses a different set of parameters for each cell.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "dropout.mid",
      default = 0,
      description = "Midpoint parameter for the dropout logistic function.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "dropout.shape",
      default = -1,
      description = "Shape parameter for the dropout logistic function.",
      function_name = "splatPopSimulate"
    ),
    param_vector(
      id = "path.from",
      default = 0,
      description = "Vector giving the originating point of each path. This allows path structure such as a cell type which differentiates into an intermediate cell type that then differentiates into two mature cell types. A path structure of this form would have a 'from' parameter of c(0, 1, 1) (where 0 is the origin). If no vector is given all paths will start at the origin.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "path.nSteps",
      default = 100L,
      lower = 1L,
      description = "Vector giving the number of steps to simulate along each path. If a single value is given it will be applied to all paths. This parameter was previously called path.length.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "path.skew",
      default = 0.5,
      lower = 0,
      upper = 1,
      description = "Vector giving the skew of each path. Values closer to 1 will give more cells towards the starting population, values closer to 0 will give more cells towards the final population. If a single value is given it will be applied to all paths.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "path.nonlinearProb",
      default = 0.1,
      lower = 0,
      upper = 1,
      description = "Probability that a gene follows a non-linear path along the differentiation path. This allows more complex gene patterns such as a gene being equally expressed at the beginning an end of a path but lowly expressed in the middle.",
      function_name = "splatPopSimulate"
    ),
    param_numeric(
      id = "path.sigmaFac",
      default = 0.8,
      lower = 0,
      upper = 1,
      description = "Sigma factor for non-linear gene paths. A higher value will result in more extreme non-linear variations along a path.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "nGenes",
      default = 10000L,
      lower = 1L,
      description = "The number of genes to simulate.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "nCells",
      default = 100L,
      lower = 1L,
      description = "The number of cells to simulate.",
      function_name = "splatPopSimulate"
    ),
    param_integer(
      id = "seed",
      force = TRUE,
      description = "Seed to use for generating random numbers.",
      function_name = "splatPopSimulate"
    )
  )

  SplatPop_method <- method_definition(
    method = "SplatPop",
    programming = "R",
    url = "https://bioconductor.org/packages/release/bioc/html/splatter.html",
    authors = authors_definition(
      first = "Luke",
      last = "Zappia",
      email = NULL,
      github = "https://github.com/Oshlack/splatter",
      orcid = "0000-0001-7744-8565"
    ),
    manuscript = manuscript_definition(
      title = "splatPop: simulating population scale single-cell RNA sequencing data",
      doi = "10.1186/s13059-021-02546-1",
      journal = "Genome Biology",
      date = "2021",
      peer_review = TRUE
    ),
    description = "Splatter is a package for the simulation of single-cell RNA sequencing count data",
    vignette = "http://47.254.148.113/software/Simsite/references/methods/4-splatpop/")

  list(SplatPop_method = SplatPop_method,
       SplatPop_parameters = SplatPop_parameters)
}

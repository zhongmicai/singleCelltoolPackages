#' Estimate Parameters From Real Datasets by phenopath
#'
#' This function is used to estimate useful parameters from a real dataset by
#' using \code{phenoEstimate} function in Splatter package.
#'
#' @param ref_data A count matrix. Each row represents a gene and each column
#' represents a cell.
#' @param verbose Logical.
#' @param seed An integer of a random seed.
#' @importFrom splatter phenoEstimate
#' @return A list contains the estimated parameters and the results of execution
#' detection.
#' @export
#'
#' @references
#' Campbell K, Yau C. Uncovering genomic trajectories with heterogeneous genetic and environmental backgrounds across single-cells and populations. bioRxiv, 2017: 159913. <https://doi.org/10.1101/159913>
#'
#' Bioconductor URL: <https://bioconductor.org/packages/release/bioc/html/phenopath.html>
#'
#' Github URL: <https://github.com/kieranrcampbell/phenopath>
#'
#' @examples
#' \dontrun{
#' ref_data <- simmethods::data
#' ## estimation
#' estimate_result <- simmethods::phenopath_estimation(
#'   ref_data = ref_data,
#'   verbose = TRUE,
#'   seed = 111
#' )
#' }
#'
phenopath_estimation <- function(ref_data,
                                 verbose = FALSE,
                                 seed){

  ##############################################################################
  ####                            Environment                                ###
  ##############################################################################
  if(!requireNamespace("splatter", quietly = TRUE)){
    message("Splatter is not installed on your device")
    message("Installing splatter...")
    BiocManager::install("splatter")
  }
  ##############################################################################
  ####                               Check                                   ###
  ##############################################################################
  if(!is.matrix(ref_data)){
    ref_data <- as.matrix(ref_data)
  }
  ##############################################################################
  ####                            Estimation                                 ###
  ##############################################################################
  if(verbose){
    message("Estimating parameters using phenopath")
  }
  # Seed
  set.seed(seed)
  # Estimation
  estimate_detection <- peakRAM::peakRAM(
    estimate_result <- splatter::phenoEstimate(ref_data)
  )
  ##############################################################################
  ####                           Ouput                                       ###
  ##############################################################################
  estimate_output <- list(estimate_result = estimate_result,
                          estimate_detection = estimate_detection)
  return(estimate_output)
}


#' Simulate Datasets by phenopath
#'
#' @param parameters A object generated by [splatter::phenoEstimate()]
#' @param other_prior A list with names of certain parameters. Some methods need
#' extra parameters to execute the estimation step, so you must input them. In
#' simulation step, the number of cells, genes, groups, batches, the percent of
#' DEGs are usually customed, so before simulating a dataset you must point it out.
#' See `Details` below for more information.
#' @param return_format A character. Alternative choices: list, SingleCellExperiment,
#' Seurat, h5ad. If you select `h5ad`, you will get a path where the .h5ad file saves to.
#' @param verbose Logical. Whether to return messages or not.
#' @param seed A random seed.
#' @importFrom splatter getParams setParam
#' @export
#' @details
#' In phenopath, users can only set `nCells` and `nGenes` to specify the number of cells and genes in the
#' simulated dataset. See `Examples` for instructions.
#'
#' For more customed parameters, see [splatter::PhenoParams()] and [splatter::phenoSimulate()].
#'
#' @references
#' Campbell K, Yau C. Uncovering genomic trajectories with heterogeneous genetic and environmental backgrounds across single-cells and populations. bioRxiv, 2017: 159913. <https://doi.org/10.1101/159913>
#'
#' Bioconductor URL: <https://bioconductor.org/packages/release/bioc/html/phenopath.html>
#'
#' Github URL: <https://github.com/kieranrcampbell/phenopath>
#'
#' @examples
#' \dontrun{
#' ref_data <- simmethods::data
#' ## estimation
#' estimate_result <- simmethods::phenopath_estimation(
#'   ref_data = ref_data,
#'   verbose = TRUE,
#'   seed = 111
#' )
#'
#' # 1) Simulate with default parameters
#' simulate_result <- simmethods::phenopath_simulation(
#'   parameters = estimate_result[["estimate_result"]],
#'   other_prior = NULL,
#'   return_format = "list",
#'   verbose = TRUE,
#'   seed = 111
#' )
#' ## counts
#' counts <- simulate_result[["simulate_result"]][["count_data"]]
#' dim(counts)
#'
#' # 2) 5000 cells and 6000 genes
#' simulate_result <- simmethods::phenopath_simulation(
#'   parameters = estimate_result[["estimate_result"]],
#'   other_prior = list(nCells = 5000,
#'                      nGenes = 6000),
#'   return_format = "list",
#'   verbose = TRUE,
#'   seed = 111
#' )
#'
#' ## counts
#' counts <- simulate_result[["simulate_result"]][["count_data"]]
#' dim(counts)
#' }
#'
phenopath_simulation <- function(parameters,
                                 other_prior = NULL,
                                 return_format,
                                 verbose = FALSE,
                                 seed
){

  ##############################################################################
  ####                            Environment                                ###
  ##############################################################################
  if(!requireNamespace("splatter", quietly = TRUE)){
    message("Splatter is not installed on your device")
    message("Installing splatter...")
    BiocManager::install("phenopath")
  }
  ##############################################################################
  ####                               Check                                   ###
  ##############################################################################
  assertthat::assert_that(class(parameters) == "PhenoParams")
  # nCells
  if(!is.null(other_prior[["nCells"]])){
    parameters <- splatter::setParam(parameters, name = "nCells", value = other_prior[["nCells"]])
  }
  # nGenes
  if(!is.null(other_prior[["nGenes"]])){
    gene_assign <- simutils::proportionate(number = other_prior[["nGenes"]],
                                           result_sum_strict = other_prior[["nGenes"]],
                                           prop = rep(0.25, 4),
                                           prop_sum_strict = 1,
                                           digits = 0)
    parameters <- splatter::setParam(parameters, name = "n.de", value = gene_assign[1])
    parameters <- splatter::setParam(parameters, name = "n.pst", value = gene_assign[2])
    parameters <- splatter::setParam(parameters, name = "n.pst.beta", value = gene_assign[3])
    parameters <- splatter::setParam(parameters, name = "n.de.pst.beta", value = gene_assign[4])
  }

  # Get params to check
  params_check <- splatter::getParams(parameters, c("nCells",
                                                    "nGenes"))

  # Return to users
  message(paste0("nCells: ", params_check[['nCells']]))
  message(paste0("nGenes: ", params_check[['nGenes']]))

  # Get the parameters we are going to use
  nCells <- splatter::getParam(parameters, "nCells")
  nGenes <- splatter::getParam(parameters, "nGenes")
  n.de <- splatter::getParam(parameters, "n.de")
  n.pst <- splatter::getParam(parameters, "n.pst")
  n.pst.beta <- splatter::getParam(parameters, "n.pst.beta")
  n.de.pst.beta <- splatter::getParam(parameters, "n.de.pst.beta")
  ##############################################################################
  ####                            Simulation                                 ###
  ##############################################################################
  if(verbose){
    message("Simulating datasets using phenopath")
  }
  # Seed
  parameters <- splatter::setParam(parameters, name = "seed", value = seed)
  # Estimation
  simulate_detection <- peakRAM::peakRAM(
    pheno_sim <- phenopath::simulate_phenopath(N = nCells,
                                               G_de = n.de,
                                               G_pst = n.pst,
                                               G_pst_beta = n.pst.beta,
                                               G_de_pst_beta = n.de.pst.beta)
  )
  # Row and column names
  cell.names <- paste0("Cell", seq_len(nCells))
  gene.names <- paste0("Gene", seq_len(nGenes))
  # Counts
  exprs <- t(pheno_sim$y)
  counts <- 2 ^ exprs - 1
  counts[counts < 0] <- 0
  counts <- round(counts)
  rownames(counts) <- gene.names
  colnames(counts) <- cell.names
  # Col data
  col_data <- data.frame("cell_name" = cell.names)
  rownames(col_data) <- cell.names
  # Row data
  row_data <- data.frame("gene_name" = gene.names)
  rownames(row_data) <- gene.names
  # SCE object
  simulate_result <- SingleCellExperiment::SingleCellExperiment(assays = list(counts = counts),
                                                                colData = col_data,
                                                                rowData = row_data)
  ##############################################################################
  ####                        Format Conversion                              ###
  ##############################################################################
  simulate_result <- simutils::data_conversion(SCE_object = simulate_result,
                                               return_format = return_format)

  ##############################################################################
  ####                           Ouput                                       ###
  ##############################################################################
  simulate_output <- list(simulate_result = simulate_result,
                          simulate_detection = simulate_detection)
  return(simulate_output)
}


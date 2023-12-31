#' Estimate Parameters From Real Datasets by hierarchicell
#'
#' This function is used to estimate useful parameters from a real dataset by
#' using `compute_data_summaries` function in hierarchicell package.
#'
#' @param ref_data A count matrix. Each row represents a gene and each column
#' represents a cell.
#' @param verbose Logical.
#' @param seed An integer of a random seed.
#' @param other_prior A list with names of certain parameters. Some methods need
#' extra parameters to execute the estimation step, so you must input them. In
#' simulation step, the number of cells, genes, groups, batches, the percent of
#' DEGs are usually customed, so before simulating a dataset you must point it out.
#' For more customed parameters, see [hierarchicell::compute_data_summaries()]
#' @importFrom peakRAM peakRAM
#' @return A list contains the estimated parameters and the results of execution
#' detection.
#' @export
#' @references
#' Zimmerman K D, Langefeld C D. Hierarchicell: an R-package for estimating power for tests of differential expression with single-cell data. BMC genomics, 2021, 22(1): 1-8. <https://doi.org/10.1186/s12864-021-07635-w>
#'
#' Github URL: <https://github.com/kdzimm/hierarchicell>
#'
#' @examples
#' \dontrun{
#' ref_data <- SingleCellExperiment::counts(scater::mockSCE())
#' ## estimation
#' estimate_result <- simmethods::hierarchicell_estimation(
#'   ref_data = ref_data,
#'   other_prior = NULL,
#'   verbose = TRUE,
#'   seed = 111
#' )
#' }
#'
hierarchicell_estimation <- function(ref_data,
                                     verbose = FALSE,
                                     other_prior = NULL,
                                     seed
){
  ##############################################################################
  ####                            Environment                                ###
  ##############################################################################
  if(!requireNamespace("hierarchicell", quietly = TRUE)){
    message("hierarchicell is not installed on your device...")
    message("Installing hierarchicell...")
    devtools::install_github("kdzimm/hierarchicell")
  }
  ##############################################################################
  ####                               Check                                   ###
  ##############################################################################
  if(!is.matrix(ref_data)){
    ref_data <- as.matrix(ref_data)
  }
  hierarchicell_data_dim <- dim(ref_data)
  ref_data <- hierarchicell::filter_counts(ref_data,
                                           gene_thresh = 0,
                                           cell_thresh = 0)
  if(is.null(other_prior[["type"]])){
    cat("You do not set the type of the data (Raw or Norm), we will set 'Raw' by default\n")
    other_prior[["type"]] <- "Raw"
  }
  ##############################################################################
  ####                            Estimation                                 ###
  ##############################################################################
  if(verbose){
    message("Estimating parameters using hierarchicell")
  }
  # Seed
  set.seed(seed)
  # Estimation
  estimate_detection <- peakRAM::peakRAM(
    estimate_result <- hierarchicell::compute_data_summaries(expr = ref_data,
                                                             type = other_prior[["type"]])
  )
  estimate_result[["hierarchicell_data_dim"]] <- hierarchicell_data_dim
  ##############################################################################
  ####                           Ouput                                       ###
  ##############################################################################
  estimate_output <- list(estimate_result = estimate_result,
                          estimate_detection = estimate_detection)
  return(estimate_output)
}



#' Simulate Datasets by hierarchicell
#'
#' This function is used to simulate datasets from learned parameters by `simulate_hierarchicell`
#' function in hierarchicell package.
#'
#' @param parameters A object generated by [hierarchicell::compute_data_summaries()]
#' @param other_prior A list with names of certain parameters. Some methods need
#' extra parameters to execute the estimation step, so you must input them. In
#' simulation step, the number of cells, genes, groups, batches, the percent of
#' DEGs are usually customed, so before simulating a dataset you must point it out.
#' See `Details` below for more information.
#' @param return_format A character. Alternative choices: list, SingleCellExperiment,
#' Seurat, h5ad. If you select `h5ad`, you will get a path where the .h5ad file saves to.
#' @param verbose Logical. Whether to return messages or not.
#' @param seed A random seed.
#' @export
#' @details
#' In hierarchicell, users can set `nCells`, `nGenes` and `fc.group` directly.
#' There are some notes that users should know:
#'
#' 1. hierarchicell can only simulate **two** groups.
#' 2. Some cells in the result may contain NA values across all genes due to the failing of GLM fitting.
#' 3. hierarchicell does not return the information of DEGs and we can not know which genes are DEGs.
#'
#' For more information, see `Examples` and [hierarchicell::simulate_hierarchicell]
#'
#' @references
#' Zimmerman K D, Langefeld C D. Hierarchicell: an R-package for estimating power for tests of differential expression with single-cell data. BMC genomics, 2021, 22(1): 1-8. <https://doi.org/10.1186/s12864-021-07635-w>
#'
#' Github URL: <https://github.com/kdzimm/hierarchicell>
#'
#' @examples
#' \dontrun{
#' ref_data <- SingleCellExperiment::counts(scater::mockSCE())
#' ## estimation
#' estimate_result <- simmethods::hierarchicell_estimation(
#'   ref_data = ref_data,
#'   other_prior = NULL,
#'   verbose = TRUE,
#'   seed = 111
#' )
#'
#' # 1) Simulate with default parameters
#' simulate_result <- simmethods::hierarchicell_simulation(
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
#' # 2) Customed parameters: cell and gene number, fold change of DEGs. (But hierarchicell
#' # does not tell us which genes are DEGs). Note that some cells may contain NA values
#' # across all genes due to the failing of GLM fitting.
#' simulate_result <- simmethods::hierarchicell_simulation(
#'   parameters = estimate_result[["estimate_result"]],
#'   other_prior = list(nCells = 2000,
#'                      nGenes = 4000,
#'                      fc.group = 4),
#'   return_format = "list",
#'   verbose = TRUE,
#'   seed = 111
#' )
#'
#' ## counts
#' counts <- simulate_result[["simulate_result"]][["count_data"]]
#' dim(counts)
#' ## Remove NA cells
#' if(!requireNamespace("tidyr", quietly = TRUE)){utils::install.packages("tidyr")}
#' filter_counts <- as.matrix(t(tidyr::drop_na(as.data.frame(t(counts)))))
#' dim(filter_counts)
#' }
#'
hierarchicell_simulation <- function(parameters,
                                     other_prior = NULL,
                                     return_format,
                                     verbose = FALSE,
                                     seed
){
  ##############################################################################
  ####                            Environment                                ###
  ##############################################################################
  if(!requireNamespace("hierarchicell", quietly = TRUE)){
    message("hierarchicell is not installed on your device...")
    message("Installing hierarchicell...")
    devtools::install_github("kdzimm/hierarchicell")
  }
  other_prior[["data_summaries"]] <- parameters
  ## nCells
  if(!is.null(other_prior[["nCells"]])){
    if(length(other_prior[["nCells"]]) == 1){
      other_prior[["cells_per_control"]] <- ceiling(other_prior[["nCells"]]/2)
      other_prior[["cells_per_case"]] <- floor(other_prior[["nCells"]]/2)
    }
    if(length(other_prior[["nCells"]]) == 2){
      other_prior[["cells_per_control"]] <- other_prior[["nCells"]][1]
      other_prior[["cells_per_case"]] <- other_prior[["nCells"]][2]
    }
  }else{
    other_prior[["nCells"]] <- parameters[["hierarchicell_data_dim"]][2]
    other_prior[["cells_per_control"]] <- ceiling(other_prior[["nCells"]]/2)
    other_prior[["cells_per_case"]] <- floor(other_prior[["nCells"]]/2)
  }
  ## nGenes
  if(!is.null(other_prior[["nGenes"]])){
    other_prior[["n_genes"]] <- other_prior[["nGenes"]]
  }else{
    other_prior[["n_genes"]] <- parameters[["hierarchicell_data_dim"]][1]
  }
  ## fc.group
  if(!is.null(other_prior[["fc.group"]])){
    other_prior[["foldchange"]] <- other_prior[["fc.group"]]
  }else{
    other_prior[["foldchange"]] <- 2
  }
  ## case and control
  if(is.null(other_prior[["n_cases"]])){
    other_prior[["n_cases"]] <- 1
  }
  if(is.null(other_prior[["n_controls"]])){
    other_prior[["n_controls"]] <- 1
  }
  ## n_per_group
  if(is.null(other_prior[["n_per_group"]])){
    other_prior[["n_per_group"]] <- 1
  }
  ##############################################################################
  ####                               Check                                   ###
  ##############################################################################
  simulate_formals <- simutils::change_parameters(function_expr = "hierarchicell::simulate_hierarchicell",
                                                  other_prior = other_prior,
                                                  step = "simulation")
  # Return to users
  message(paste0("nCells: ", simulate_formals[['cells_per_control']] + simulate_formals[['cells_per_case']]))
  message(paste0("nGenes: ", simulate_formals[['n_genes']]))
  message("nGroups: 2")
  message(paste0("fc.group: ", simulate_formals[['foldchange']]))
  ##############################################################################
  ####                            Simulation                                 ###
  ##############################################################################
  if(verbose){
    message("Simulating datasets using hierarchicell")
  }
  # Seed
  set.seed(seed)
  # Simulation
  simulate_detection <- peakRAM::peakRAM(
    simulate_result <- do.call(hierarchicell::simulate_hierarchicell, simulate_formals)
  )
  ##############################################################################
  ####                        Format Conversion                              ###
  ##############################################################################
  group <- paste0("Group", ifelse(simulate_result$Status=="Case", 2, 1))
  if(length(group) != other_prior[["nCells"]]){
    group <- group[1:other_prior[["nCells"]]]
    simulate_result <- simulate_result[1:other_prior[["nCells"]], ]
  }
  simulate_result <- t(simulate_result[, -c(1:3)])
  ## colnames rownames
  colnames(simulate_result) <- paste0("Cell", 1:ncol(simulate_result))
  rownames(simulate_result) <- paste0("Gene", 1:nrow(simulate_result))
  counts <- simulate_result
  ## col_data
  col_data <- data.frame("cell_name" = colnames(counts),
                         "group" = group)
  ## row data
  row_data <- data.frame("gene_name" = rownames(counts))
  # Establish SingleCellExperiment
  simulate_result <- SingleCellExperiment::SingleCellExperiment(list(counts = counts),
                                                                colData = col_data,
                                                                rowData = row_data)

  simulate_result <- simutils::data_conversion(SCE_object = simulate_result,
                                               return_format = return_format)

  ##############################################################################
  ####                           Ouput                                       ###
  ##############################################################################
  simulate_output <- list(simulate_result = simulate_result,
                          simulate_detection = simulate_detection)
  return(simulate_output)
}


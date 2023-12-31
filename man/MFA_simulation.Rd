% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/36-MFA.R
\name{MFA_simulation}
\alias{MFA_simulation}
\title{Simulate Datasets by MFA}
\usage{
MFA_simulation(
  parameters,
  other_prior = NULL,
  return_format,
  verbose = FALSE,
  seed
)
}
\arguments{
\item{parameters}{A object generated by \code{\link[splatter:mfaEstimate]{splatter::mfaEstimate()}}}

\item{other_prior}{A list with names of certain parameters. Some methods need
extra parameters to execute the estimation step, so you must input them. In
simulation step, the number of cells, genes, groups, batches, the percent of
DEGs are usually customed, so before simulating a dataset you must point it out.
See \code{Details} below for more information.}

\item{return_format}{A character. Alternative choices: list, SingleCellExperiment,
Seurat, h5ad. If you select \code{h5ad}, you will get a path where the .h5ad file saves to.}

\item{verbose}{Logical. Whether to return messages or not.}

\item{seed}{A random seed.}
}
\description{
Simulate Datasets by MFA
}
\details{
#' @details
In MFA, users can only set \code{nCells} and \code{nGenes} to specify the number of cells and genes in the
simulated dataset. See \code{Examples} for instructions.

For more customed parameters, see \code{\link[splatter:MFAParams]{splatter::MFAParams()}} and \code{\link[splatter:mfaSimulate]{splatter::mfaSimulate()}}.
}
\examples{
\dontrun{
ref_data <- simmethods::data
## estimation
estimate_result <- simmethods::MFA_estimation(
  ref_data = ref_data,
  verbose = TRUE,
  seed = 111
)

# 1) Simulate with default parameters
simulate_result <- simmethods::MFA_simulation(
  parameters = estimate_result[["estimate_result"]],
  other_prior = NULL,
  return_format = "list",
  verbose = TRUE,
  seed = 111
)
## counts
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)

# 2) 5000 cells and 5000 genes
simulate_result <- simmethods::MFA_simulation(
  parameters = estimate_result[["estimate_result"]],
  other_prior = list(nCells = 5000,
                     nGenes = 5000),
  return_format = "list",
  verbose = TRUE,
  seed = 111
)

## counts
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)
}

}
\references{
Campbell K R, Yau C. Probabilistic modeling of bifurcations in single-cell gene expression data using a Bayesian mixture of factor analyzers. Wellcome open research, 2017, 2. \url{https://doi.org/10.12688/wellcomeopenres.11087.1}

Github URL: \url{https://github.com/kieranrcampbell/mfa}
}

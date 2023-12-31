% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/25-CancerInSilico.R
\name{CancerInSilico_simulation}
\alias{CancerInSilico_simulation}
\title{Simulate Datasets by CancerInSilico}
\usage{
CancerInSilico_simulation(
  parameters,
  other_prior = NULL,
  return_format,
  verbose = FALSE,
  seed
)
}
\arguments{
\item{parameters}{A object generated by \code{CancerInSilico::calibratePathway()}}

\item{other_prior}{A list with names of certain parameters. Some methods need
extra parameters to execute the estimation step, so you must input them. In
simulation step, the number of cells, genes, groups, batches, the percent of
DEGs are usually customed, so before simulating a dataset you must point it out.
See \code{Details} below for more information.}

\item{return_format}{A character. Alternatives choices: list, SingleCellExperiment,
Seurat, h5ad}

\item{verbose}{Logical. Whether to return messages or not.}

\item{seed}{A random seed.}
}
\description{
This function is used to simulate datasets from learned parameters by \code{inSilicoGeneExpression}
function in CancerInSilico package.
}
\details{
In CancerInSilico, users can only set \code{nCells} to specify the number of cells. See \code{Examples}.
For more unusually used parameters in CancerInSilico, see \code{CancerInSilico::inSilicoGeneExpression()}
}
\examples{
\dontrun{
ref_data <- simmethods::data
## estimation
estimate_result <- simmethods::CancerInSilico_estimation(
  ref_data = ref_data,
  verbose = TRUE,
  seed = 111
)

# 1) Simulate with default parameters
simulate_result <- simmethods::CancerInSilico_simulation(
  parameters = estimate_result[["estimate_result"]],
  other_prior = NULL,
  return_format = "list",
  verbose = TRUE,
  seed = 111
)
## counts
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)

# 2) 2000 cells
simulate_result <- simmethods::CancerInSilico_simulation(
  parameters = estimate_result[["estimate_result"]],
  other_prior = list(nCells = 2000),
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
Sherman T D, Kagohara L T, Cao R, et al. CancerInSilico: An R/Bioconductor package for combining mathematical and statistical modeling to simulate time course bulk and single cell gene expression data in cancer. PLoS computational biology, 2019, 14(4): e1006935. \url{https://doi.org/10.1371/journal.pcbi.1006935}

Bioconductor URL: \url{https://bioconductor.org/packages/release/bioc/html/CancerInSilico.html}

Github URL: \url{https://github.com/FertigLab/CancerInSilico}
}

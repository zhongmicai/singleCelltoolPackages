% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/33-dyngen.R
\name{dyngen_simulation}
\alias{dyngen_simulation}
\title{Simulate Datasets by dyngen}
\usage{
dyngen_simulation(
  parameters,
  other_prior = NULL,
  return_format,
  verbose = FALSE,
  seed
)
}
\arguments{
\item{parameters}{A object generated by \code{\link[dynwrap]{infer_trajectory}}}

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
Simulate Datasets by dyngen
}
\details{
In dyngen, users can only set \code{nCells} and \code{nGenes} to specify the number of cells and genes in the
simulated dataset. See \code{Examples} for instructions.
}
\examples{
\dontrun{
ref_data <- simmethods::data

## estimation with cell group information
group_condition <- paste0("Group", as.numeric(simmethods::group_condition))
estimate_result <- simmethods::dyngen_estimation(
  ref_data = ref_data,
  other_prior = list(group.condition = group_condition),
  verbose = TRUE,
  seed = 111
)

# 1) Simulate with default parameters (need a lot of memory)
simulate_result <- simmethods::dyngen_simulation(
  parameters = estimate_result[["estimate_result"]],
  other_prior = NULL,
  return_format = "list",
  verbose = TRUE,
  seed = 111
)
## counts
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)

2) 100 cells and 100 genes
simulate_result <- simmethods::dyngen_simulation(
  parameters = estimate_result[["estimate_result"]],
  other_prior = list(nCells = 100,
                     nGenes = 100),
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
Cannoodt R, Saelens W, Deconinck L, et al. Spearheading future omics analyses using dyngen, a multi-modal simulator of single cells. Nature Communications, 2021, 12(1): 1-9. \url{https://doi.org/10.1038/s41467-021-24152-2}

CRAN URL: \url{https://cran.r-project.org/web/packages/dyngen/index.html}

Github URL: \url{https://github.com/dynverse/dyngen}
}

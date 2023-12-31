% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/16-zinbwaveZinger.R
\name{zinbwaveZinger_simulation}
\alias{zinbwaveZinger_simulation}
\title{Simulate Datasets by zinbwaveZinger}
\usage{
zinbwaveZinger_simulation(
  ref_data,
  parameters,
  other_prior = NULL,
  return_format,
  verbose = FALSE,
  seed
)
}
\arguments{
\item{ref_data}{A matrix for one dataset or a list of datasets with their own
names. This is usually unused except for some methods, e.g. SCRIP, scDesign,
zingeR, zinbwaveZinger.}

\item{parameters}{A object generated by \code{\link[zinbwaveZingercollected:NBsimSingleCell_zinbwaveZinger]{zinbwaveZingercollected::NBsimSingleCell_zinbwaveZinger()}}}

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
This function is used to simulate datasets from learned parameters by \code{NBsimSingleCell_zinbwaveZinger}
function in zinbwaveZingercollected package.
}
\details{
In addtion to simulate datasets with default parameters, users want to simulate
other kinds of datasets, e.g. a counts matrix with 2 or more cell groups. In
zinbwaveZinger, you can set extra parameters to simulate datasets.

The customed parameters you can set are below:
\enumerate{
\item nCells. In zinbwaveZinger, You can directly set \code{other_prior = list(nCells = 5000)} to simulate 5000 cells. nCells must be larger than the reference data.
\item nGenes. You can directly set \code{other_prior = list(nGenes = 5000)} to simulate 5000 genes. nGenes must be larger than the reference data.
\item de.prob. You can directly set \code{other_prior = list(de.prob = 0.2)} to simulate DEGs that account for 20 percent of all genes.
\item fc.group. You can directly set \code{other_prior = list(fc.group = 2)} to specify the fold change of DEGs.
}

For more customed parameters in zinbwaveZinger, please check \code{\link[zingeR:NBsimSingleCell]{zingeR::NBsimSingleCell()}}.
}
\examples{
\dontrun{
ref_data <- simmethods::data
group_condition <- as.numeric(simmethods::group_condition)

estimate_result <- simmethods::zinbwaveZinger_estimation(
  ref_data = ref_data,
  other_prior = list(group.condition = group_condition),
  verbose = TRUE,
  seed = 111
)

## Default parameters
simulate_result <- simmethods::zinbwaveZinger_simulation(
  ref_data = ref_data,
  other_prior = list(group.condition = group_condition),
  parameters = estimate_result[["estimate_result"]],
  return_format = "list",
  verbose = TRUE,
  seed = 111
)
## counts
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)
## cell information
col_data <- simulate_result[["simulate_result"]][["col_meta"]]
## gene information
row_data <- simulate_result[["simulate_result"]][["row_meta"]]
head(row_data)


## In zinbwaveZinger, users can only set the number of cells and genes which is higher
## than the reference data. In addtion, the proportion of DEGs and fold change are
## able to be customed. Not that zinbwaveZinger dose not return cell group information.
## Default parameters
simulate_result <- simmethods::zinbwaveZinger_simulation(
  ref_data = ref_data,
  other_prior = list(group.condition = group_condition,
                     nCells = 1000,
                     nGenes = 5000,
                     de.prob = 0.2,
                     fc.group = 4),
  parameters = estimate_result[["estimate_result"]],
  return_format = "list",
  verbose = TRUE,
  seed = 111
)
## counts
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)
## cell information
col_data <- simulate_result[["simulate_result"]][["col_meta"]]
## gene information
row_data <- simulate_result[["simulate_result"]][["row_meta"]]
head(row_data)
}

}
\references{
Github URL: \url{https://github.com/statOmics/zinbwaveZinger}
}

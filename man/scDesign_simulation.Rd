% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/11-scDesign.R
\name{scDesign_simulation}
\alias{scDesign_simulation}
\title{Simulate Datasets by scDesign}
\usage{
scDesign_simulation(
  ref_data,
  other_prior = NULL,
  return_format,
  verbose = FALSE,
  seed
)
}
\arguments{
\item{ref_data}{A matrix for one dataset or a list of datasets with their own
names. This is usually unused except for some methods, e.g. SCRIP, scDesign,
zingeR.}

\item{other_prior}{A list with names of certain parameters. Some methods need
extra parameters to execute the estimation step, so you must input them. In
simulation step, the number of cells, genes, groups, batches, the percent of
DEGs are usually customed, so before simulating a dataset you must point it out.
See \code{Details} below for more information.}

\item{return_format}{A character. Alternatives choices: list, SingleCellExperiment,
Seurat, h5ad. If you select \code{h5ad}, you will get a path where the .h5ad file saves to.}

\item{verbose}{Logical. Whether to return messages or not.}

\item{seed}{A random seed.}
}
\description{
This function is used to simulate datasets \code{design_data} function in scDesign package.
}
\details{
In addtion to simulate datasets with default parameters, users want to simulate
other kinds of datasets, e.g. a counts matrix with 2 or more cell groups. In
scDesign, you can set extra parameters to simulate datasets.

The customed parameters you can set are below:
\enumerate{
\item nCells. In scDesign, you can set nCells directly \code{other_prior = list(nCells = 1000)} to simulate 1000 cells.
\item nGroups. You can directly set \code{other_prior = list(nGroups = 3)} to simulate 3 groups. But the cells will be assigned to these three groups equally if you do not set \code{prob.group} below.
\item prob.group. You can directly set \code{other_prior = list(prob.group = c(0.2, 0.3, 0.5))} to assign three proportions of cell groups. Note that the number of groups always equals to the length of the vector.
\item de.prob. You can directly set \code{other_prior = list(de.prob = 0.2)} to simulate DEGs that account for 20 percent of all genes.
\item fc.group. You can directly set \code{other_prior = list(fc.group = 2)} to specify the fold change of DEGs. But note that, you would better set \code{fc.group} because scDesign dose not return the fold changes of DEGs in the result.
}

For more customed parameters in scDesign, please check \code{\link[scDesign:design_data]{scDesign::design_data()}}.
}
\examples{
\dontrun{
ref_data <- simmethods::data

## Simulate datasets with default parameters
simulate_result <- scDesign_simulation(ref_data = ref_data,
                                       return_format = "list",
                                       verbose = TRUE,
                                       seed = 111)
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)


## Simulate two groups with 20\% proportion of DEGs and 2 fold change. Note that
## scDesign does not provide fold changes for genes so users would better set
## fc.group parameter in simulation function.
simulate_result <- scDesign_simulation(ref_data = ref_data,
                                       other_prior = list(nCells = 1000,
                                                          nGroups = 2,
                                                          de.prob = 0.2,
                                                          fc.group = 2),
                                       return_format = "list",
                                       verbose = TRUE,
                                       seed = 111)
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)
## cell information
col_data <- simulate_result[["simulate_result"]][["col_meta"]]
table(col_data$group)
## gene information
row_data <- simulate_result[["simulate_result"]][["row_meta"]]
table(row_data$de_gene)/4000
table(row_data$up_down)


## Simulate three groups with 20\% proportion of DEGs and 4 fold change. 20\%, 40\%
## and 40\% of cells belong to Group1, Group2 and Group3, respectively.
simulate_result <- scDesign_simulation(ref_data = ref_data,
                                       other_prior = list(nCells = 1000,
                                                          nGroups = 3,
                                                          prob.group = c(0.2, 0.4, 0.4),
                                                          de.prob = 0.2,
                                                          fc.group = 4),
                                       return_format = "list",
                                       verbose = TRUE,
                                       seed = 111)
counts <- simulate_result[["simulate_result"]][["count_data"]]
dim(counts)
## cell information
col_data <- simulate_result[["simulate_result"]][["col_meta"]]
table(col_data$group)
}

}
\references{
Li W V, Li J J. A statistical simulator scDesign for rational scRNA-seq experimental design. Bioinformatics, 2019, 35(14): i41-i50. \url{https://doi.org/10.1093/bioinformatics/btz321}

Github URL: \url{https://github.com/Vivianstats/scDesign}
}

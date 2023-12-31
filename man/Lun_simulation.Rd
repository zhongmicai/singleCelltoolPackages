% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/05-Lun.R
\name{Lun_simulation}
\alias{Lun_simulation}
\title{Simulate Datasets by Lun}
\usage{
Lun_simulation(
  parameters,
  other_prior = NULL,
  return_format,
  verbose = FALSE,
  seed
)
}
\arguments{
\item{parameters}{A object generated by \code{\link[splatter:lunEstimate]{splatter::lunEstimate()}}}

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
This function is used to simulate datasets from learned parameters by \code{lunSimulate}
function in Splatter package.
}
\details{
In addtion to simulate datasets with default parameters, users want to simulate
other kinds of datasets, e.g. a counts matrix with 2 or more cell groups. In
Lun, you can set extra parameters to simulate datasets.

The customed parameters you can set are below:
\enumerate{
\item nCells. In Lun, you can not set nCells directly and should set groupCells instead. For example, if you want to simulate 1000 cells, you can type \code{other_prior = list(groupCells = 1000)}. If you type \code{other_prior = list(groupCells = c(500, 500))}, the simulated data will have two groups
\item nGenes. You can directly set \code{other_prior = list(nGenes = 5000)} to simulate 5000 genes.
\item nGroups. You can not directly set \code{other_prior = list(nGroups = 3)} to simulate 3 groups. Instead, you should set \code{other_prior = list(prob.group = c(0.2, 0.3, 0.5))} where the sum of group probabilities must equal to 1.
\item de.prob. You can directly set \code{other_prior = list(de.prob = 0.2)} to simulate DEGs that account for 20 percent of all genes.
\item prob.group. You can directly set \code{other_prior = list(prob.group = c(0.2, 0.3, 0.5))} to assign three proportions of cell groups. Note that the number of groups always equals to the length of the vector.
\item fc.up.group. You can directly set \code{other_prior = list(fc.up.group = 2)} to specify the foldchange of up-regulated DEGs.
\item fc.down.group. You can directly set \code{other_prior = list(fc.down.group = 0.5)} to specify the foldchange of down-regulated DEGs.
}

For more customed parameters in Lun, please check \code{\link[splatter:LunParams]{splatter::LunParams()}}.
}
\examples{
\dontrun{
# Load data
ref_data <- simmethods::data
# Estimate parameters
estimate_result <- simmethods::Lun_estimation(ref_data = ref_data,
                                              verbose = TRUE,
                                              seed = 10)

# (1) Simulate 500 cells (Since we can not set nCells directly, so we can set
# groupCells (a numeric vector)) and 2000 genes
simulate_result <- simmethods::Lun_simulation(parameters = estimate_result[["estimate_result"]],
                                              other_prior = list(groupCells = 500,
                                                                 nGenes = 2000),
                                              return_format = "list",
                                              verbose = TRUE,
                                              seed = 111)
count_data <- simulate_result[["simulate_result"]][["count_data"]]
dim(count_data)


# (2) Simulate one group
simulate_result <- simmethods::Lun_simulation(parameters = estimate_result[["estimate_result"]],
                                              other_prior = NULL,
                                              return_format = "list",
                                              verbose = TRUE,
                                              seed = 111)
count_data <- simulate_result[["simulate_result"]][["count_data"]]
dim(count_data)


# (3) Simulate two groups (de.prob = 0.2)
simulate_result <- simmethods::Lun_simulation(parameters = estimate_result[["estimate_result"]],
                                              other_prior = list(prob.group = c(0.4, 0.6),
                                                                 de.prob = 0.2),
                                              return_format = "list",
                                              verbose = TRUE,
                                              seed = 111)
count_data <- simulate_result[["simulate_result"]][["count_data"]]
dim(count_data)
## cell information
col_data <- simulate_result[["simulate_result"]][["col_meta"]]
table(col_data$group)
## gene information
row_data <- simulate_result[["simulate_result"]][["row_meta"]]
### The result of Lun contains the factors of different groups and uses can
### calculate the fold change by division. For example, the DEFactors of A gene
### in Group1 and Group2 are respectively 2 and 1, and the fold change of A gene
### is 2/1=2 or 1/2=0.5.
fc_group1_to_group2 <- row_data$DEFacGroup2/row_data$DEFacGroup1
table(fc_group1_to_group2 != 1)[2]/4000 ## de.prob = 0.2
### number of all DEGs
table(row_data$de_gene)[2]/4000 ## de.prob = 0.2


# (4) Simulate two groups (de.prob = 0.2, fc.up.group = 2, fc.down.group = 0.5)
simulate_result <- simmethods::Lun_simulation(parameters = estimate_result[["estimate_result"]],
                                              other_prior = list(prob.group = c(0.4, 0.6),
                                                                 de.prob = 0.2,
                                                                 fc.up.group = 2,
                                                                 fc.down.group = 0.5),
                                              return_format = "list",
                                              verbose = TRUE,
                                              seed = 111)
count_data <- simulate_result[["simulate_result"]][["count_data"]]
dim(count_data)
## cell information
col_data <- simulate_result[["simulate_result"]][["col_meta"]]
table(col_data$group)
## gene information
row_data <- simulate_result[["simulate_result"]][["row_meta"]]
### The result of Lun contains the factors of different groups and uses can
### calculate the fold change by division. For example, the DEFactors of A gene
### in Group1 and Group2 are respectively 2 and 1, and the fold change of A gene
### is 2/1=2 or 1/2=0.5.
fc_group1_to_group2 <- row_data$DEFacGroup2/row_data$DEFacGroup1
table(fc_group1_to_group2 != 1)[2]/4000 ## de.prob = 0.2
### number of all DEGs
table(row_data$de_gene)[2]/4000 ## de.prob = 0.2
### fc.up.group
max(row_data$DEFacGroup1)
### fc.down.group
min(row_data$DEFacGroup1)
}

}
\references{
Zappia L, Phipson B, Oshlack A. Splatter: simulation of single-cell RNA sequencing data. Genome biology, 2017, 18(1): 1-15. \url{https://doi.org/10.1186/s13059-017-1305-0}

Bioconductor URL: \url{https://bioconductor.org/packages/release/bioc/html/splatter.html}

Github URL: \url{https://github.com/Oshlack/splatter}
}

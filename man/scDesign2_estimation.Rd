% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/12-scDesign2.R
\name{scDesign2_estimation}
\alias{scDesign2_estimation}
\title{Estimate Parameters From Real Datasets by scDesign2}
\usage{
scDesign2_estimation(ref_data, verbose = FALSE, other_prior = NULL, seed)
}
\arguments{
\item{ref_data}{A count matrix. Each row represents a gene and each column
represents a cell.}

\item{verbose}{Logical.}

\item{other_prior}{A list with names of certain parameters. Some methods need
extra parameters to execute the estimation step, so you must input them. In
simulation step, the number of cells, genes, groups, batches, the percent of
DEGs are usually customed, so before simulating a dataset you must point it out.
See \code{Details} below for more information.}

\item{seed}{An integer of a random seed.}
}
\value{
A list contains the estimated parameters and the results of execution
detection.
}
\description{
This function is used to estimate useful parameters from a real dataset by
using \code{fit_model_scDesign2} function in scDesign2 package.
}
\details{
In scDesign2, users can input cell group or cell type information before estimating
parameters from real datasets. For more instructions or information, see \code{Examples}
or \code{\link[scDesign2:fit_model_scDesign2]{scDesign2::fit_model_scDesign2()}}
}
\examples{
\dontrun{
ref_data <- simmethods::data

## cell groups
group_condition <- as.numeric(simmethods::group_condition)
## In scDesign2, cell group information is not neccessary which indicates the type
## that each cell belongs to.
estimate_result <- simmethods::scDesign2_estimation(
  ref_data = ref_data,
  other_prior = list(group.condition = group_condition),
  verbose = TRUE,
  seed = 111
)
## Or you can input information of cell types via cell_type_sel parameter described
## in scDesign2::fit_model_scDesign2 function
estimate_result <- simmethods::scDesign2_estimation(
  ref_data = ref_data,
  other_prior = list(cell_type_sel = paste0("cell_type",
                                            group_condition)),
  verbose = TRUE,
  seed = 111
)
}

}
\references{
Sun T, Song D, Li W V, et al. scDesign2: a transparent simulator that generates high-fidelity single-cell gene expression count data with gene correlations captured. Genome biology, 2021, 22(1): 1-37. \url{https://doi.org/10.1186/s13059-021-02367-2}

Github URL: \url{https://github.com/JSB-UCLA/scDesign2}
}

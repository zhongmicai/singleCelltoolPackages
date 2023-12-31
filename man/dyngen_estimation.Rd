% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/33-dyngen.R
\name{dyngen_estimation}
\alias{dyngen_estimation}
\title{Estimate Parameters From Real Datasets by dyngen}
\usage{
dyngen_estimation(ref_data, verbose = FALSE, other_prior, seed)
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
using \code{infer_trajectory} function in dynwrap package.
}
\details{
In dyngen, users can input cell group information if it is available. If cell
group information is not provided, the procedure will detect cell groups by
kmeans automatically.
See \code{Examples} for more instructions.
}
\examples{
\dontrun{
ref_data <- simmethods::data

estimate_result <- simmethods::dyngen_estimation(
  ref_data = ref_data,
  other_prior = NULL,
  verbose = TRUE,
  seed = 111
)

## estimation with cell group information
group_condition <- paste0("Group", as.numeric(simmethods::group_condition))
estimate_result <- simmethods::dyngen_estimation(
  ref_data = ref_data,
  other_prior = list(group.condition = group_condition),
  verbose = TRUE,
  seed = 111
)
}

}
\references{
Cannoodt R, Saelens W, Deconinck L, et al. Spearheading future omics analyses using dyngen, a multi-modal simulator of single cells. Nature Communications, 2021, 12(1): 1-9. \url{https://doi.org/10.1038/s41467-021-24152-2}

CRAN URL: \url{https://cran.r-project.org/web/packages/dyngen/index.html}

Github URL: \url{https://github.com/dynverse/dyngen}
}

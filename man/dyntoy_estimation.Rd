% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/32-dyntoy.R
\name{dyntoy_estimation}
\alias{dyntoy_estimation}
\title{Estimate Parameters From Real Datasets by dyntoy}
\usage{
dyntoy_estimation(ref_data, verbose = FALSE, other_prior = NULL, seed)
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
In dyntoy, users can input cell group information if it is available. If cell
group information is not provided, the procedure will detect cell groups by
kmeans automatically.
See \code{Examples} for more instructions.
}
\examples{
\dontrun{
ref_data <- simmethods::data

estimate_result <- simmethods::dyntoy_estimation(
  ref_data = ref_data,
  other_prior = NULL,
  verbose = TRUE,
  seed = 111
)

## estimation with cell group information
group_condition <- paste0("Group", as.numeric(simmethods::group_condition))
estimate_result <- simmethods::dyntoy_estimation(
  ref_data = ref_data,
  other_prior = list(group.condition = group_condition),
  verbose = TRUE,
  seed = 111
)
}

}
\references{
Github URL: \url{https://github.com/dynverse/dyntoy}
}

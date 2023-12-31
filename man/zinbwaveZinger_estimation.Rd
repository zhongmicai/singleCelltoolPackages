% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/16-zinbwaveZinger.R
\name{zinbwaveZinger_estimation}
\alias{zinbwaveZinger_estimation}
\title{Estimate Parameters From Real Datasets by zinbwaveZinger}
\usage{
zinbwaveZinger_estimation(ref_data, verbose = FALSE, other_prior = NULL, seed)
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
using \code{getDatasetMoMPositive} function in zinbwaveZingercollected package.
}
\details{
When you use zingeR to estimate parameters from a real dataset, you must input
a numeric vector to specify the groups that each cell belongs to, like
\verb{other_prior = list(group.condition = the numeric vector)}. See \code{Examples}
and learn from it.
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
}

}
\references{
Github URL: \url{https://github.com/statOmics/zinbwaveZinger}
}

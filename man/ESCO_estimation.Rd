% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/21-ESCO.R
\name{ESCO_estimation}
\alias{ESCO_estimation}
\title{Estimate Parameters From Real Datasets by ESCO}
\usage{
ESCO_estimation(ref_data, other_prior = NULL, verbose = FALSE, seed)
}
\arguments{
\item{ref_data}{A count matrix. Each row represents a gene and each column
represents a cell.}

\item{other_prior}{A list with names of certain parameters. Some methods need
extra parameters to execute the estimation step, so you must input them. In
simulation step, the number of cells, genes, groups, batches, the percent of
DEGs are usually customed, so before simulating a dataset you must point it out.
See \code{Details} below for more information.}

\item{verbose}{Logical.}

\item{seed}{An integer of a random seed.}
}
\value{
A list contains the estimated parameters and the results of execution
detection.
}
\description{
This function is used to estimate useful parameters from a real dataset by
using \code{escoEstimate} function in ESCO package.
}
\details{
In ESCO, users can input cell group information when it is available but in this case
ESCO is not stable and may fail to estimate suitable distribution parameters
from real data.
If users want to estimate tree structured parameters, set \code{other_prior = list(tree = TRUE)}.
For more instructions, see \code{Examples}.
}
\examples{
\dontrun{
ref_data <- simmethods::data

estimate_result <- simmethods::ESCO_estimation(ref_data = ref_data,
                                               other_prior = NULL,
                                               verbose = TRUE,
                                               seed = 111)
If cell group information is available, it can be another prior information.
But there is a bug in ESCO, and some datasets can not be estimated due to the
failing estimation of distribution parameters.
group_condition <- as.numeric(simmethods::group_condition)
estimate_result <- simmethods::ESCO_estimation(
  ref_data = ref_data,
  other_prior = list(group.condition = group_condition),
  verbose = TRUE,
  seed = 111
)

# ----------------- Estimate tree or trajectory structured data -------------
# Load data
ref_data <- simmethods::data
# Estimate parameters
estimate_result <- simmethods::ESCO_estimation(ref_data = ref_data,
                                               other_prior = list(tree = TRUE),
                                               verbose = TRUE,
                                               seed = 10)
}

}
\references{
Tian J, Wang J, Roeder K. ESCO: single cell expression simulation incorporating gene co-expression. Bioinformatics, 2021, 37(16): 2374-2381. \url{https://doi.org/10.1093/bioinformatics/btab116}

Github URL: \url{https://github.com/JINJINT/ESCO}
}

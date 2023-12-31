% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/25-CancerInSilico.R
\name{CancerInSilico_estimation}
\alias{CancerInSilico_estimation}
\title{Estimate Parameters From Real Datasets by CancerInSilico}
\usage{
CancerInSilico_estimation(ref_data, verbose = FALSE, seed)
}
\arguments{
\item{ref_data}{A count matrix. Each row represents a gene and each column
represents a cell.}

\item{verbose}{Logical.}

\item{seed}{An integer of a random seed.}
}
\value{
A list contains the estimated parameters and the results of execution
detection.
}
\description{
This function is used to estimate useful parameters from a real dataset by
using \code{calibratePathway} function in CancerInSilico package.
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
}

}
\references{
Sherman T D, Kagohara L T, Cao R, et al. CancerInSilico: An R/Bioconductor package for combining mathematical and statistical modeling to simulate time course bulk and single cell gene expression data in cancer. PLoS computational biology, 2019, 14(4): e1006935. \url{https://doi.org/10.1371/journal.pcbi.1006935}

Bioconductor URL: \url{https://bioconductor.org/packages/release/bioc/html/CancerInSilico.html}

Github URL: \url{https://github.com/FertigLab/CancerInSilico}
}

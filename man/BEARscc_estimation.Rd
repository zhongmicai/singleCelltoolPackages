% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/18-BEARscc.R
\name{BEARscc_estimation}
\alias{BEARscc_estimation}
\title{Estimate Parameters From Real Datasets by BEARscc}
\usage{
BEARscc_estimation(ref_data, verbose = FALSE, other_prior = NULL, seed)
}
\arguments{
\item{ref_data}{A count matrix. Each row represents a gene and each column
represents a cell.}

\item{verbose}{Logical.}

\item{other_prior}{A list with names of certain parameters. Some methods need
extra parameters to execute the estimation step, so you must input them. When
you use BEARscc, you must input the \code{dilution.factor} and the \code{volume}
information to calculate the number of molecules of spike-ins.}

\item{seed}{An integer of a random seed.}
}
\value{
A list contains the estimated parameters and the results of execution
detection.
}
\description{
This function is used to estimate useful parameters from a real dataset by
using \code{estimate_noiseparameters} function in BEARscc package.
}
\details{
In BEARscc, there are some important things that users should know before using
it.
\enumerate{
\item Make sure that there are spike-in genes in your count matrix. If not, an
error may occur.
\item BEARscc needs ensembl gene id to execute estimation step, so it is better
to transform the gene id previously. But users can also input official gene id
and the procedure will convert them into ensembl gene id and note that this
step may result in losing some genes when matching gene ids.
\item If users need the transformation of gene ids, users must input the species
name: mouse or human. And we will match the according database to accomplish
the conversion step.
\item Another important parameters: dilution.factor, volume
}
\itemize{
\item dilution.factor: The dilution factor to dilute the ERCC spike-in mix liquid.
\item volume: The volume (microliter) of spike-in mix used in sequencing step.
}

For more customed parameters in BEARscc, please check \code{\link[BEARscc:estimate_noiseparameters]{BEARscc::estimate_noiseparameters()}}.
}
\examples{
\dontrun{
ref_data <- simmethods::data

other_prior = list(dilution.factor = 50000,
                   volume = 0.1,
                   species = "mouse")

estimate_result <- simmethods::BEARscc_estimation(
  ref_data = ref_data,
  other_prior = other_prior,
  verbose = TRUE,
  seed = 111
)
}

}
\references{
Severson D T, Owen R P, White M J, et al. BEARscc determines robustness of single-cell clusters using simulated technical replicates. Nature communications, 2018, 9(1): 1-7. \url{https://doi.org/10.1038/s41467-018-03608-y}

Bioconductor URL: \url{https://www.bioconductor.org/packages/release/bioc/html/BEARscc.html}

Github URL: \url{https://github.com/seversond12/BEARscc}
}

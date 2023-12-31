% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/08-powsimR.R
\name{powsimR_estimation}
\alias{powsimR_estimation}
\title{Estimate Parameters From Real Datasets by powsimR}
\usage{
powsimR_estimation(ref_data, verbose = FALSE, other_prior = NULL, seed)
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
using \code{estimateParam} or \code{estimateSpike} function in powsimR package.
}
\details{
powsimR provides some choices for users to select suitable parameters according
to different types of data, platforms, normalization methods, distributions and
so on.
\enumerate{
\item RNAseq. "bulk" or "singlecell" (default).
\item Protocol. Options are "UMI" (default) (e.g. 10X Genomics, CEL-seq2) or "Read" (e.g. Smart-seq2).
\item Distribution. "NB" (default) for negative binomial or "ZINB" for zero-inflated negative binomial distribution fitting.
\item Normalisation. "TMM" (default), "MR", "PosCounts", "UQ", "scran", "Linnorm", "SCnorm", "Census", "depth", "none".
}

powsimR also provides an another choice to estimate parameters (not neccessary)
via spike-ins. If users want to use this, make sure that the reference data
must contain ERCC spike-in counts. In addtion, users must set dilution.factor and
volume information by \code{other_prior = list(dilution.factor = xxx, volume = xxx)}.
For more instructions, see \code{Examples}.
}
\examples{
\dontrun{
ref_data <- simmethods::data

## Estimate parameters without ERCC spike-in
estimate_result <- powsimR_estimation(
  ref_data = ref_data,
  other_prior = list(RNAseq = "singlecell",
                     Protocol = "UMI",
                     Normalisation = "scran"),
  verbose = TRUE,
  seed = 111)

## Estimate parameters with ERCC spike-in
### Make sure there are ERCC names in reference data
rownames(ref_data)[grep(rownames(ref_data), pattern = "^ERCC")]
### Users must input the dilution.factor and volume (microliter) to determine the ERCC molecules
estimate_result <- powsimR_estimation(
  ref_data = ref_data,
  other_prior = list(RNAseq = "singlecell",
                     Protocol = "UMI",
                     Normalisation = "scran",
                     dilution.factor = 50000,
                     volume = 1),
  verbose = TRUE,
  seed = 111)
}

}
\references{
Vieth B, Ziegenhain C, Parekh S, et al. powsimR: power analysis for bulk and single cell RNA-seq experiments. Bioinformatics, 2017, 33(21): 3486-3488. \url{https://doi.org/10.1093/bioinformatics/btx435}

Github URL: \url{https://github.com/bvieth/powsimR}
}

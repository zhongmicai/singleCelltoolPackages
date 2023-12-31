% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/28-SRTsim.R
\name{SRTsim_estimation}
\alias{SRTsim_estimation}
\title{Estimate Parameters From Real Datasets by SRTsim}
\usage{
SRTsim_estimation(ref_data, verbose = FALSE, other_prior = NULL, seed)
}
\arguments{
\item{ref_data}{A count matrix. Each row represents a gene and each column
represents a cell/spot.}

\item{verbose}{Logical.}

\item{other_prior}{A list with names of certain parameters. Some methods need
extra parameters to execute the estimation step, so you should input them.
See \code{Details} below for more information.}

\item{seed}{An integer of a random seed.}
}
\value{
A list contains the estimated parameters and the results of execution
detection.
}
\description{
This function is used to estimate useful parameters from a real dataset by
using \code{srtsim_fit} function in SRTsim package.
}
\details{
In SRTsim, users should input the spatial coordinates of spots or cells in the
spatial transcriptome data.
\enumerate{
\item spatial.x. The x-axis coordinates.
\item spatial.y. The y-axis coordinates.
\item group.condition. Users can also input a numeric vector to specify the tissues or domains that each cell/spot comes from,
like \verb{other_prior = list(group.condition = the numeric vector)}.
\item sim_scheme. If the labels of cells/spots represents the tissue layers or slices, \code{sim_scheme} should be set as \code{tissue}.
\code{sim_scheme} is set as \code{domain} by default.
}
}
\references{
Zhu J, Shang L, Zhou X. SRTsim: spatial pattern preserving simulations for spatially resolved transcriptomics. Genome Biology, 2023, 24(1): 39. \url{https://doi.org/10.1186/s13059-023-02879-z}

URL: \url{https://cran.r-project.org/web/packages/SRTsim/index.html}
}

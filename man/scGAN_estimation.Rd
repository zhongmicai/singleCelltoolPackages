% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/38-scGAN.R
\name{scGAN_estimation}
\alias{scGAN_estimation}
\title{Estimate Parameters From Real Datasets by scGAN}
\usage{
scGAN_estimation(ref_data, other_prior = NULL, verbose = FALSE, seed)
}
\arguments{
\item{ref_data}{A count matrix. Each row represents a gene and each column
represents a cell.}

\item{other_prior}{A list with names of certain parameters. Some methods need
extra parameters to execute the estimation step, so you must input them. In
simulation step, the number of cells, genes, groups, batches, the percent of
DEGs and other variables are usually customed, so before simulating a dataset
you must point it out.}

\item{verbose}{Logical.}

\item{seed}{An integer of a random seed.}
}
\value{
A list contains the estimated parameters and the results of execution
detection.
}
\description{
This function is used to estimate useful parameters in a Docker container.
}
\details{
scGAN is a novel method to simulate single-cell RNA-seq datasets using generative adversarial neural networks and users can only execute it via docker images. \code{scGAN_estimation} and \code{scGAN_simulation} functions have already implemented the codes that users can use scGAN in R environment.
There are some notes that users should know:
\enumerate{
\item Please install docker on you device or remote service.
\item The estimation step may take a long time as scGAN trains data reference data via neural networks.
\item The result of estimation will be returned as a file path which is the mounting point to connect the path in docker containers. Users can go to the mounting point to see the training result.
}

There are some parameters that users may often set:
\enumerate{
\item \code{group.condition}. Users can input cell group information of numeric vectors. If not, clustering will be performed before the estimation step.
\item \code{max_steps}. The max training step to train the reference data. Default is 1000000.
\item \code{GPU}. How many GPU cores to use when training the data. This can be set as \code{all}. Default is 1.
\item \code{min_cells}. Include features detected in at least this many cells when preprocessing.
\item \code{min_genes}. Include cells where at least this many features are detected when preprocessing.
\item \code{res}. The clustering resolution. Default is 0.15.
}
}
\references{
Marouf M, Machart P, Bansal V, et al. Realistic in silico generation and augmentation of single-cell RNA-seq data using generative adversarial networks. Nature communications, 2020, 11(1): 1-12.
}

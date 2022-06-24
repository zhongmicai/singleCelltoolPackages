#' External ERCC information of 92 molecules.
#'
#' A dataset containing the information of 92 molecules ERCC.
#'
#' @format A data frame with 92 rows and 6 variables:
#' \describe{
#'   \item{\code{ERCC_id}}{The name of the ERCC molecules}
#'   \item{\code{subgroup}}{Which group does the molecule belongs to}
#'   \item{\code{con_Mix1_attomoles_ul}}{The concentration of the molecules in Mix1 liquid}
#'   \item{\code{con_Mix2_attomoles_ul}}{The concentration of the molecules in Mix2 liqui}
#'   \item{\code{expected_fc}}{The expected fold change between Mix1 and Mix2}
#'   \item{\code{log2_fc}}{Log2 transformation of the \code{expected_fc}}
#' }
#' @source \url{https://assets.thermofisher.com/TFS-Assets/LSG/manuals/cms_095046.txt}
"ERCC_info"
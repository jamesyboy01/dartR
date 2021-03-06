% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gl.pcoa.pop.r
\name{gl.pcoa.pop}
\alias{gl.pcoa.pop}
\title{PCoA ordination of populations}
\usage{
gl.pcoa.pop(gl, c = "none", method = "euclidean")
}
\arguments{
\item{gl}{-- name of the genlight object containing the SNP genotypes by specimen and population [required]}

\item{c}{-- Correction methods for negative eigenvalues: \"lingoes\" and \"cailliez\" Refer to \{ape\} documentation. 
[default \"none\"]}

\item{method}{-- the distance measure to be used. This must be one of "euclidean", 
"maximum", "manhattan", "canberra", "binary" or "minkowski". Any unambiguous substring can be given.}
}
\value{
An object of class pcoa containing the eigenvalues, factor scores and factor loadings
}
\description{
This script takes the data on allele frequencies for populations and undertakes a Gower 
PCoA ordination using a nominated distance measure. It draws population information and
calculates gene frequencies by drawing upon
data in the original genlight \{adegenet\} object (entity x attribute matrix).
The script is essentially a wrapper for pcoa() \{ape\}.
}
\examples{
pcoa <- gl.pcoa.pop(testset.gl)
pcoa <- gl.pcoa.pop(testset.gl, c="cailliez", m="minkowski")
}
\author{
Arthur Georges (gl.bugs@aerg.canberra.edu.au)
}

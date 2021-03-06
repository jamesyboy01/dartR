#' Filter loci in a genlight \{adegenet\} object based on average reproducibility of alleles at a locus
#'
#' SNP datasets generated by DArT have in index, RepAvg, generated by reproducing the data independently for 30\% of loci.
#' RepAvg is the proportion of alleles that give a reproducible result, averaged over both alleles for each locus.
#'
#' @param x -- name of the genlight object containing the SNP data [required]
#' @param t -- threshold value below which loci will be removed [default 0.95]
#' @param v -- verbosity: 0, silent or fatal errors; 1, begin and end; 2, progress log ; 3, progress and results summary; 5, full report [default 2]
#' @return     Returns a genlight object retaining loci with a RepAvg greater than the specified threshold deleted.
#' @export
#' @author Arthur Georges (glbugs@aerg.canberra.edu.au)
#' @examples
#' gl.report.repavg(testset.gl)
#' result <- gl.filter.repavg(testset.gl, t=0.95, v=3)

# Last edit:25-Apr-18

gl.filter.repavg <- function(x, t=1, v=2) {

  if(class(x) == "genlight") {
    if (v > 2) {cat("Reporting for a genlight object\n")}
  } else if (class(x) == "genind") {
    if (v > 2) {cat("Reporting for a genind object\n")}
  } else {
    cat("Fatal Error: Specify either a genlight or a genind object\n")
    stop()
  }
  
  if ( v > 0) {cat("Starting gl.filter.repavg: Filtering on reproducibility\n")}
  if (v > 2) {cat("Note: RepAvg is a DArT statistic reporting reproducibility averaged across alleles for each locus. \n\n")}
  
  n0 <- nLoc(x)
  if (v > 2) {cat("Initial no. of loci =", n0, "\n")}

  if(class(x)=="genlight") {
    # Remove SNP loci with RepAvg < t
    if (v > 1){cat("  Removing loci with RepAvg <",t,"\n")}
    x2 <- x[, x@other$loc.metrics["RepAvg"]>=t]
    # Remove the corresponding records from the loci metadata
    x2@other$loc.metrics <- x@other$loc.metrics[x@other$loc.metrics["RepAvg"]>=t,]
    if (v > 2) {cat ("No. of loci deleted =", (n0-nLoc(x2)),"\n")}
    
  } else if (class(x)=="genind") {
    x2 <- x[,(colSums(is.na(tab((x))))/nInd(x))<(1-t)]
    idx <- which((colSums(is.na(tab((x))))/nInd(x))<(1-t))
    x2@other$loc.metrics <- x@other$loc.metrics[c(idx),]
    
    # Remove SNP loci with RepAvg < t
    if (v > 1){cat("  Removing loci with Reproducibility <",t,"\n")}
    x2 <- x[, x@other$loc.metrics["Reproducibility"]>=t]
    # Remove the corresponding records from the loci metadata
    x2@other$loc.metrics <- x@other$loc.metrics[x@other$loc.metrics["Reproducibility"]>=t,]
    if (v > 2) {cat ("No. of loci deleted =", (n0-nLoc(x2)),"\n")}
  } else {
    cat("Fatal Error: genlight or genind objects required for call rate filtering!\n"); stop()
  }
  
  # REPORT A SUMMARY
  if (v > 2) {
    cat("Summary of filtered dataset\n")
    cat(paste("  Reproducibility >=",t,"\n"))
    cat(paste("  No. of loci:",nLoc(x2),"\n"))
    cat(paste("  No. of individuals:", nInd(x2),"\n"))
    cat(paste("  No. of populations: ", length(levels(factor(pop(x2)))),"\n"))
  }  
  
  if ( v > 0) {cat("gl.filter.repavg completed\n")}
  
  return(x2)
  
}

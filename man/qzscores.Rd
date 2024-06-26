\name{qzscores}
\alias{qzscores}
\title{Q methodology: z-scores from loadings}
\description{Calculates factor characteristics, z-scores, and factor scores, provided a matrix of loadings and a matrix of (manually or automatically) flagged Q-sorts.}
\usage{qzscores(dataset, nfactors, loa, flagged, forced = TRUE,
         distribution = NULL)}

\arguments{
  \item{dataset}{a matrix or a data frame containing raw data, with statements as rows, Q-sorts as columns, and the column scores in the distribution in each cell.}
  \item{nfactors}{number of factors to extract.}
  \item{loa}{matrix or data frame of \code{nqsorts} rows and \code{nfactors} columns, with values of factor loadings for Q-sorts, calculated using, e.g., \code{principal(...)$loadings} or \code{\link{centroid}}.}
  \item{flagged}{matrix or data frame of \code{nqsorts} rows and \code{nfactors} columns, with \code{TRUE} values for the Q-sorts that are flagged. Automatic flagging can be aplied using \code{\link{qflag}}. Manual flagging can be done by providing a logical matrix with \code{nqsorts} rows and \code{nfactors} columns to the argument \code{flagged}.}
  \item{forced}{logical; Is the distribution of items forced? Set to \code{TRUE} if all respondents ranked the items following strictly the distribution scores, and the values of the distribution are calculated automatically. Set to \code{FALSE} if respondents were able to rank the items without following the distribution, and the values of the distribution have to be provided as an array in the argument \code{distribution}.}
  \item{distribution}{logical; when \code{forced = FALSE}, the distribution has to be provided as a vector of numbers, such as \code{c(-2, -1, -1, 0, 1, 1, 2, 2)}.}
  \item{impute_miss}{logical; Handle missing sort items using mean imputation? Set to \code{TRUE} if partially missing sorts should be imputed. Set to \code{FALSE} (default) if no imputation should be performed or there are no missing sort items.}
}

\details{In order to implement manual flagging, use a manually created data frame (or matrix) for \code{flagged}. See an example of code to perform manual flagging or to manipulate the loadings in \href{http://aiorazabala.github.io/qmethod/Advanced-analysis}{the website}.

The loadings from \code{principal(...)$loadings} or \code{centroid} can be explored to decide upon flagging. The \code{loa} data frame should have Q-sorts as rows, and factors as columns, where \code{TRUE} are the flagged Q-sorts.}
\value{
Returns a list of class \code{QmethodRes}, with seven objects:
\item{brief}{a list with the basic values of the analysis: date (\code{"date"}), number of statements (\code{"nstat"}), number of Q-sorts (\code{"nqsort"}), whether the distribution was 'forced' (\code{"distro"}),  number of factors extracted (\code{"nfactors"}), type of extraction (\code{"extraction"}), type of rotation (\code{"rotation"}), method for correlation (\code{"cor.method"}), and a summary of this information for display purposes (\code{"info"}).}
\item{dataset}{original data.}
\item{loa}{factor loadings for Q-sorts.}
\item{flagged}{logical dataframe of flagged Q-sorts.}
\item{zsc}{statements z-scores.}
\item{zsc_n}{statements rounded scores, rounded to the values in the first row of the original dataset.}
\item{f_char}{factor characteristics obtained from \code{\link{qfcharact}}.}
}
\references{Brown, S. R., 1980 \emph{Political subjectivity: Applications of Q methodology in political science}, New Haven, CT: Yale University Press.

See further references on the methodology in \code{\link{qmethod-package}}.}

\note{This is a function used within \code{\link{qmethod}}. Rarely to be used independently.}

\author{Aiora Zabala}

\examples{
data(lipset)
library(psych)
loa <- unclass(principal(lipset[[1]],
               nfactors = 3, rotate = "varimax")$loadings)
flagged <- qflag(nstat = 33, loa = loa)
qmzsc <- qzscores(lipset[[1]], nfactors = 3, flagged = flagged, loa = loa)
qmzsc # Show results
}

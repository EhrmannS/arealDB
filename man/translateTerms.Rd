% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/translateTerms.R
\name{translateTerms}
\alias{translateTerms}
\title{Translate terms}
\usage{
translateTerms(
  terms,
  index = NULL,
  source = NULL,
  strict = FALSE,
  fuzzy_terms = NULL,
  fuzzy_dist = 5,
  limit = NULL,
  inline = TRUE,
  verbose = TRUE
)
}
\arguments{
\item{terms}{[\code{character(.)}]\cr terms to be translated.}

\item{index}{[\code{character(1)}]\cr name of a table that contains
translations.}

\item{source}{[\code{named list(1)}]\cr the table or geometry ID from which
the terms have been taken. List must be named with either \code{tabID} or
\code{geoID} to denote where the ID comes from.}

\item{strict}{[\code{logical(1)}]\cr shall the translation be limited to
\code{fuzzy_terms}, or shall also those terms be available that have been
defined as \code{'original'} in a translation table.}

\item{fuzzy_terms}{[\code{vector(.)}]\cr additional target terms with which a
fuzzy match should be carried out.}

\item{fuzzy_dist}{[\code{integerish(1)}]\cr the maximum edit-distance for
which terms of fuzzy-matching should be suggested as match.}

\item{limit}{[\code{character(.)}]\cr a set of terms to which the translation
should be limited.}

\item{inline}{[\code{logical(1)}]\cr whether or not to edit translations
inline in R (only possible in linux), or in the 'translating.csv' in your
database root directory.}

\item{verbose}{[\code{logical(1)}]\cr be verbose about what is happening
(default \code{TRUE}).}
}
\value{
A table of translated \code{terms}.
}
\description{
Translate terms based on fuzzy matching.
}
\details{
This is basically a sophisticated matching algorithm, that adds new
  entries to the respective index.
}

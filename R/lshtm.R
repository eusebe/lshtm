##' Templates for RMarkdown-based Beamer PDF presentations supporting
##' the \sQuote{LSHTM} style by David Hajage, entirely based on
##' the \sQuote{Monash} style by Rob J Hyndman.
##'
##' The package is based on the 'binb' package by Dirk Eddelbuettel, Ista Zahn and Rob Hyndman.
##'
##' @title LSHTM Beamer Presentation Themes for rmarkdown document
##'
##' @param toc A logical variable defaulting to \code{FALSE}.
##' @param slide_level A numeric variable defaulting to two.
##' @param incremental A logical variable defaulting to \code{FALSE}.
##' @param fig_width A numeric variable defaulting to ten.
##' @param fig_height A numeric variable defaulting to seven.
##' @param fig_crop A logical variable defaulting to \code{TRUE}.
##' @param fig_caption A logical variable defaulting to \code{TRUE}.
##' @param dev A character variable defaulting to \dQuote{pdf}.
##' @param df_print A character variable defaulting to \dQuote{default}.
##' @param fonttheme A character variable defaulting to \dQuote{default}.
##' @param colortheme A character variable defaulting to \dQuote{lshtmgreen}.
##' Other possible values: \dQuote{lshtmlightgreen} and \dQuote{lshtmreverse}
##' @param highlight A character variable defaulting to \dQuote{tango}.
##' @param keep_tex A logical variable defaulting to \code{FALSE}.
##' @param latex_engine A character variable defaulting to \dQuote{xelatex}.
##' @param citation_package An optional character variable with possible value
##' \dQuote{default}, \dQuote{natbib} (the default), or \dQuote{biblatex}.
##' @param includes An optional character variable defaulting to \code{NULL}.
##' @param md_extensions An optional character variable defaulting to \code{NULL}.
##' @param pandoc_args An optional character variable defaulting to \code{NULL}.
##'
##' @seealso The \code{\link[binb]{binb}} package.
##'
##' @return RMarkdown content processed is returned for use by the
##' \code{\link[rmarkdown]{render}} function but the function is invoked
##' for it side effect of creating the pdf file.
##'
##' @author David Hajage
##'
##' @examples
##' \dontrun{
##' library(rmarkdown)
##' draft("myslides.Rmd", template="lshtm", package="lshtm", edit=FALSE)
##' setwd("myslides")       ## template creates a new subdir
##' render("myslides.Rmd")
##' }
lshtm <- function(toc = FALSE,
                   slide_level = 2,
                   incremental = FALSE,
                   fig_width = 8,
                   fig_height = 5,
                   fig_crop = TRUE,
                   fig_caption = TRUE,
                   dev = 'pdf',
                   df_print = "default",
                   fonttheme = "default",
                   colortheme = "lshtmgreen",
                   highlight = "tango",
                   keep_tex = FALSE,
                   latex_engine = "xelatex",
                   citation_package = c("default", "natbib", "biblatex"),
                   includes = NULL,
                   md_extensions = NULL,
                   pandoc_args = NULL) {

    fcolortheme <- paste0("beamercolortheme",colortheme,".sty")
    flogo <- paste0("logo", colortheme, ".png")
    ftitlepage <- paste0("titlepage", colortheme, ".png")
    ftitlepage169 <- paste0("titlepage169", colortheme, ".png")

    for (f in c("beamerfontthemelshtm.sty", fcolortheme,
                "beamerthemelshtm.sty", ftitlepage, ftitlepage169, flogo, "figs/"))
        if (!file.exists(f))
            file.copy(system.file("rmarkdown", "templates", "lshtm", "skeleton",
                                  f, package="lshtm"),
                      ".", recursive=TRUE)
    file.rename(flogo, "logo.png")
    file.rename(ftitlepage, "titlepage.png")
    file.rename(ftitlepage169, "titlepage169.png")

    template <- system.file("rmarkdown", "templates", "lshtm",
                            "resources", "template.tex",
                            package="lshtm")

    rmarkdown::beamer_presentation(template = template,
                                   toc = toc,
                                   slide_level = slide_level,
                                   incremental = incremental,
                                   fig_width = fig_width,
                                   fig_height = fig_height,
                                   fig_crop = fig_crop,
                                   fig_caption = fig_caption,
                                   dev = dev,
                                   df_print = df_print,
                                   theme = "lshtm",
                                   colortheme = colortheme,
                                   fonttheme = fonttheme,
                                   highlight = highlight,
                                   keep_tex = keep_tex,
                                   latex_engine = latex_engine,
                                   citation_package = citation_package,
                                   includes = includes,
                                   md_extensions = md_extensions,
                                   pandoc_args = pandoc_args)

}


# Call rmarkdown::pdf_document and mark the return value as inheriting pdf_document
inherit_pdf_document <- function(...) {
    fmt <- rmarkdown::pdf_document(...)
    fmt$inherits <- "pdf_document"
    fmt
}

knitr_fun <- function(name) utils::getFromNamespace(name, 'knitr')

output_asis <- knitr_fun('output_asis')

.First <- function() {
    options(
        stringsAsFactors=FALSE,
        scipen = 10,
        prompt = "R> ",
        width = 100,
        digits = 5,
        show.signif.stars = FALSE,
        repos = c(CRAN = "http://cran.rstudio.com/"),
        browserNLdisabled = TRUE,
        deparse.max.lines = 4,
        devtools.name = "Dave Braze",
        devtools.desc.author = "Dave Braze <davebraze@gmail.com> [aut, cre]",
        devtools.desc.license = "MIT + file")
    .libPaths(.Library)  # maybe better to set value of env. var. R_LIBS_USER
    set.seed(1234)
    q <- function(save='no', ...) {
        quit(save=save, ...)
    }
    cat("\n'~/.Rprofile' successfully loaded. \n")
    cat("\n   Welcome to R, Dave.\n\n")
}

if (interactive()) {
    suppressMessages(require(devtools))
}

.Last <- function()  cat("\n   Goodbye!\n\n")


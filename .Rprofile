.First <- function() {
    options(
        stringsAsFactors=FALSE,
        scipen = 10,
        prompt = "R> ",
        width = 100,
        digits = 5,
        max.print = 100,
        show.signif.stars = FALSE,
        repos = c(CRAN = "http://cran.rstudio.com/"),
        browserNLdisabled = TRUE,
        deparse.max.lines = 4,
        devtools.name = "Dave Braze",
        devtools.desc.author = "Dave Braze <davebraze@gmail.com> [aut, cre]",
        devtools.desc.license = "MIT + file")
    .libPaths(.Library)  # maybe better to set value of env. var. R_LIBS_USER
    set.seed(1234)

    utils::timestamp() # add timestamp to history file

    ## load these packages by default
    if (interactive()) { # load devtools by default
        suppressMessages(require(devtools))
    }

    cat("\n'~/.Rprofile' successfully loaded. \n")
    cat("\n   Welcome to R, Dave.\n\n")
}


## Define some convenience functions
q <- function(save='no', ...) { # Do not save workspace by default
    quit(save=save, ...)
}

openwd <- function() { # open current working dir in windows explorer
    suppressWarnings(shell(paste("explorer",  gsub('/', '\\\\', getwd()))))
}

## Say Goodbye.
.Last <- function()  cat("\n   Goodbye!\n\n")


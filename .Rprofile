.First <- function() {
    options(
        warn=1,
        stringsAsFactors=FALSE,
        scipen = 10,
        prompt = "R> ",
        width = 100,
        digits = 5,
        max.print = 500,
        show.signif.stars = FALSE,
        browserNLdisabled = TRUE,
        deparse.max.lines = 4,
        devtools.name = "Dave Braze",
        devtools.desc.author = "Dave Braze <davebraze@gmail.com> [aut, cre]",
        devtools.desc.license = "MIT + file")
    .libPaths(c(.Library, "c:/users/Dave Braze/R/win-library/3.5"))  # maybe better to set value of env. var. R_LIBS_USER
###    .libPaths(c(.Library, Sys.getenv("R_LIBS_USER")))  # This doesn't work
    set.seed(1234)

    utils::timestamp() # add timestamp to history file

    ## load these packages by default
    if (interactive()) { # load devtools by default
        suppressMessages(require(devtools))
    }

    cat("\n'~/.Rprofile' successfully loaded. \n")
    cat("\n   Welcome to R, Dave.\n\n")
}


## convenience functions
q <- function(save='no', ...) { # Do not save workspace by default
    quit(save=save, ...)
}

openwd <- function() { # open current working dir in windows explorer
    suppressWarnings(shell(paste("explorer",  gsub('/', '\\\\', getwd()))))
}

## Say Goodbye.
.Last <- function()  cat("\n   Goodbye!\n\n")


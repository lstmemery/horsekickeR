library(plumber)

r <- plumb(paste0(rprojroot::find_root("DESCRIPTION"), "/exec/api.R"))
r$run(port = 8000, host = "0.0.0.0")

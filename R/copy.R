# Code to copy the common R code to each tutorial prior to distribution
flds <- list.dirs('inst/tutorials/',recursive=FALSE)
for (fld in flds){
  suppressWarnings(dir.create(paste0(fld,'/www')))
  # Copy all the files except this one
  for (f in setdiff(list.files('R/'),'copy.R'))  file.copy(from=paste0('R/',f),to=paste0(fld,'/www/',f))
}


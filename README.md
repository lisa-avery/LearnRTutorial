
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ExampleTutorial

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/ExampleTutorial)](https://CRAN.R-project.org/package=ExampleTutorial)
<!-- badges: end -->

An example package for tutorials delivered through R

## Folder Structure

Tutorials are stored in the inst/tutorials directory. The emptyTutorial
directory can be copied and ammended to create a new tutorial.

## Installation

Students can install the current version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lisa-avery/ExampleTutorial")
```

## Example

List all the tutorials in the package

``` r
#intall.packages('learnr')
learnr::available_tutorials(package = 'LearnRTutorial')
#> Available tutorials:
#> * LearnRTutorial
#>   - emptyTutorial       : "A New Tutorial"
#>   - LecturingWithLearnR : "Using the learnr Package"
```

This is how the tutorials are run from within RStudio

``` r
library(LearnRTutorial)
learnr::run_tutorial("LecturingWithLearnR", "LearnRTutorial")
```

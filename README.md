<!-- badges: start -->
[![CI](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/RO.ggplot2/badges/ci.json)](https://github.com/rivm-syso/ROvis.ggplot2/actions/workflows/ci.yaml)
[![Lint](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/ROvis.ggplot2/badges/lint.json)](https://github.com/rivm-syso/ROvis.ggplot2/actions/workflows/ci.yaml)
[![Coverage](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/ROvis.ggplot2/badges/coverage.json)](https://github.com/rivm-syso/ROvis.ggplot2/actions/workflows/ci.yaml)
<!-- badges: end -->


# ROvis.ggplot2 <a href="https://github.com/rivm-syso/ROvis.ggplot2"><img src="man/figures/logo.png" align="right" height="138" /></a>

## Rijksoverheid Visualisatie - ggplot2

## Description
A tool to uniformly visualise graphs in 'ggplot2' using standardized Rijksoverheid (Dutch National Government) styling. This package is part of the ROvis umbrella package.

## Installation

```r
# Install from GitHub (private repo - requires GitHub auth, e.g. a PAT
# via usethis::create_github_token() / gitcreds, since this repo is private)
# install.packages("remotes")
remotes::install_github("rivm-syso/ROvis.ggplot2")
```


## Usage
A short example of on how to use the ro_gg_theme() function in combination with your ggplot-object.

```r
library(ggplot2)
library(ROvis.ggplot2)
data |>
  filter(sex == "Women") |>
  ggplot(aes(x = agegroup, y = n)) +
  ro_gg_theme()
```

## Support
First point of contact for questions: ROvis team (spin@rivm.nl)

## Contributing
*State if you are open to contributions and what your requirements are for accepting them.*

## Instructions for developers 

For information about R package development, check the [R Packages book](https://r-pkgs.org/). 
Below we describe the most important guidelines and practicalities.


### Requirements
We use the `testthat`, `lintr` and `roxygen2` package for development of tests, code style 
checks and automatic documentation. We also use the `devtools` and `usethis` package during 
development to adhere to standards for R packages and make developing easier! Install them 
in your Rstudio environment:

```r
install.packages(testthat)
install.packages(lintr)
install.packages(roxygen2)
install.packages(quarto)
install.packages(pkgdown)
install.packages(devtools)
install.packages(usethis)
```

### Guidelines
Type `devtools::load_all()` in your console each time you start developing. This loads 
all dependencies and non-exported functions in the NAMESPACE. This makes developing a lot easier!

To ensure code standardization and quality, follow these guidelines:
- Add tests with `usethis::use_test()`
- Add a new package dependency to the DESCRIPTION file with `usethis::use_package()`. We use 
the `min_version` argument to specify a minimum version. 
- Add a new function dependency to the NAMESPACE with `usethis::use_import_from()`
- Add documentation to new functions by inserting a roxygen skeleton and use `devtools::document()` to
create automatic documentation in the `man` folder

## Authors and acknowledgment
This R packages was created by ROvis team (spin@rivm.nl).

## License
This package uses an Apache license.

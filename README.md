
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mypackage.hw3

<!-- badges: start -->

[![R-CMD-check](https://github.com/SihleKh86/package.hw3.biostat625/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/SihleKh86/package.hw3.biostat625/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/SihleKh86/package.hw3.biostat625/branch/main/graph/badge.svg)](https://app.codecov.io/gh/SihleKh86/package.hw3.biostat625?branch=main)
<!-- badges: end -->

The goal of mypackage.hw3 is to fit a regression model and estimate
regression coefficient estimates (Betas) similar to the lm R function in
R. It then compares the accuracy between the two and benchmarks.

## Installation

You can install the development version of mypackage.hw3 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("SihleKh86/package.hw3.biostat625")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(mypackage.hw3)
## basic example code
head(swiss)
#>              Fertility Agriculture Examination Education Catholic
#> Courtelary        80.2        17.0          15        12     9.96
#> Delemont          83.1        45.1           6         9    84.84
#> Franches-Mnt      92.5        39.7           5         5    93.40
#> Moutier           85.8        36.5          12         7    33.77
#> Neuveville        76.9        43.5          17        15     5.16
#> Porrentruy        76.1        35.3           9         7    90.57
#>              Infant.Mortality
#> Courtelary               22.2
#> Delemont                 22.2
#> Franches-Mnt             20.2
#> Moutier                  20.3
#> Neuveville               20.6
#> Porrentruy               26.6
M<-swiss
#We are Choosing Fertility (column 1) as the response variable
mod1<-Beta_coef(M,1,0)
#> Residual standard error:  7.165 on 41 degrees of freedom 
#> Multiple R-squared:  0.706735 Adjusted R-Squared:  0.670971 
#> F-statistic:  19.76106 on  5 and 41 DF, p-value:  5.593799e-10
mod1
#> [[1]]
#> NULL
#> 
#> [[2]]
#>                           Estimates          Std.Error           t value
#> (Intercept)        66.9151816789654   10.7060375853301  6.25022854119771
#> Agriculture      -0.172113970941457 0.0703039231786469 -2.44814177018405
#> Examination      -0.258008239834722  0.253878200892098 -1.01626779663678
#> Education        -0.870940062939429  0.183028601571259 -4.75849159892283
#> Catholic          0.104115330743766  0.035257852536169  2.95296858017545
#> Infant.Mortality   1.07704814069103  0.381719650858061  2.82156849475775
#>                              Pr(>|t|)    
#> (Intercept)      1.73336561301153e-07 ***
#> Agriculture        0.0186186100433133   *
#> Examination         0.315320687313066    
#> Education         2.3228265226988e-05 ***
#> Catholic          0.00513556154915653  **
#> Infant.Mortality  0.00726899472564356  **
```

Demo when using some predictors of the dataset/Matrix (i.e excl_Pred is
not equal 0)

``` r
#Choosing Fertility (column 1) as the response variable 
Beta_coef(M,1,c(3,5))
#> Residual standard error:  0 on 42 degrees of freedom 
#> Multiple R-squared:  1 Adjusted R-Squared:  1 
#> F-statistic:  1.492047e+27 on  4 and 42 DF, p-value:  0
#> [[1]]
#> NULL
#> 
#> [[2]]
#>                              Estimates            Std.Error            t value
#> (Intercept)       1.36424205265939e-12 1.73654546028625e-12  0.785606875177637
#> Fertility            0.999999999999979  1.9650588003574e-14   50889062445261.2
#> Agriculture      -2.22044604925031e-15 9.40006626411093e-15 -0.236215999639054
#> Education        -1.77635683940025e-14 2.78948269558031e-14 -0.636805111648383
#> Infant.Mortality  -2.8421709430404e-14 6.37015576118179e-14 -0.446169771916711
#>                           Pr(>|t|)    
#> (Intercept)      0.436405460383961    
#> Fertility                        0 ***
#> Agriculture      0.814386651890023    
#> Education        0.527627611240858    
#> Infant.Mortality 0.657713355890134
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

Compare with lm function

    #> 
    #> Call:
    #> lm(formula = Fertility ~ ., data = swiss)
    #> 
    #> Residuals:
    #>      Min       1Q   Median       3Q      Max 
    #> -15.2743  -5.2617   0.5032   4.1198  15.3213 
    #> 
    #> Coefficients:
    #>                  Estimate Std. Error t value Pr(>|t|)    
    #> (Intercept)      66.91518   10.70604   6.250 1.91e-07 ***
    #> Agriculture      -0.17211    0.07030  -2.448  0.01873 *  
    #> Examination      -0.25801    0.25388  -1.016  0.31546    
    #> Education        -0.87094    0.18303  -4.758 2.43e-05 ***
    #> Catholic          0.10412    0.03526   2.953  0.00519 ** 
    #> Infant.Mortality  1.07705    0.38172   2.822  0.00734 ** 
    #> ---
    #> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    #> 
    #> Residual standard error: 7.165 on 41 degrees of freedom
    #> Multiple R-squared:  0.7067, Adjusted R-squared:  0.671 
    #> F-statistic: 19.76 on 5 and 41 DF,  p-value: 5.594e-10

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.

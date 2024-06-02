

# simple demo of collider

analyse <- function(model, data){
  # fit regressions. NB model must include a Y ~ X term.
  fit <- sem(model = model, data = data) 
  
  # extract beta estimate for Y~X
  parameterEstimates(fit ) |>
    mutate(effect = paste(lhs, rhs, sep = "~")) |>
    filter(effect == "Y~X") |>
    dplyr::select(beta_estimate = est)
}

# true Y~X is zero
dat <- lavaan::simulateData(model = "M ~ 0.5*X + 0.5*Y; Y ~ 0.0*X", sample.nobs = 10000)
# but analysis shows a non-zero Y~X effect!
analyse(model = "Y ~ X + M", data = dat)


# true Y~X is positive
dat <- lavaan::simulateData(model = "M ~ 0.5*X + 0.5*Y; Y ~ 0.5*X", sample.nobs = 10000)
# but analysis shows a reduced Y~X effect!
analyse(model = "Y ~ X + M", data = dat)


# when true Y~X is positive, the results can look just like what you would also want to see under a 'partial mediation' model! 
# ie a positive direct effect reduces when you control for the mediator
dat <- lavaan::simulateData(model = "M ~ 0.5*X + 0.5*Y; Y ~ 0.5*X", sample.nobs = 10000)

# direct effect "c"
analyse(model = "Y ~ X", data = dat)
# direct effect "c'" after controlling for mediator
analyse(model = "Y ~ X + M; M ~ X", data = dat)

# bring up Baron & Kenny's article, how often its cited, and the influence it has on the literature in the last few decades
# bring up how this method seems to align with the goals of psychology wanting to know about mental processes.
# the point is that "mediation tests" do not test mediation, they assume mediation.






# simple demo of collider

analyse <- function(model, data){
  fit <- sem(model = model, data = data) 
  
  parameterEstimates(fit ) |>
    mutate(effect = paste(lhs, rhs, sep = "~")) |>
    filter(effect == "Y~X") |>
    dplyr::select(beta_estimate = est)
}

# Y ~ X is zero
dat <- lavaan::simulateData(model = "M ~ 0.5*X + 0.5*Y; Y ~ 0.0*X", sample.nobs = 10000)

analyse(model = "Y ~ X + M", data = dat)


# Y ~ X is positive
dat <- lavaan::simulateData(model = "M ~ 0.5*X + 0.5*Y; Y ~ 0.5*X", sample.nobs = 10000)

analyse(model = "Y ~ X + M", data = dat)


# when positive, it can look just like partial mediation! 
# a positive direct effect reduces when you control for the mediator
dat <- lavaan::simulateData(model = "M ~ 0.5*X + 0.5*Y; Y ~ 0.5*X", sample.nobs = 10000)

analyse(model = "Y ~ X", data = dat)

analyse(model = "Y ~ X + M; M ~ X", data = dat)

# bring up Baron & Kenny's article, how often its cited, and the influence it has on the literature in the last few decades
# bring up how this method seems to align with the goals of psychology wanting to know about mental processes.
# the point is that "mediation tests" do not test mediation, they assume mediation.





# tests
purrr::safely()
purrr::possibly()
purrr::quietly()
stopifnot()


# When writing functions, especially those that take a lot of parameters, it is often wise to include stopifnot() statements at the top to verify the function is getting what it expects. For example, look at this (fake) example of generating data with different means and variances
# eg:

make_groups <- function( means, sds ) {
  stopifnot( length(means) == length(sds) )
  Y = rnorm( length(means), mean=means, sd = sds )
  round( Y )
}
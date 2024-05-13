# code adapted from Lakens: https://github.com/Lakens/statistical_inferences/blob/master/03-likelihoods.qmd

plot_lr_for_mixed_results <- function(n_studies, n_significant, p_H0 = 0.05, p_H1 = 0.80){
  LR <-
    max(dbinom(n_significant, n_studies, p_H0) / dbinom(n_significant, n_studies,p_H1),
        dbinom(n_significant, n_studies, p_H1) / dbinom(n_significant, n_studies, p_H0)) |>
    round(digits = 2)
  
  theta <- seq(0, 1, len = 1000)
  
  like <- dbinom(n_significant, n_studies, theta)
  
  # plot
  plot(theta, like, type = "l", xlab = substitute(paste(italic('p'))), ylab = "Likelihood", lwd = 2)
  points(p_H0, dbinom(n_significant, n_studies, p_H0), lwd = 2)
  points(p_H1, dbinom(n_significant, n_studies, p_H1), lwd = 2)
  segments(p_H0, 
           dbinom(n_significant, n_studies, p_H0), 
           n_significant / n_studies, 
           dbinom(n_significant, n_studies, p_H0), 
           lty = 2, lwd = 2)
  segments(p_H1, 
           dbinom(n_significant, n_studies, p_H1), 
           n_significant / n_studies, 
           dbinom(n_significant, n_studies, p_H1), 
           lty = 2, lwd = 2)
  segments(n_significant / n_studies, 
           dbinom(n_significant, n_studies, p_H0), 
           n_significant / n_studies, 
           dbinom(n_significant, n_studies, p_H1), 
           lwd = 2)
  abline(v = 0.05, col = "gray40", lty = 3, lwd = 2)
  abline(v = 0.8, col = "gray40", lty = 3, lwd = 2)
  title(paste("Likelihood Ratio:", LR))
}

plot_lr_for_mixed_results(n_studies = 8, 
                          n_significant = 7,
                          p_H0 = 0.05, # false positive rate (alpha) - assuming no bias
                          p_H1 = 0.80) # power (1-beta) - assuming its consistent between studies

plot_lr_for_mixed_results(n_studies = 3, 
                          n_significant = 1,
                          p_H0 = 0.05, # false positive rate (alpha) - assuming no bias
                          p_H1 = 0.80) # power (1-beta) - assuming its consistent between studies

plot_lr_for_mixed_results(n_studies = 4, 
                          n_significant = 1,
                          p_H0 = 0.25, # false positive rate (alpha) - assuming no bias
                          p_H1 = 0.60) # power (1-beta) - assuming its consistent between studies
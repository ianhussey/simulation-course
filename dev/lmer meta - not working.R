# # Note that RE models are must multilevel regressions. To illustrate this, we can implement a very similar meta-analysis using {lme4}. Some small differences exist in the specifics of the models and the results that they produce that aren't important to understand here.

library(lme4)

lmer(yi ~ 1 + (1 | study),
     weights = 1/vi,
     control = lmerControl(check.nobs.vs.nlev = "ignore", check.nobs.vs.nRE = "ignore"), # turn off the checks for more than one observation per RE level
     data = es |> rownames_to_column(var = "study")) |>
  model_parameters()
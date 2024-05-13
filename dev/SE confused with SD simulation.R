# SE/SD error

```{r}


# remove all objects from environment ----
#rm(list = ls())


# dependencies ----
# repeated here for the sake of completeness 

library(tidyr)
library(dplyr)
library(tibble)
library(forcats)
library(purrr) 
library(ggplot2)
library(knitr)
library(kableExtra)
library(janitor)


# set the seed ----
# for the pseudo random number generator to make results reproducible
set.seed(123)


# define data generating function ----
generate_data <- function(n_minimum,
                          n_max,
                          mean_control,
                          mean_intervention,
                          sd_control,
                          sd_intervention) {
  require(tibble)
  require(dplyr)
  require(forcats)
  
  n_per_condition <- runif(n = 1, min = n_minimum, max = n_max)
  
  data_control <- 
    tibble(condition = "control",
           score = rnorm(n = n_per_condition, mean = mean_control, sd = sd_control))
  
  data_intervention <- 
    tibble(condition = "intervention",
           score = rnorm(n = n_per_condition, mean = mean_intervention, sd = sd_intervention))
  
  data <- bind_rows(data_control,
                    data_intervention) |>
    # control's factor levels must be ordered so that intervention is the first level and control is the second
    # this ensures that positive cohen's d values refer to intervention > control and not the other way around.
    mutate(condition = fct_relevel(condition, "intervention", "control"))
  
  return(data)
}


# define data analysis function ----
analyse_data <- function(data) {
  require(effsize)
  require(tibble)
  
  # summary stats generation function should convert data to summary stats
  
  # then an errors function that introduces some errors by swapping SD for SE with a probability of X.
  
  # then metafor::escalc to calculate ES, fit meta and return results
  
  # summary across iterations should consider both the meta ES and the study level ESs.
  
  # res_n <- data |>
  #   count()
  # 
  # res_t_test <- t.test(formula = score ~ condition, 
  #                      data = data,
  #                      var.equal = FALSE,
  #                      alternative = "two.sided")
  # 
  # res_cohens_d <- effsize::cohen.d(formula = score ~ condition,  # new addition: also fit cohen's d
  #                                  within = FALSE,
  #                                  data = data)
  # 
  # res <- tibble(total_n = res_n$n,
  #               p = res_t_test$p.value, 
  #               cohens_d = res_cohens_d$estimate,  # new addition: save cohen's d and its 95% CIs to the results tibble
  #               cohens_d_ci_lower = res_cohens_d$conf.int["lower"],
  #               cohens_d_ci_upper = res_cohens_d$conf.int["upper"]) |>
  #   mutate(cohens_d_se = (cohens_d_ci_upper - cohens_d_ci_lower)/(1.96*2))
  
  return(res)
}


# define experiment parameters ----
experiment_parameters_grid <- expand_grid(
  n_minimum = 10,
  n_maximum = 250,
  mean_control = 0,
  mean_intervention = 0.2, #c(0.0, 0.1, 0.2, 0.5, 0.8, 1.0), # only this differs meaningfully from the simulation in lesson 2: simulate data for a true effect size of 0 (null) and very small, small, medium, large, and very large Cohen's d (alternative)
  sd_control = 1,
  sd_intervention = 1,
  iteration = 1:10
)


# run simulation ----
simulation <- 
  # using the experiment parameters
  experiment_parameters_grid |>
  
  # generate data using the data generating function and the parameters relevant to data generation
  mutate(generated_data = pmap(list(n_minimum,
                                    n_maximum,
                                    mean_control,
                                    mean_intervention,
                                    sd_control,
                                    sd_intervention),
                               generate_data)) |>
  
  # apply the analysis function to the generated data using the parameters relevant to analysis
  mutate(analysis_results = pmap(list(generated_data),
                                 analyse_data))


# summarise simulation results over the iterations ----
simulation_unnested <- simulation |>
  # convert `analysis_results` nested-data-frame column to regular columns in the df. in this case, the p value.
  unnest(analysis_results) 





rma(yi     = cohens_d, 
    vi     = cohens_d_se^2, 
    data   = simulation_unnested,
    method = "REML") |>
  forest(header = TRUE)

# text(1, 
#      1:length(simulation_unnested$cohens_d), labels = simulation_unnested$total_n, pos = 2)


```
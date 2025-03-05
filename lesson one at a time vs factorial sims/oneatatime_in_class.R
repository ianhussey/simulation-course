experiment_parameters_grid <- expand_grid(
  n_per_condition = c(50, 100, 150),
  mean_control = 0,
  mean_intervention = c(.1, .2, .3),
  sd_control = 1,
  sd_intervention = c(.5, 1, 1.5),
  iteration = 1:1000
)

default <- expand_grid(
  n_per_condition = 100,
  mean_control = 0,
  mean_intervention = .2,
  sd_control = 1,
  sd_intervention = 1,
  iteration = 1:1000
)

oneatattime_n <- expand_grid(
  n_per_condition = c(50, 100, 150),
  mean_control = 0,
  mean_intervention = .2,
  sd_control = 1,
  sd_intervention = 1,
  iteration = 1:1000
)

oneatattime_mean_intervention <- expand_grid(
  n_per_condition = 100,
  mean_control = 0,
  mean_intervention = c(.1, .2, .3),
  sd_control = 1,
  sd_intervention = 1,
  iteration = 1:1000
)

oneatattime_sd_intervention <- expand_grid(
  n_per_condition = 100,
  mean_control = 0,
  mean_intervention = .2,
  sd_control = 1,
  sd_intervention = c(.5, 1, 1.5),
  iteration = 1:1000
)


grid <- bind_rows(oneatattime_n,
                  oneatattime_mean_intervention,
                  oneatattime_sd_intervention)





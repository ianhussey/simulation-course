nested data structures needed to be discussed a lot in class, some didn't really get them. Expand on this in the lesson, to show that you can build them yourself, and to show that the simulation structure allows you to scrutinise them.

the metafor of workers with boxes was helpful - each step in the process is a worker taking its object in and out of a box, and passing that box to the next worker, rather than passing the individuals items in the box.



discussion of expand_grid was also helpful to show what its really doing and why its useful.



general discussion was needed for people to get it.



explicate the three parts of a function better - arguments (input), code, return (output) - take from "old lesson 2.Rmd"



they want a future lesson on writing functions specifically

they want a future lesson on writing sims from scratch, now they have a few examples of reading ones



propogate the simpler data generation code to previous lessons:

```R
data_control <- 
		tibble(condition = "control",
           score = rnorm(n = n_control, mean = mean_control, sd = sd_control))

data_intervention <- 
		tibble(condition = "intervention",
           score = rnorm(n = n_intervention, mean = mean_intervention, sd = sd_intervention))

data <- bind_rows(data_control,
                  data_intervention)
```



lesson 3 - p value distributions: wasn't sufficiently clear that no amount of practice can help people know about given studies. you can only define long run probabilities and act as if

- lesson 3 has no homework solution add this.



lesson 4

change sequential simualtions to a single parallel one with multiple skew values.

print  t test result to show what were extracting

emphasise WAY earlier that the group_by in the summarize must match the different values manipulated in the expand grid, and that we can't put it all together unthinkingly.

explain expand grid with 50 participants with small skew, 50 with big, 100 with small, 100 with big etc. PROB DO THIS IN AN EARLIER WEEK.



lesson 5

talk about pseudocode

interpreting RCTs:

- Add example to the solution: what if there are differences at both baseline and followup
- add paper on interpretation of nonsignificant results to reading list before class
- mention equivalence tests?
- quiz for checking understanding?

# This file simulates 20 years of bycatch data similar to that used 
# in Martin et al. 2015.
#


library(tidyverse)

# The simulated data are created with a known interaction rate (0.002) and
# a known probability of mortality (0.5)

set.seed(1234)

sets <- vector(length = 20) # Annual fishing effort
inter <- vector(length = 20) # Annual observed number of bycatch interactions
mort <- vector(length = 20) # Annual number of interactions resulting in mortality

for(i in 1:20) {
  sets[i] = rnorm(1, 1000, 100)
  while(sets[i] <= 0) {
    sets[i] = rnorm(1, mean = 3000, sd = 500)
  }
  inter[i] = rpois(1, lambda = sets[i] * 0.002)
  mort[i] = rbinom(1, size = inter[i], prob = 0.5)
}

dat <- tibble(year = seq(1990, 2009, by = 1),
              sets = sets,
              inter = inter,
              mort = mort)

write_csv(dat, "pCloud Drive/Projects/Bayesian Fisheries By Catch Example/sim_dat.csv")

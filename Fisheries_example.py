# MacOS: create environment
# conda create -n stan3.6 python=3.6 pystan=2.18.0.0
# source activate stan3.6
# python Fisheries_example.py

import pystan
import pandas as pd

# Load data
dat = pd.read_csv("/Users/john/pCloud Drive/Projects/Bayesian Fisheries By Catch Example/sim_dat.csv")
dat.head()

# Create dictionary with variables for stan
ndat = dict(N = len(dat['year']),year = dat['year'], sets = dat['sets'], inter = dat['inter'], mort = dat['mort'])


# Fit using poisson_model to estimate bycatch interactions
sm = pystan.StanModel(file='poisson_model.stan')
fit = sm.sampling(data=ndat, iter=1000, chains=4)

# Print poisson estimates
print(fit)

# Plot predictions
fit.plot()

# Fit using Bionomial to estimate mortality
sm2 = pystan.StanModel(file='binomial_model.stan')
fit2 = sm2.sampling(data=ndat, iter=1000, chains=4)

# Print binomial estimates
print(fit2)

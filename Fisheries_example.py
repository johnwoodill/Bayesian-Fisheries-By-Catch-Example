# MacOS: create environment
# conda create -n stan3.6 python=3.6 pystan=2.18.0.0
# source activate stan3.6
# python Fisheries_example.py

import pystan
import pandas as pd

dat = pd.read_csv("/Users/john/pCloud Drive/Projects/Bayesian Fisheries By Catch Example/sim_dat.csv")
dat.head()

ndat = dict(N = len(dat['year']),year = dat['year'], sets = dat['sets'], inter = dat['inter'], mort = dat['mort'])
ndat

# Fit using poisson_model to estimate bycatch interactions
sm = pystan.StanModel(file='poisson_model.stan')
fit = sm.sampling(data=ndat, iter=1000, chains=4)

print(fit)

fit.plot()

# Fit using Bionomial to estimate mortality
sm2 = pystan.StanModel(file='binomial_model.stan')
fit2 = sm2.sampling(data=ndat, iter=1000, chains=4)

print(fit2)

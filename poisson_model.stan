functions { // To specify your own functions to use in the Stan program
}

data { // This is where you indicate the data to use for model estimation
  int N; // Number of years
  int inter[N]; // Number of annual bycatch interactions
  vector[N] sets; // Number of annual sets
}

transformed data { // Any transformations of the data are specified here
}

parameters { // All model parameters will be defined here.
  real<lower = 0> eta; // bycatch rate parameter
}

transformed parameters { // Any parameter transformations are specified here.
} 

model { // Define your priors and likelihood function here.
  target += poisson_lpmf(inter | sets * eta); // Likelihood function
  
  target += normal_lpdf(eta | 0, 10); // Prior for eta 
  //(Note this is half-normal because of the above constraint.)
}

generated quantities { // This is where you do your posterior preditions.
}
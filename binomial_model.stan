functions { // To specify your own functions to use in the Stan program
}

data { // This is where you indicate the data to use for model estimation
  int N; // Number of years
  int inter[N]; // Number of annual bycatch interactions
  int mort[N]; // Number of annual sets
}

transformed data { // Any transformations of the data are specified here
}

parameters { // All model parameters will be defined here.
  real<lower = 0, upper = 1> theta; // probability of mortality
}

transformed parameters { // Any parameter transformations are specified here.
} 

model { // Define your priors and likelihood function here.
  target += binomial_lpmf(mort | inter, theta); // Likelihood function
  
  target += normal_lpdf(theta | 0.5, 0.5); // Prior for eta
  // Note this is bound between 0 and 1 because of above constraints.
}

generated quantities { // This is where you do your posterior preditions.
}
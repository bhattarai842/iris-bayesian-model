data {
  // training variables
  int<lower=0> ndata; 
  int<lower=0> npar;
  int<lower = 0> gcount;
  
  row_vector[npar] X[ndata];
  real<lower = 0>  Y[ndata];
  int<lower = 0> G[ndata];
  // test variable
  int<lower = 0> ndata_test;
  row_vector[npar] X_test[ndata_test];
  int<lower = 0> G_test[ndata_test];
  
  }
  
parameters {
  real mu0;
  real<lower = 0> sigma0;
  vector[npar] beta[gcount];
  real<lower=0> sigma; 
}

model {
  mu0 ~ normal(4, 4);
  sigma0 ~ cauchy(0, 10);
  for(n in 1:gcount)
    beta[n] ~ normal(mu0, sigma0);
  //Bayesian Model
  for (n in 1:ndata)
    Y[n] ~ normal(X[n] * beta[G[n]], sigma);
}

generated quantities {
      real Y_test[ndata_test];
      for (n in 1:ndata_test)
          Y_test[n] <- normal_rng(X_test[n] * beta[G_test[n]], sigma);
  }  
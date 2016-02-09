data {
  int<lower= 0> ndata; 
  int<lower= 0> npar;
  int<lower = 0> K;
  // Variables
  real<lower = 0> plength[ndata];
  real<lower = 0> swidth[ndata];
  real<lower = 0> pwidth[ndata];
  int<lower = 0> species[ndata];
  }
  
  parameters {
    matrix beta[npar, K];
    real<lower=0> sigma; 
  }
  
transformed parameters  {
  // Mean
  real mu[ndata];
  
  for (i in 1:ndata) {
    mu[i] <- beta[1] + 
             beta[2]*swidth[i]  + 
             beta[3]*plength[i] + 
             beta[4]*pwidth[i] + 
             beta[5] * species[i]; 
    }
}

model {
  //Bayesian Model
  plength ~ normal(mu, sigma);
  }
  
// generated quantities{
//   vector[K] machine_pred;
//   for(k in 1:K){
//     machine_pred[k] <- normal_rng(mu[k], sigma[k]);
//   }
// }
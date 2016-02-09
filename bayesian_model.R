setwd('~/Documents/2nd semester/hands on bayesian data analysis/')
set.seed('100')
require(caret)
require(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

train.index <- createDataPartition(iris$Species, p = 0.8, list = F, times = 1)

train.data <- iris[train.index,]
test.data <- iris[-train.index,]

ndata = nrow(train.data)

X.train <- as.matrix(cbind(rep(1, ndata), train.data[,-c(1,5)]))
Y.train <- train.data$Sepal.Length
G.train <- as.integer(train.data$Species)

ndata_test = nrow(test.data)
X.test <- as.matrix(cbind(rep(1, ndata_test), test.data[,-c(1,5)]))
G.test <- as.integer(test.data$Species)


npar = ncol(X.train)
data.stan <- list(X = X.train, Y = Y.train, 
                        ndata = ndata,G = G.train,
                        X_test = X.test,G_test = G.test, ndata_test = ndata_test,
                        npar = npar, gcount = 3)

linear.model <- stan(file = './rstan/iris.stan', data = data.stan)

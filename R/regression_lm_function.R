#'multiple regression function
#'
#'Estimates the regression, standard errors, t-values and R-square
#'
#'@param M argument is input matrix or dataset
#'@param outcome argument is the outcome/response variable as a column of the input Matrix
#'@param excl_Pred arugment is the column or predictors you want to exclude,
#'put zero if you are using all predictors of the Matrix/Dataset
#'
#'@return the Beta estimates and other regression metric similar to the R lm function
#'
#'@example
#'Beta(matrix(c(1:6,2,3)),2,0)


Beta_coef=function(M,outcome,excl_Pred){
  n<-nrow(M)
  m<-ncol(M)

  Y<-matrix(M[,outcome], nrow = nrow(M))

  if (excl_Pred == 0){
    X<-cbind(1, as.matrix(x=M[,-outcome]))
  } else{
    X<-cbind(1, as.matrix(x=M[,-predictors]))
  }
  colnames(X)[1]<-"(Intercept)"

  p<-ncol(X)-1 # number of predictors excluding intercept

  beta_h<-solve(t(X)%*%X)%*%(t(X)%*%Y)

  #Variance and standard error of estiamted coefficients
  sigma_sq<-(n-p-1)^-1 * sum((Y - X %*% beta_h)^2)
  var_beta<-sigma_sq*solve(t(X) %*% X)
  coeff_std_erros<-sqrt(diag(var_beta))

  #Variance of residuals/model error
  residual_std_error<-sqrt(sigma_sq)

  #calculating the t values of the estimates
  t_values <- beta_h/coeff_std_erros

  #p-values of the t-stats of estimates
  p_values<-2*pt(abs(t_values),n-p,lower.tail = FALSE)

  #assigning R's significance codes to obtained p-values
  signif_codes<-function(s){
    ifelse(s<=0.001,"***",
           ifelse(s<=0.01,"**",
                  ifelse(s<0.05,"*",
                         ifelse(s<0.1,"."," "))))
  }

  signif_codes_ass<-sapply(p_values,signif_codes)

  #combining the results
  lm_results<-as.data.frame(cbind(beta_h,coeff_std_erros,t_values,p_values,signif_codes_ass))
  colnames(lm_results)<-c("Estimates", "Std.Error","t value","Pr(>|t|)","")

  # Residual and Adjusted R-squared
  R_sq<- 1 - (n-p-1)*sigma_sq/(n*mean((Y-mean(Y))^2))
  R_sq_adj<- 1 - sigma_sq/((n/(n-1))*mean((Y-mean(Y))^2))

  #Residual sum of squares (RSS) for the full model
  RSS<-(n-p-1)*sigma_sq
  #RSS for the partial model with onlt intercept (equal to mean)
  RSS_partial<-sum((Y-mean(Y))^2)

  #F statistics based on RSS for full and partial models
  #p = degress of freedom of partial model
  #n-p-1 = degrees of freedom of full model
  F_stat<-((RSS_partial - RSS)/p) / (RSS/(n-p-1))

  #p-value of the F Statistic
  p_value_F_Stat <- pf(F_stat,df1 = p, df2 = n-p-1, lower.tail = FALSE)

  #concatenate and print residual standard error, multiple R-Squared, Adj R-Squared and F Statistics
  resultc<-cat("Residual standard error: ", round(residual_std_error, digits=3),
               "on", n-p-1, "degrees of freedom",
               "\nMultiple R-squared: ", R_sq,"Adjusted R-Squared: ", R_sq_adj,
               "\nF-statistic: ", F_stat, "on ", p, "and",n-p-1,
               "DF, p-value: ", p_value_F_Stat, "\n")
  return(list(resultc, lm_results))
}

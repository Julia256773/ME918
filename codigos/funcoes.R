
#################################################################################
########################### Regressão Linear ####################################
#################################################################################

##tabela = nome do banco de dados
## y = nome da variavel resposta
## z = lista com nomes das preditoras (tamanho da lista é maior ou igual a 1)

modelo_reg_linear = function(tabela, y, z){
  
  ##criando a string da formula
  formula = paste(y, "~")
  for (i in 1:length(z)){
    formula = paste(formula, z[i], "+")
  }
  formula = str_sub(formula, end=-2) #tirando o ultimo "+"
  
  #fazendo o ajuste
  ajuste = lm(as.formula(formula), data=tabela)
  
  
  #coletando os betas
  betas = c()
  for (i in 1:(length(ajuste$coefficients))){
    betas = append(betas, ajuste$coef[i])
  }
  return(betas)
}

#exemplo de como devem ser:
### tabela = iris
### y = "Sepal.Length"
### z = c("Petal.Length", "Petal.Width")


#################################################################################
########################### Regressão Lasso ####################################
#################################################################################

library(glmnet)

modelo_reg_lasso = function(x,y){
  #fazendo o ajuste
  ajuste = glmnet(x, y, alpha = 1)
  validacao_cruzada = cv.glmnet(x, y, alpha = 1)
  #coletando os betas
  betas = coef(validacao_cruzada, s = "lambda.min")
  return(betas)
}


library(yaml)
library(glue)
library(readr)
library(tidyverse)

source("codigos/funcoes.R")
config = read_yaml("configuracao.yaml")
dados = read_csv(glue("entradas/{config$dados_teste}"))

#################################################################################
########################### Regressão Linear ####################################
#################################################################################

#para cada conjunto de variáveis
for (i in 1:length(config$variaveis)){
  
  #escrevendo a lista z - terceiro argumento da função que criamos
  preditoras = c()
  for (j in 2:length(config$variaveis[[i]])){
    preditoras = append(preditoras, config$variaveis[[i]][[j]] )
  }
  z = preditoras
  
  #outros parametros da função
  tabela = dados
  y = config$variaveis[[i]]$resposta
  
  #aplicando a função
  betas = modelo_reg_linear(tabela, y, z)
  
  #salvando os betas
  saveRDS(betas, file = glue("saidas/betas_conjunto{i}_reglinear.rds"))
  
}





#################################################################################
########################### Regressão Lasso ####################################
#################################################################################


for (i in 1:length(config$variaveis)){ # para cada "par"
  preditoras = c()
  x = 0
  y = 0
  if(length(config$variaveis[[i]]) > 2){
    for(j in 2:length(config$variaveis[[i]])){
      preditoras = append(preditoras, config$variaveis[[i]][[j]] ) # as preditoras
      y = dados %>% select(config$variaveis[[i]]$resposta) %>% unlist() %>% as.numeric()
      x = as.matrix(dados %>% select(preditoras))
    } 
    # aplicando a função
    betas = modelo_reg_lasso(x,y)
    saveRDS(betas, file = glue("saidas/betas_conjunto{i}_reglasso.rds"))}
}
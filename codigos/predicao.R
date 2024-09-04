library(jsonlite)

pred = fromJSON("entradas/preditores.json", simplifyDataFrame = FALSE)


resultados = c()

#para cada uma das linhas que coloquei no meu jason
for (i in 1:length(pred)){
  
  #definindo quais betas vamos importar
  conjunto = pred[[i]]$conjunto
  tipo = pred[[i]]$tipo
  betas = readRDS(glue("saidas/betas_conjunto{conjunto}_reg{tipo}.rds"))
  
  if (tipo == "linear") { ##########LINEAR###############
    predito = betas[[1]] #começando a soma com beta0
    for (j in 2:(length(betas))){ predito = predito + betas[[j]]*pred[[i]][[j+1]]}
  } else { ##########LASSO###############
    betas = as.matrix(betas)
    predito = betas[1] #comecando a soma com o beta0
    for (j in 2:(length(betas))){ predito = predito + betas[j]*pred[[i]][[j+1]]}
  }
  
  resultados = append(resultados, predito)
}

write(jsonlite::toJSON(resultados), file = glue("saidas/preditos.json"))



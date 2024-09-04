renv::restore(prompt = FALSE)

#Primeiro: ler treinamento.R
# esse automaticamente le configurações e funções R
# resultado: salva os valores de beta na pasta de saídas, um file para cada conjunto
source("codigos/treinamento.R")

#Segundo: ler predição.R
# esse automatocamente le preditores.json
# resultado: salva os valores preditos na pasta saida em um arquivo preditos.json
source("codigos/predicao.R")

#Terceiro: ler grafico.R
# esse automaticamente

source("codigos/grafico.R")
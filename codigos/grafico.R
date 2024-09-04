config = read_yaml("configuracao.yaml")
pred = fromJSON("entradas/preditores.json", simplifyDataFrame = FALSE)

library(ggplot2)
library(tidyverse)

for (i in 1:length(pred)){
  
  #vai fazer gráfico só com quem tiver 1 preditor. Ou seja pred[[i]] tiver só 3 argumentos
  if (length(pred[[i]])<4 && pred[[i]]$tipo=="linear"){
    conjunto = pred[[i]]$conjunto
    #gráfico:
    grafico = dados %>% 
      ggplot(aes(x = !!sym(config$variaveis[[conjunto]]$preditora1), 
                 y = !!sym(config$variaveis[[conjunto]]$resposta)))+
      geom_point()+
      geom_smooth(method = "lm", se=F)+
      geom_vline(xintercept = pred[[i]]$preditora1, linetype = "dashed", color = "red") +
      labs(title = paste("Predicao para o conjunto", pred[[i]]$conjunto),
           subtitle = paste("Preditora escolhida:",pred[[i]]$preditora1 ))+
      theme_bw()
    ggsave(filename = glue("saidas/grafico_linha{i}.pdf"), plot = grafico, device = "pdf")
    
  }
  
}
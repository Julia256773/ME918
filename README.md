
# PredictModel

Documentação e guia para o uso do Projeto PredictModel

Este documento apresenta os arquivos presentes no Projeto PredictModel
com suas respectivas definições e objetivos. Além disso, ele contém um
guia para acessar e fazer o uso do projeto.

O projeto tem como objetivo permitir que o usuário treine um modelo de
regressão linear ou regressão lasso a partir de um conjunto de dados e,
posteriormente, forneça entradas dos preditores/variáveis explanatórias
para obter um resultado final a partir do modelo treinado. Para as
regressões lineares simples, o modelo também retorna um gráfico do
resultado do ajuste do modelo.

## Arquivos

Os arquivos estão definidos como:

`pasta/arquivo:` Definição. `subpasta/sub-arquivo:` Definição.

Os arquivos presentes no projeto são:

`codigos:` Armazena os arquivos que contêm códigos.

`funcoes.R:` Arquivo destinado ao armazenamento e organização das
funções personalizadas desenvolvidas ao longo do projeto. Essas funções
servem para operar predições específicas (no caso, regressão linear e
lasso) em diferentes partes do código.

`treinamento.R:` Arquivo responsável por armazenar a estrutura completa
dos códigos relacionados ao treinamento dos modelos. Isso inclui a
preparação dos dados, a configuração dos hiperparâmetros e a execução do
processo de treinamento.

`predicao.R:` Arquivo responsável por armazenar a estrutura dos códigos
utilizados para realizar a predição com os modelos treinados. Inclui a
preparação dos dados de entrada, a execução das predições e a geração
dos resultados finais.

`grafico.R:` Arquivo destinado para gerar o gráfico da predição para o
conjunto de variáveis (apenas para regressão linear com uma preditora).

`entradas:` Pasta que armazena as entradas necessárias para a execução
do projeto.

`<nome_do_banco>.csv:` Banco de dados usado para treinar o modelo.

`preditores.json:` Arquivo que lista as variáveis preditoras para o
modelo treinado. Este arquivo especifica os valores de entrada para cada
variável preditora e define a regressão a ser aplicada em cada modelo
(linear ou lasso).

`configuração.yaml:` Define as configurações necessárias para a
realização das regressões. Neste arquivo o usuário deve selecionar o
banco de dados salvo como `<nome_do_banco>.csv` e os conjuntos de
variáveis respostas e preditoras, podendo haver mais de uma preditora
para a mesma variável resposta.

`saídas:` Pasta que armazena as saídas necessárias para a execução do
projeto.

`preditos.json:` Arquivo com os valores preditos utilizando o modelo
treinado.

`betas_conjunto<i>_reg<tipo>.rds:` Objeto que armazena os coeficientes
para cada predição e regressão.

`grafico_linha<i>.pdf`: Gráficos das regressões lineares simples.

`main.R`: Arquivo responsável pela execução completa do projeto,
passando por todos os scripts necessários.

## Guia de uso

Esta seção é um guia para o usuário sobre o projeto. Siga as instruções
a seguir para construir os resultados do seu modelo:

1.  Na pasta `entradas` insira seu banco de dados para o treinamento do
    modelo no formato `.csv`. Bancos de dados em formatos diferentes não
    são aceitos.

2.  No arquivo de `configuracao.yaml`, as seguintes informações devem
    ser especificadas:

<!-- -->

1.  Especifique o nome do banco de dados em formato `.csv` que contém os
    dados a serem treinados. O nome deve corresponder exatamente ao nome
    do arquivo como ele se encontra na pasta `entradas`, ou seja,
    `<nome_do_banco>.csv`.

2.  Para cada item adicionado, identifique a variável de resposta com a
    sintaxe `resposta: <nome_da_coluna>`. Abaixo da variável de
    resposta, mantendo a mesma indentação, liste as variáveis preditoras
    no formato `preditora<numero_da_preditora>: <nome_da_coluna>`, ou
    seja, para cada preditora é necessário escrever a palavra
    “preditora” seguida do número de ordem dela (por exemplo,
    `preditora1`, `preditora2`, etc.).

Exemplos de configurações (ignore os \#):

``` r
# dados_teste: iris.csv
#
#variaveis:
#- resposta: Sepal.Length
#  preditora1: Petal.Length
#  preditora2: Petal.Width
#- resposta: Sepal.Length
#  preditora1: Petal.Length
#- resposta: Sepal.Length
#  preditora1: Petal.Width
```

Neste exemplo serão treinados três modelos com o banco de dados
`iris.csv`. O primeiro modelo terá como variável resposta `Sepal.Length`
e variáveis preditoras `Petal.Length` e `Petal.Width`. O segundo modelo
terá como variável resposta `Sepal.Length` e variável preditora
`Petal.Length`. O terceiro modelo terá como variável resposta
`Sepal.Length` e variável preditora `Petal.Width`. É essencial que os
nomes utilizados para as variáveis de resposta e preditoras correspondam
exatamente aos nomes das colunas presentes no banco de dados indicado. A
aderência a esta nomenclatura é crucial para o correto funcionamento do
projeto. Observação: Caso seja seu interesse aplicar o modelo de
regressão lasso, devem ser indicados pelo menos duas preditoras.

3.  No arquivo `preditores.json`, presente na pasta `entradas` você
    deverá especificar as seguintes informações para cada valor predito
    desejado:

<!-- -->

1.  O texto deve ser escrito com a seguinte sintaxe:

2.  Inicie e termine o arquivo com colchetes,

``` r
# [ <indicacoes aqui> ]
```

2.  Para cada valor predito desejado você irá escrever entre chaves
    separadas por vírgulas,

``` r
# [ {<infos do primeiro valor predito>},
 
#   {<infos do segundo valor predito>} ]  
```

3.  Dentro de cada chave, a informação indicada deve ter o nome entre
    aspas e seu valor deve ser indicado após os dois pontos,

``` r
#[ {“info1”: <valor>, “info2”:<valor>},

#  {“info1”: <valor>, “info2”:<valor>} ] 
```

Caso haja variáveis categóricas veja o apêndice.

2.  Comece indicando o conjunto de variáveis que será utilizado no
    treinamento do modelo. Este conjunto deve corresponder exatamente ao
    que foi configurado no arquivo `configuracao.yaml`. Por exemplo, se
    foram definidos três conjuntos de variáveis e o desejo do usuário é
    realizar uma predição utilizando o modelo do primeiro conjunto (com
    `Sepal.Length` como variável de resposta e `Petal.Length` e
    `Petal.Width` como variáveis preditoras), deverá ser indicado o
    conjunto 1.

3.  Indique também o tipo de predição que deseja fazer. Escreva “lasso”
    no caso da regressão lasso ou “linear” no caso da regressão linear.
    Você deve incluir as aspas.

4.  Por fim, digite o(s) valor(es) da(s) variável(is) preditora(s). Você
    seguirá a mesma ordem indicada em `configuracao.yaml`. Seguindo o
    exemplo anterior, `Petal.Length` será usado com o valor 30 caso
    indique como `“preditora1”:30`.

Exemplo de predições:

``` r
#[
#  {"conjunto": 1, "tipo": "lasso", "preditora1":20, "preditora2":40},
#  {"conjunto": 1, "tipo": "linear", "preditora1":30, "preditora2": 80},
#  {"conjunto": 2, "tipo": "linear", "preditora1":0, "preditora2":0},
#  {"conjunto": 3, "tipo": "linear", "preditora1": 1.5}
#]
```

Neste exemplo estão sendo realizadas quatro predições. A primeira com o
conjunto 1 (terá com resposta `Sepal.Length` e variáveis preditoras
`Petal.Length` e `Petal.Width`) utilizando a regressão lasso com a
`preditora1`, `Petal.Length` com o valor de `20` e a `preditora2`,
`Petal.Width`, com o de `40`.

4.  Executar o arquivo main.R para a execução completa do projeto

## Resultados

Por fim, serão obtidos os seguintes produtos:

1.  Um arquivo no formato `.rds` contendo os coeficientes (betas)
    calculados do modelo treinado. Estes terão a nomenclatura
    `betas_conjunto<i>_reg<tipo>.rds`, onde `<i>` corresponde ao número
    do conjunto de variáveis (mantendo a mesma ordem das variáveis
    presente no arquivo `configuracao.yaml`), e `<tipo>` especifica o
    tipo de regressão utilizado, seja “linear” ou “lasso”, conforme
    indicado. É importante observar que para os conjuntos `<i>` que
    possuírem apenas uma preditora, não serão gerados arquivos com o
    sufixo “lasso”.

2.  Um arquivo `preditos.json` contendo os resultados das predições
    conforme indicado no arquivo `preditores.json`.

3.  Um possível arquivo `.pdf` de nomenclatura `grafico_linha<i>.pdf`,
    com `<i>` sendo a posição do valor predito no arquivo
    `preditores.json`. Esse arquivo será gerado somente para as
    predições feitas a partir de uma regressão linear simples (regressão
    linear de uma preditora). Este arquivo conterá a reta de regressão
    ajustada, acompanhada de uma representação gráfica do valor
    projetado, conforme as predições realizadas.

## Apêndice

Caso seja de interesse fazer predição com uma variável categórica, na
etapa 3, na linha sua predição deve-se incluir na parte preditoras o
número de categorias da sua variável menos um a partir da segunda
ordenada em ordem alfabetica.

Por exemplo, caso seja de interesse a predição da variável `Species`,
que tem como categorias Setosa, Versicolor e Virginia, a `preditora1`
será referente à Versicolor e à `preditora2` será referente à Virginia.
Assim, para prever uma das categorias, esta deve ser indicada com `1` e
as demais com `0`.

``` r
#[ 
#  {“preditora1”: 0, “preditora2”: 0}, 
#  {“preditora1”: 1, “preditora2”: 0},
#  {“preditora1”: 0, “preditora2”: 1}
#] 
```

Neste exemplo, a primeira linha está fazendo a predição para Setosa, a
segunda para Versicolor e a terceira para Virginia.

Esse caso só é aplicável para o caso de Regressão Linear Simples.

*Observação:* Nos exemplos para a sintaxe de arquivos `.json` ignore os
simbolos de `#`.

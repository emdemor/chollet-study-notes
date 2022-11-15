### 11.2.1 Padronização de textos

Considere as seguintes duas sequências:

* "sunset came. i was starting at the Mexico sky. Isnt nature splendid??"
* "Sunset came; I stared at the México sky. Isn’t nature splendid?"

As sentenças são bastante similares -  de fato, elas são idênticas. Ainda assim, se você converter ambas em byte strings, elas vão ter diferentes representações. Isto porque letras maiúsculas e minúsculas tem codificação distintas, acentos e pontuação e diferentes conjugações do mesmo verbo também.

*Padronização de textos* é o processo de feature engineering que trata com essas diferenças que você não quer que o modelo tenha que lidar. Estas etapas não são exclusivas de machine learning. Por exemplo, você provavelmente teria que fazer o mesmo em um sistema de busca.

Alguns dos esquemas de padronização mais simples são a *conversão para minúsculas* e *remoção dos caracteres de pontuação*. Aplicando estas duas etapas nas sentenças exemplificadas, obtém-se:

* "sunset came i was staring at the mexico sky isnt nature splendid"
* "sunset came i stared at the méxico sky isnt nature splendid"

Note como elas estão muito mais parecidas agora. Outra transformação bastante comum é a conversão de caracteres especiais a suas formas padronizadas, tais com as substituições de "é" por "e", "æ" para "ae" e etc. Nesse exemplo, o token "méxico" sera substituído por "mexico".

Por último, um procedimento de padronização mais complexo é o *stemming*. Esse processo nada mais é do que a unificação de diferentes variações de um mesmo termo (por exemplo, diferentes conjugações de um verbo). Nesse caso, as sentenças pode ser reescritas como:

* "sunset came i [stare] at the mexico sky isnt nature splendid"
* "sunset came i [stare] at the méxico sky isnt nature splendid"

Com esses procedimentos de padronização, seu modelo irá requerer menos dados para treinamento e generalizará melhor suas entradas. Claro, a padronização também remove uma grande quantidade de informação. Por isso, é importante ter o contexto de modelagem alinhado com o processo de padronização.
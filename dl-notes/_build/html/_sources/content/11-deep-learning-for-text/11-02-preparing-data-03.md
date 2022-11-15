### 11.2.2 Tokenização

Uma vez que o texto está padronizado, você precisa dividi-lo em unidades menores para serem vetorizadas. Essa etapa é chamada de *tokenização*. Voc^pode fazer isso em trê formas distintas:

* Tokenização *n*-grama: onde os tokens são grupos de *N* palavras consecutivas. Por exemplo, "o gato" ou "ele era" são tokens 2-grama (chamados de bigramas).

* Tokenização à nível de palavras: aqui, os tokens são separados por espaço (ou pontuação). Uma variante dessa abordagem consiste em dividir as palavras em sub-palavras (quando for aplicável).

* Tokenização à nível de caractere: onde cada caractere é seu próprio token. Na prática, esse esquema é raramente utilizado, sendo funcional apenas em contextos muito específicos, como geração de textos ou reconhecimento de fala. 

Em geral, você vai sempre usar tokenização a nível de palavras ou N-gramas. Existem dois tipos de modelos de processamento de texto: aquele que leva em consideração a ordem das palavras, chamados de *modelos de sequência*; e aqueles que tratam as palavras da entrada como um conjunto, descartando a ordem original. Esses são chamados de *bag-of-words*. Se você estiver construindo um modelo de sequência, você vai utilizar a tokenização por palavras. Porém, caso estiver trabalhando com bag-of-words, talvez seja melhor utilizar a tokenização por N-gramas. N-gramas representam uma forma artificial de considerar localmente uma quantidade de informação sobre a ordem das palavras no modelo. 

```{admonition} Entendendo N-gramas e bag-of-words
N-gramas são grupos de até N palavras consecutivas que você pode extrair de uma sequência. O mesmo conceito pode também ser aplicado a caracteres ao invés de palavras.

Aqui um simples exemplo. Considere a sentença "the car sat on the mat". Ela pode ser decomposta no seguinte conjunto de 2-gramas:

`{"the", "the cat", "cat", "cat sat", "sat", "sat on", "on", "on the", "the mat", "mat"}`

Pode-se também decompor no seguinte conjunto de 3-gramas:

`{"the", "the cat", "cat", "cat sat", "the cat sat",
 "sat", "sat on", "on", "cat sat on", "on the",
 "sat on the", "the mat", "mat", "on the mat"}`

 Esses conjuntos são chamadas de *bag-of-2-grams* e *bag-of-3-grams* respectivamente. O termo *bag* refere-se ao fato de que você está lidando com um conjunto de tokes e não com uma lista sequencial; ou seja, não existe ma ordem específica. 

 Por conta dos modelos de *bag* não preservarem a ordem dos tokens, eles tendem a ser usados em modelos de processamento de linguagem mais superficiais e não em abordagens de deep learning. Extrair N-gramas é uma forma de feature_engineering e os modelos de deep learning eliminam a necessidade dessa etapa, por aprendem organicamente durante o treinamento. CNNs unidimensionais, RNNs, e Transformers são capazes de aprender representações para grupos de palavras e personagens sem ser explicitamente informado sobre a existência de tais grupos, procurando em sequências contínuas de palavras ou caracteres.
```
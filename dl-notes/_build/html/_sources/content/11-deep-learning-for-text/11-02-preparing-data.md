## Preparing Data

Como os modelos de deep learning são funções diferenciáveis, só podem processar tensores numéricos: ou seja, não podem receber text puro como entrada. Por isso, o primeiro passo consiste em vetorizar os texto à serem submetidos à NLP.
 

`````{admonition} Vetorização de textos
*Vetorizar* um texto é o processo de transformar texto em tensores numéricos.
`````

O processo de vetorização pode ser feitor de inúmeras formas mas, de um ponto de vista geral, seguem o mesmo template:

* Primeiro, vou *padroniza* o texto para facilitar o processamento, como remoção de pontuação e conversão para lowercase
* Após isso, você divide o texto em unidades (chamadas *tokens*), como caracteres, palavras ou grupos de palavras. Esse processo é chamado de *tokenização*.
* Por último, você converte o token em um vetor numérico. Geralmente, esse processo envolve indexar todos os tokens presente nos dados. 

```{figure} images/11_01.png
:name: my-fig-ref
:width: 500px

From raw text to vectors!
```

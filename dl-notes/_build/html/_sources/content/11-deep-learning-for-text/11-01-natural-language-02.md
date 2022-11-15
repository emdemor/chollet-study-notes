## NLP: adotando Machine Learning

Esses sistemas construídos com regras feitas a mão se mantiveram como a abordagem dominante até a década de 1990. Mas a partir do final da década de 1980, computadores mais rápidos e maior disponibilidade de dados começaram a possibilitar uma alternativa melhor. Quando você se encontra construindo sistemas que são grandes pilhas de regras ad hoc, como um engenheiro inteligente, você provavelmente começará a perguntar: “Eu poderia usar um corpus de dados para automatizar o processo de encontrar essas regras? Eu poderia procurar as regras dentro de algum tipo de espaço de regras, em vez de ter que criá-las eu mesmo?” E assim, você se formou para fazer machine learning. E assim, no final da década de 1980, começamos a ver abordagens de aprendizado de máquina para processamento de linguagem natural. Os primeiros eram baseados em árvores de decisão - a intenção era literalmente automatizar a desenvolvimento do tipo de regras if/then/else dos sistemas anteriores. Então abordagens estatísticas começaram a ganhar velocidade, começando pela regressão logística. Com o tempo, os modelos com parâmetros "aprendidos" assumiram totalmente o controle, e a linguística passou a ser vista mais como um obstáculo do que como uma ferramenta útil. Frederick Jelinek, um dos primeiros pesquisadores de reconhecimento de fala, brincou na década de 1990: “Toda vez que eu demito um linguista, o desempenho do reconhecedor de fala aumenta”.

`````{admonition} NLP
:class: tip
É disso que se trata a NLP moderna: usar aprendizado de máquina e grandes conjuntos de dados para dar aos computadores a capacidade, não de entender a linguagem, que é um objetivo mais elevado, mas ingerir uma parte da linguagem como entrada e retornar algo útil.
`````

Exemplos de saídas úteis à partir de técnicas de NLP são:

* "Qual o assunto desse texto?" (categorização de texto)
* "Esse texto contém algum tipo de abuso?" (filtragem de conteúdo)
* "Esse texto é positivo ou negativo?" (análise de sentimento)
* "Quais são as próximas palavras dessa sentença incompleta?" (modelo de linguagem)
* "Como você diria isso em Alemão?" (tradução)
* "Como você resumiria o texto em um parágrafo?" (sumarização)
* etc.

É importante que fique claro que os modelos de processamento textuais não possuem uma capacidade de compreensão tal como a mente humana: eles simplesmente aprendem padrões presentes nos dados de entrada. 

Ainda que os modelos de reconhecimento de textos, dependentes de arvores de decisão ou regressão logística, tivessem eficiência superior aos sistemas de regras linguísticas impostas, eles pouco evoluíram no intervalo entre 1990 e 2013. Nesse tempo, muito das melhorias eram conseguidas com aprimoramentos das etapas de feature-engineering. Porém, as coisas começaram a mudar a partir de 2014: muitos pesquisadores passaram à investigar a capacidade de ser "entender" a linguagem com a utilização de redes neurais artificiais - mais especificamente, a LSTM.

No começo de 2015, Keras disponibilizou a primeira implementação user-friendly do LSTM. Então, de 2015 à 2017, Redes Neurais Recorrentes dominaram o cenário de NLP. Modelos de LSTM bidirecionais, em particular, se tornaram o estado da arte para muitas tarefas importantes.

Finalmente, por volta de 2017-2018, uma nova arquitetura apareceu para substituir RNNs: os transformers. Transformers deram origem a progressos consideráveis em um período de tempo bastante curto. 

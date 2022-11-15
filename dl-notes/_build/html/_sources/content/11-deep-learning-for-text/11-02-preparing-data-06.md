### Usando a camada `TextVectorization` em uma pipeline `tf.data` ou como parte de um modelo

É importante ter em mente que, como `TextVectorization` é uma operação de busca em dicionários, ela não pode ser executada em uma GPU (ou TPU); somente em CPU. Portanto, se você está treinando um modelo em uma GPU, sua camada `TextVectorization` antes de enviar seu output para a GPU. Isso tem importantes implicações de performance.

Existem duas formas de se usar a camada `TextVectorization`. A primeira opção é usar na pipeline `tf.data`, assim:

```python
int_sequence_dataset = string_dataset.map(
    text_vectorization,
    num_parallel_calls=4,
)
```

A segunda opção é fazer com que a camada `TextVectorization` seja parte do modelo (afinal de contas, é também uma camada do Keras):

```python
text_input = keras.Input(shape=(), dtype="string")
vectorized_text = text_vectorization(text_input)
embedded_input = keras.layers.Embedding(...)(vectorized_text)
output = ...
model = keras.Model(text_input, output)
```

Há uma diferença importante entre os dois: se a etapa de vetorização fizer parte do modelo, ela acontecerá de forma síncrona com o restante das etapas. Isso significa que a cada etapa de treinamento, o restante do modelo (colocado na GPU) terá que esperar que a saída da camada TextVectorization (colocada na CPU) esteja pronta para começar a trabalhar. Enquanto isso, colocar a camada no pipeline tf.data permite que você faça o pré-processamento assíncrono de seus dados na CPU: enquanto a GPU executa o modelo em um batch de dados vetorizados, a CPU fica ocupada vetorizando o próximo batch de strings brutas.

Portanto, se você estiver treinando o modelo em GPU ou TPU, provavelmente desejará usar a primeira opção para obter o melhor desempenho. Isto é o que faremos em todos os exemplos práticos ao longo deste capítulo. Ao treinar em uma CPU, no entanto, o processamento síncrono é bom: você obterá 100% de utilização de seus núcleos, independentemente da opção escolhida.

Agora, se você exportasse nosso modelo para um ambiente de produção, você desejaria enviar um modelo que aceitasse strings brutas como entrada, como no trecho de código para a segunda opção acima - caso contrário, você teria que reimplementar a padronização de texto e tokenização em seu ambiente de produção (talvez em JavaScript?), e correria o risco de introduzir pequenas discrepâncias de pré-processamento que prejudicariam a precisão do modelo. Felizmente, a camada TextVectorization permite que você inclua o pré-processamento de texto diretamente em seu modelo, facilitando a implantação, mesmo se você estiver usando originalmente a camada como parte de um pipeline tf.data.
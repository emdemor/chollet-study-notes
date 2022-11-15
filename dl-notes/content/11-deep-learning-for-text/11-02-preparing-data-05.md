### 11.2.4  Usando a camada de TextVectorization

Cada um dos passos comentados anteriormente pode facilmente ser implementado em Python puro. Porém, essa abordagem não seria muito performática. Na prática, a forma mais eficiente é utilizar a camada `TextVectorization` do Keras, que é rápida e eficiente e pode ser inserida diretamente em uma pipeline `tf.data` ou um Keras model.

Uma camada `TextVectorization` se parece como:

```python
from tensorflow.keras.layers import TextVectorization

text_vectorization = TextVectorization(output_mode="int")
```

Note que é possível configurar o formato da saída da camada. No exemplo, foi configurado para retornar sequência de palavras encodadas por índices inteiros. 

Por padrão, a camada `TextVectorization` irá adotar "conversão para minúscula" e "remoção de pontuação" como etapas de padronização. Já para tokenização, utiliza-se por padrão a "separação por espaço". Mas é importante ressaltar que é possível fornecer funções customizadas para cada um desses procedimentos. Essas funções devem operar sobre tensores `tf.string` e não strings regulares de Python. Por exemplo, a sintaxe para funções customizadas é:

```python
import re
import string
import tensorflow as tf


def custom_standardization_fn(string_tensor):
    lowercase_string = tf.strings.lower(string_tensor)
    return tf.strings.regex_replace(
        lowercase_string, f"[{re.escape(string.punctuation)}]", ""
    )


def custom_split_fn(string_tensor):
    return tf.strings.split(string_tensor)


text_vectorization = TextVectorization(
    output_mode="int",
    standardize=custom_standardization_fn,
    split=custom_split_fn,
)
```

Para indexar o vocabulário de um corpus de texto, basta chamar o método `adapt()` da camada com um objeto `Dataset` que retorna strings, ou somente com uma lista de strings Python:

```python
dataset = [
 "I write, erase, rewrite",
 "Erase again, and then",
 "A poppy blooms.",
]
text_vectorization.adapt(dataset)
```

Você pode obter o vocabulário chamando o método `get_vocabulary()` - isso pode ser útil se você precisar converter o texto encodado como sequência de inteiros em palavras novamente. As primeiras duas entradas do vocabulário são o token de máscara (índice 0) e o token de OOV (índice 1). Entradas em listas de vocabulário são ordenadas por frequência. Assim, em um corpus com dados do mundo real, palavras muito comuns viriam primeiro.

```python
vocabulary = text_vectorization.get_vocabulary()
test_sentence = "I write, rewrite, and still rewrite again"
encoded_sentence = text_vectorization(test_sentence)
print("encoded_sentence =",encoded_sentence)
```

`encoded_sentence = tf.Tensor([ 7  3  5  9  1  5 10], shape=(7,), dtype=int64)`


```python
inverse_vocab = dict(enumerate(vocabulary))
decoded_sentence = " ".join(inverse_vocab[int(i)] for i in encoded_sentence)
print("decoded_sentence =",decoded_sentence)
```

`decoded_sentence = i write rewrite and [UNK] rewrite again`
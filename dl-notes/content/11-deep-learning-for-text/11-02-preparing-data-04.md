### 11.2.3 Indexação de vocabulário

Agora que o texto foi separado em tokens, você precisa encodar cada token em uma representação numérica. Você poderia fazer isso de uma forma independente de estado, tal como hash-ando cada token em um vetor binário fixo, mas na prática, a forma como você lida com isso é construindo uma indexação de todos os termos encontrados nos dados de treino (chamado de *vocabulário*) e associar um valor inteiro único a cada entrada do vocabulário. Por exemplo:
```python
import string
import unicodedata


def remove_punctuation(input_string):
    return input_string.translate(
        str.maketrans(dict.fromkeys(string.punctuation))
    )

def remove_accents(input_string):
    return "".join(
        c for c in unicodedata.normalize("NFD", input_string)
        if unicodedata.category(c) != "Mn"
    )

def standardize(input_string):
    return strip_accents(remove_punctuation(input_string)).lower()

def tokenize(input_string):
    return input_string.split(" ")

dataset = [
    "A garota foi até a praia.",
    "Onde estão meus amigos?",
    "Acho que eles já foram embora!!!",
]

vocabulary = {}

for text in dataset:
    text = standardize(text)
    tokens = tokenize(text)
    for token in tokens:
        if token not in vocabulary:
            vocabulary[token] = len(vocabulary)
```
Nesse caso, o vocabulário indexado será:

`{ "a": 0, "garota": 1, "foi": 2, "ate": 3, "praia": 4, "onde": 5, "estao": 6, "meus": 7, "amigos": 8, "acho": 9, "que": 10, "eles": 11, "ja": 12, "foram": 13, "embora": 14,
}`

Então, você pode converter o vocabulário indexado em um vetor encodado que pode ser processado por uma rede neural, tal como um vetor one-hot:

```python
def one_hot_encode_token(token):
    vector = np.zeros((len(vocabulary),))
    token_index = vocabulary[token]
    vector[token_index] = 1
    return vector
```
Para o caso da palavra `praia`, o vetor encodado será:

`"praia" := [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0]`

Nesta etapa, é comum restringir o vocabulário apenas às 20.000 ou 30.000 primeiras palavras mais comuns encontradas nos dados de treinamento. Qualquer conjunto de dados de texto tende a apresentar um número extremamente grande de termos exclusivos, a maioria dos quais aparece apenas uma vez ou duas vezes — indexar esses termos raros resultaria em um espaço de recursos excessivamente grande, onde a maioria dos recursos quase não teria conteúdo de informação.

Agora, há um detalhe importante aqui que deve ser salientado: um novo token pode não existir no vocabulário indexado. Seu dados de treinamento podem não conter nenhuma instância da palavra “cherimoya”, por exemplo (ou talvez você tenha excluído do seu índice porque era muito raro). Então, durante a predição, se tomarmos token_index = vocabulário["cherimoya"], obteremos `KeyError`. Para lidar com isso, você deve usar um índice "fora de vocabulário" (abreviado como índice OOV de *out of vocabulary*) - que se estende para qualquer token que não está presente no vocabulário. Geralmente, adota-se o índice 1. Ao decodificar uma sequência de inteiros de volta em palavras, você substituirá 1 por algo como "[UNK]" (que você chamaria de "token OOV").

Por que usar 1 e não 0?. Isso porque 0 é reservado para ser utilizado em outras situações. Há dois tokens especiais que você normalmente usará: o token OOV (índice 1) e o token token de máscara (índice 0). Enquanto o token OOV significa "aqui estava uma palavra que não reconhecemos", o token de máscara nos diz "ignore-me, não sou uma palavra". Você o usaria em particular para batchs de dados em sequência: como os batches de dados precisam ser contíguos, todas as sequências em um batch de dados de sequência deve ter o mesmo comprimento, portanto, sequências mais curtas devem ser preenchido para o comprimento da sequência mais longa. Se você quiser fazer um batch de dados com as sequências [5, 7, 124, 4, 89] e [8, 34, 21], teria que ficar assim:

`[[5, 7, 124, 4, 89]`
`[8, 34, 21, 0, 0]]`
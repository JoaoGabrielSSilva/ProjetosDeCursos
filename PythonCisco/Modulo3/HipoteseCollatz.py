'''
Em 1937, um matemático alemão chamado Lothar Collatz formulou uma hipótese intrigante (ainda não provada) que pode ser descrita da seguinte forma:

tomar qualquer número inteiro não-negativo e não-nulo e nomeá-lo c0;
se for par, avalie um novo c0 como c0 ÷ 2;
caso contrário, se for ímpar, avalie um novo c0 como 3 × c0 + 1;
Se c0 ≠ 1, saltar para o ponto 2.
A hipótese diz que, independentemente do valor inicial de c0, irá sempre para 1.

É claro que é uma tarefa extremamente complexa utilizar um computador para provar a hipótese de qualquer número natural (pode até requerer inteligência artificial), mas pode usar o Python para verificar alguns números individuais. Talvez até encontre o que possa refutar a hipótese.


Escreva um programa que leia um número natural e execute os passos acima indicados, desde que c0 permaneça diferente de 1. Também queremos que conte os passos necessários para alcançar o objetivo. O seu código deve fazer output de todos os valores intermédios de c0, também.

Dica: a parte mais importante do problema é como transformar a ideia de Collatz num loop while - esta é a chave para o sucesso.

Teste o seu código utilizando os dados por nós fornecidos.
'''

c0 = int(input("Digite um numero: "))
steps = 0


while c0 != 1:
    if c0 % 2 == 0:
        c0 = c0 / 2
        print(int(c0))
        steps = steps + 1
    else:
        c0 = 3 * c0 + 1
        print(int(c0))
        steps = steps + 1
print(f"steps: {steps}")


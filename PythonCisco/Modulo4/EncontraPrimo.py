'''
Um número natural é primo se for maior que 1 e não tiver divisores além de 1 e dele próprio.

Complicado? De modo algum. Por exemplo, 8 não é um número primo, uma vez que se pode dividi-lo por 2 e 4 (não podemos utilizar divisores iguais a 1 e 8, uma vez que a definição o proíbe).

Por outro lado, 7 é um número primo, uma vez que não conseguimos encontrar quaisquer divisores legais para ele.


A sua tarefa é escrever uma função para verificar se um número é primo ou não.

A função:

é chamada is_prime;
toma um argumento (o valor a verificar)
devolve True se o argumento for um número primo, e False caso contrário.
'''

def is_prime(num):
    if num > 1:
        if num % 2 == 0: 
            if num == 2:
                return True
            return False
        elif num % 3 == 0:
            if num == 3:                
                return True
            return False
        elif num % 4 == 0:
            return False
        return True

for i in range(1, 20):
	if is_prime(i + 1):
			print(i + 1, end=" ")

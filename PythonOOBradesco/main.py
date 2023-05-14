class Main:
    pass

from Cliente import Cliente
from Conta import Conta

c1 = Cliente("João", "1234-5678")
conta = Conta(c1.nome, 6565, 0)


print(conta.titular, " e ", conta.numero, conta.saldo)

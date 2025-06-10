#!/usr/bin/env python3

import os
import random

def gerar_arquivo_sorted(tamanho, nome_arquivo):
    """Gera arquivo com números ordenados crescentemente"""
    with open(nome_arquivo, 'w') as f:
        for i in range(1, tamanho + 1):
            f.write(f"{i}\n")

def gerar_arquivo_random(tamanho, nome_arquivo):
    """Gera arquivo com números aleatórios"""
    numeros = list(range(1, tamanho + 1))
    random.shuffle(numeros)
    with open(nome_arquivo, 'w') as f:
        for num in numeros:
            f.write(f"{num}\n")

def gerar_arquivo_desc(tamanho, nome_arquivo):
    """Gera arquivo com números ordenados decrescentemente"""
    with open(nome_arquivo, 'w') as f:
        for i in range(tamanho, 0, -1):
            f.write(f"{i}\n")

def main():
    # Criar diretório de entradas
    os.makedirs('entradas', exist_ok=True)
    
    tamanhos = [1000, 10000, 100000, 500000, 1000000, 5000000, 10000000]
    tipos = {
        'sorted': gerar_arquivo_sorted,
        'random': gerar_arquivo_random,
        'desc': gerar_arquivo_desc
    }
    
    print("Gerando arquivos de entrada...")
    print("==============================")
    
    for tamanho in tamanhos:
        for tipo, funcao in tipos.items():
            nome_arquivo = f"entradas/entrada_{tamanho}_{tipo}.txt"
            print(f"Gerando: {nome_arquivo}")
            funcao(tamanho, nome_arquivo)
    
    print("\nArquivos gerados com sucesso!")
    print("Arquivos criados no diretório 'entradas/':")
    
    # Listar arquivos criados
    for arquivo in sorted(os.listdir('entradas')):
        caminho = os.path.join('entradas', arquivo)
        tamanho_arquivo = os.path.getsize(caminho)
        print(f"  {arquivo} ({tamanho_arquivo} bytes)")

if __name__ == "__main__":
    main()
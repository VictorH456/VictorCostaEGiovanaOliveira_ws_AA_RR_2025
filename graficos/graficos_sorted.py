import pandas as pd
import matplotlib.pyplot as plt

# Lê os dados
df = pd.read_csv("resultados/resultados_media.csv")
df['tamanho'] = df['tamanho'].astype(int)
df['tempo'] = pd.to_numeric(df['tempo'], errors='coerce')
df['comparacoes'] = pd.to_numeric(df['comparacoes'], errors='coerce')

def plot_interativo(tipo_entrada):
    df_tipo = df[df['tipo_entrada'] == tipo_entrada]

    # Tempo (log)
    plt.figure(figsize=(10,6))
    for alg in df_tipo['algoritmo'].unique():
        dados = df_tipo[df_tipo['algoritmo'] == alg]
        plt.plot(dados['tamanho'], dados['tempo'], marker='o', label=alg)
    plt.title(f"Tempo × Tamanho ({tipo_entrada}) [Zoom Interativo]")
    plt.xlabel("Tamanho da entrada")
    plt.ylabel("Tempo (s)")
    plt.yscale("log")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.show()

    # Comparações (log)
    plt.figure(figsize=(10,6))
    for alg in df_tipo['algoritmo'].unique():
        dados = df_tipo[df_tipo['algoritmo'] == alg]
        plt.plot(dados['tamanho'], dados['comparacoes'], marker='o', label=alg)
    plt.title(f"Comparações × Tamanho ({tipo_entrada}) [Zoom Interativo]")
    plt.xlabel("Tamanho da entrada")
    plt.ylabel("Comparações")
    plt.yscale("log")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.show()

# Troque o tipo para o que quiser visualizar
plot_interativo("sorted")

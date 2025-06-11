import pandas as pd
import matplotlib.pyplot as plt

# 1. Ler o arquivo CSV
df = pd.read_csv("/home/torugo/Documentos/Faculdade/6° Semestre/Análise de algoritmos/codigo/Seminario/resultados/resultados.csv")


# 2. Separar por algoritmo
merge_df = df[df["algoritmo"] == "merge"]
merge3_df = df[df["algoritmo"] == "merge3"]

# Função para plotar um gráfico para um algoritmo específico
def plot_algoritmo(df_alg, titulo):
    plt.figure(figsize=(10, 6))
    for tipo in ['sorted', 'random', 'desc']:
        sub_df = df_alg[df_alg['tipo_entrada'] == tipo]
        plt.plot(sub_df['tamanho'], sub_df['tempo'], marker='o', label=tipo)

    plt.xscale("log")
    plt.yscale("log")
    plt.xlabel("Tamanho da entrada (n)")
    plt.ylabel("Tempo de execução (s)")
    plt.title(titulo)
    plt.legend()
    plt.grid(True, which="both", ls="--", linewidth=0.5)
    plt.tight_layout()
    plt.show()

# 3. Gerar gráfico para merge
plot_algoritmo(merge_df, "Tempo de execução - Merge Sort")

# 4. Gerar gráfico para merge3
plot_algoritmo(merge3_df, "Tempo de execução - Merge3 Sort")

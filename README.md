# VictorCostaEGiovanaOliveira_ws_AA_RR_2025
---

<br />  
<p align="center">
  <a href="">
    <img src="https://user-images.githubusercontent.com/49700354/114078715-a61b2f00-987f-11eb-8eef-6fd7cfc17d33.png" alt="" width="80" height="80">
    <img src="https://github.com/VictorH456/MIC014Aula2-VictorC-RyanK-IgorP_UFRR_2024/blob/main/imagens/dcc.png" alt="" width="80" height="80">
  </a>
  <h1 align="center">Análise de Algoritmos</h1>
  <p align="center">
    Projeto de comparação entre Merge Sort tradicional e uma variação otimizada (Merge3 Sort).
  </p>
</p>

---

## 🎯 Objetivos

✅ **Função de custo e complexidade**  
✅ **Código em C dos algoritmos**  
✅ **Coleta experimental de tempos de execução com diferentes tamanhos de entrada**  
✅ **Geração de gráficos de linha para comparação e análise de tendência assintótica**  
✅ **Proposição e avaliação de um algoritmo mais eficiente**

---

## 📚 Descrição dos Algoritmos

### Merge Sort (Convencional)
- Divide o vetor em **duas partes**
- **Complexidade:** O(n log₂ n)
- **Função de custo:** T(n) = 2T(n/2) + O(n)

### Merge3 Sort (Proposto)
- Divide o vetor em **três partes iguais**
- **Complexidade estimada:** O(n log₃ n)
- **Função de custo:** T(n) = 3T(n/3) + O(n)
- **Vantagem:** Melhor desempenho prático para entradas grandes

---

## ⚙️ Código-Fonte

Os algoritmos foram implementados em **linguagem C**:

- `merge_sort.c` → Implementação do Merge Sort tradicional
- `merge3_sort.c` → Implementação do Merge Sort com divisão em três partes

---

## 🧪 Metodologia Experimental

### Tipos de Entrada Geradas:
- **sorted** (ordenadas crescentes)
- **random** (valores aleatórios)
- **desc** (ordenadas decrescentes)

### Tamanhos Testados:
- De **1.000** a **100.000.000** elementos

### Métricas Coletadas:
- Tempo de execução (em segundos)

Os dados foram salvos no arquivo `resultados.csv`.

---

## 📊 Análise Gráfica

Foram gerados gráficos para comparar os dois algoritmos em diferentes tipos de entrada.  
Utilizamos escala logarítmica para facilitar a visualização de tendências assintóticas.

Gráficos:
- Tempo de execução x Tamanho da entrada (`merge` e `merge3`)

O Merge3 Sort apresenta melhor desempenho prático, especialmente em entradas aleatórias ou com grandes volumes.

---

## 📈 Conclusão

O Merge3 Sort se mostrou mais eficiente do que o Merge Sort tradicional em termos de tempo de execução para a maioria dos testes.  
Apesar de ambos manterem complexidade O(n log n), o **merge3** aproveita melhor o custo de divisão ao reduzir profundidade recursiva.

> Em cenários com grandes volumes de dados, **Merge3 Sort é recomendável como alternativa otimizada.**

---

## 📁 Estrutura de Arquivos

- `merge_sort.c` — Merge Sort tradicional e Merge Sort com 3 divisões  
- `gerador_entrada.py` — Geração de vetores de teste
- `benchmark.py` — Executa os testes e salva em `resultados.csv`
- `graficos.py` — Geração de gráficos comparativos
- `resultados.csv` — Base de dados com tempos de execução

---

## 👨‍🏫 Autores

- **Victor Costa** — Ciência da Computação — UFRR  
- **Giovana Oliveira** — Ciência da Computação — UFRR
---

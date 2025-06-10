#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

void merge3_sort(int *arr, int l, int r);

// Função para ler vetor de um arquivo
int *ler_arquivo(const char *nome_arquivo, int *tamanho)
{
    FILE *fp = fopen(nome_arquivo, "r");
    if (!fp)
    {
        perror("Erro ao abrir arquivo");
        exit(1);
    }

    int capacidade = 1000;
    int *vetor = malloc(sizeof(int) * capacidade);
    int valor, count = 0;

    while (fscanf(fp, "%d", &valor) == 1)
    {
        if (count >= capacidade)
        {
            capacidade *= 2;
            vetor = realloc(vetor, sizeof(int) * capacidade);
        }
        vetor[count++] = valor;
    }

    fclose(fp);
    *tamanho = count;
    return vetor;
}

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf("Uso: %s <algoritmo> <arquivo_entrada.txt>\n", argv[0]);
        printf("Algoritmos: merge\n");
        return 1;
    }

    const char *algoritmo = argv[1];
    const char *arquivo = argv[2];

    int n;
    int *arr = ler_arquivo(arquivo, &n);

    if (n == 0) {
        printf("Erro: arquivo vazio ou não foi possível ler dados\n");
        free(arr);
        return 1;
    }

    clock_t inicio = clock();

    if (strcmp(algoritmo, "merge") == 0)
    {
        merge3_sort(arr, 0, n - 1);
    }
    else
    {
        printf("Algoritmo '%s' não reconhecido\n", algoritmo);
        free(arr);
        return 1;
    }

    clock_t fim = clock();
    double tempo = (double)(fim - inicio) / CLOCKS_PER_SEC;

    printf("Arquivo: %s\n", arquivo);
    printf("Algoritmo: %s\n", algoritmo);
    printf("Tamanho: %d\n", n);
    printf("Tempo (s): %f\n", tempo);

    free(arr);
    return 0;
}
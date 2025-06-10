#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Função auxiliar para mesclar três partes do array
void merge3(int A[], int p, int d, int r)
{
    int *B = (int *)malloc((r - p + 1) * sizeof(int));
    int i = p, j = d + 1, k = r - (r - d) + 1;
    int idx = 0;

    while (i <= d && j <= r - (r - d) && k <= r)
    {
        if (A[i] <= A[j] && A[i] <= A[k])
        {
            B[idx++] = A[i++];
        }
        else if (A[j] <= A[i] && A[j] <= A[k])
        {
            B[idx++] = A[j++];
        }
        else
        {
            B[idx++] = A[k++];
        }
    }

    while (i <= d && j <= r - (r - d))
    {
        B[idx++] = (A[i] <= A[j]) ? A[i++] : A[j++];
    }
    while (i <= d && k <= r)
    {
        B[idx++] = (A[i] <= A[k]) ? A[i++] : A[k++];
    }
    while (j <= r - (r - d) && k <= r)
    {
        B[idx++] = (A[j] <= A[k]) ? A[j++] : A[k++];
    }

    while (i <= d)
        B[idx++] = A[i++];
    while (j <= r - (r - d))
        B[idx++] = A[j++];
    while (k <= r)
        B[idx++] = A[k++];

    for (i = 0; i < idx; i++)
    {
        A[p + i] = B[i];
    }

    free(B); // para evitar vazamento de memória
}

void merge3_sort(int A[], int p, int r)
{
    if (p < r)
    {
        int d = (r - p) / 3;
        merge3_sort(A, p, p + d);
        merge3_sort(A, p + d + 1, r-d);
        merge3_sort(A, r-d + 1, r);

        merge3(A, p, r-d, r);
    }
}
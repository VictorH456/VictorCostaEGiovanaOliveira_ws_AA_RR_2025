#!/bin/bash

# Criar diretório de resultados
mkdir -p resultados
echo "algoritmo,tipo_entrada,tamanho,tempo" > resultados/resultados.csv

# Configurar limite de stack (importante para recursão)
ulimit -s unlimited

# Arrays de configuração
algoritmos=("merge")
tipos=("sorted" "random" "desc")
tamanhos=("1000" "10000" "100000" "500000" "1000000" "5000000" "10000000")

# Verificar se o executável existe
if [ ! -f "./utils/medir" ]; then
    echo "Erro: Executável './utils/medir' não encontrado!"
    echo "Execute 'make' ou 'gcc -o medir merge_sort.c medir_performance.c' primeiro"
    exit 1
fi

# Verificar se o diretório de entradas existe
if [ ! -d "entradas" ]; then
    echo "Erro: Diretório 'entradas' não encontrado!"
    echo "Certifique-se de que os arquivos de entrada estão no diretório 'entradas/'"
    exit 1
fi

echo "Iniciando testes de performance..."
echo "=================================="

total_testes=0
testes_executados=0

# Contar total de testes
for alg in "${algoritmos[@]}"; do
  for tipo in "${tipos[@]}"; do
    for tam in "${tamanhos[@]}"; do
      arquivo="entradas/entrada_${tam}_${tipo}.txt"
      if [ -f "$arquivo" ]; then
        ((total_testes++))
      fi
    done
  done
done

echo "Total de testes a executar: $total_testes"
echo ""

# Executar testes
for alg in "${algoritmos[@]}"; do
  for tipo in "${tipos[@]}"; do
    for tam in "${tamanhos[@]}"; do
      arquivo="entradas/entrada_${tam}_${tipo}.txt"
      if [ -f "$arquivo" ]; then
        ((testes_executados++))
        echo "[$testes_executados/$total_testes] Executando: $alg - $arquivo"
        
        # Executar o teste e capturar a saída
        resultado=$(./utils/medir "$alg" "$arquivo" 2>&1)
        exit_code=$?
        
        if [ $exit_code -eq 0 ]; then
          # Extrair o tempo da saída
          tempo=$(echo "$resultado" | grep "Tempo" | awk '{print $3}')
          
          if [ -n "$tempo" ]; then
            echo "$alg,$tipo,$tam,$tempo" >> resultados/resultados.csv
            echo "  ✓ Tempo: ${tempo}s"
          else
            echo "  ✗ Erro: Não foi possível extrair o tempo"
            echo "$alg,$tipo,$tam,ERRO" >> resultados/resultados.csv
          fi
        else
          echo "  ✗ Erro na execução:"
          echo "$resultado" | sed 's/^/    /'
          echo "$alg,$tipo,$tam,ERRO" >> resultados/resultados.csv
        fi
        echo ""
      else
        echo "Arquivo não encontrado: $arquivo"
      fi
    done
  done
done

echo "=================================="
echo "Testes concluídos!"
echo "Resultados salvos em: resultados/resultados.csv"
echo ""

# Mostrar um resumo dos resultados
if [ -f "resultados/resultados.csv" ]; then
  echo "Resumo dos resultados:"
  echo "----------------------"
  tail -n +2 resultados/resultados.csv | while IFS=',' read -r alg tipo tam tempo; do
    if [ "$tempo" != "ERRO" ]; then
      printf "%-6s %-8s %8s: %8ss\n" "$alg" "$tipo" "$tam" "$tempo"
    else
      printf "%-6s %-8s %8s: %8s\n" "$alg" "$tipo" "$tam" "ERRO"
    fi
  done
fi
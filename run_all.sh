#!/bin/bash

# Criar diretório de resultados
mkdir -p resultados
echo "algoritmo,tipo_entrada,tamanho,tempo" > resultados/resultados.csv

# Configurar limite de stack (importante para recursão)
ulimit -s unlimited

# Arrays de configuração
algoritmos=("merge" "merge3")
tipos=("sorted" "random" "desc")
tamanhos=("1000" "10000" "100000" "500000" "1000000" "5000000" "10000000" "50000000" "100000000")

# Verificar se o executável existe
if [ ! -f "./utils/medir" ]; then
    echo "Erro: Executável './utils/medir' não encontrado!"
    echo "Execute 'make' na pasta utils ou compile manualmente:"
    echo "cd utils && gcc -o medir merge_sort.c medir_performance.c"
    exit 1
fi

# Verificar se o diretório de entradas existe
if [ ! -d "entradas" ]; then
    echo "Erro: Diretório 'entradas' não encontrado!"
    echo "Certifique-se de que os arquivos de entrada estão no diretório 'entradas/'"
    exit 1
fi

echo "Iniciando testes de performance..."
echo "Comparando Merge Sort tradicional vs Merge Sort 3-way"
echo "====================================================="

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
  echo "Testando algoritmo: $alg"
  echo "------------------------"
  for tipo in "${tipos[@]}"; do
    for tam in "${tamanhos[@]}"; do
      arquivo="entradas/entrada_${tam}_${tipo}.txt"
      if [ -f "$arquivo" ]; then
        ((testes_executados++))
        printf "[$testes_executados/$total_testes] %-6s %-8s %8s: " "$alg" "$tipo" "$tam"
        
        # Executar o teste e capturar a saída
        resultado=$(timeout 60s ./utils/medir "$alg" "$arquivo" 2>&1)
        exit_code=$?
        
        if [ $exit_code -eq 0 ]; then
          # Extrair o tempo da saída
          tempo=$(echo "$resultado" | grep "Tempo" | awk '{print $3}')
          
          if [ -n "$tempo" ]; then
            echo "$alg,$tipo,$tam,$tempo" >> resultados/resultados.csv
            printf "%8ss ✓\n" "$tempo"
          else
            echo "$alg,$tipo,$tam,ERRO" >> resultados/resultados.csv
            echo "ERRO (sem tempo)"
          fi
        elif [ $exit_code -eq 124 ]; then
          echo "$alg,$tipo,$tam,TIMEOUT" >> resultados/resultados.csv
          echo "TIMEOUT (>60s)"
        else
          echo "$alg,$tipo,$tam,ERRO" >> resultados/resultados.csv
          echo "ERRO (exit $exit_code)"
        fi
      else
        echo "Arquivo não encontrado: $arquivo"
      fi
    done
  done
  echo ""
done

echo "====================================================="
echo "Testes concluídos!"
echo "Resultados salvos em: resultados/resultados.csv"
echo ""

# Mostrar um resumo comparativo
if [ -f "resultados/resultados.csv" ]; then
  echo "Resumo comparativo dos resultados:"
  echo "=================================="
  printf "%-8s %-8s %10s %10s %10s\n" "Tipo" "Tamanho" "Merge" "Merge3" "Speedup"
  echo "------------------------------------------------"
  
  for tipo in "${tipos[@]}"; do
    for tam in "${tamanhos[@]}"; do
      merge_time=$(grep "^merge,$tipo,$tam," resultados/resultados.csv | cut -d',' -f4)
      merge3_time=$(grep "^merge3,$tipo,$tam," resultados/resultados.csv | cut -d',' -f4)
      
      if [ -n "$merge_time" ] && [ -n "$merge3_time" ] && [ "$merge_time" != "ERRO" ] && [ "$merge3_time" != "ERRO" ] && [ "$merge_time" != "TIMEOUT" ] && [ "$merge3_time" != "TIMEOUT" ]; then
        speedup=$(echo "scale=2; $merge_time / $merge3_time" | bc -l 2>/dev/null || echo "N/A")
        printf "%-8s %8s %9ss %9ss %9s\n" "$tipo" "$tam" "$merge_time" "$merge3_time" "${speedup}x"
      else
        printf "%-8s %8s %9s %9s %9s\n" "$tipo" "$tam" "${merge_time:-N/A}" "${merge3_time:-N/A}" "N/A"
      fi
    done
  done
fi
#!/bin/bash

echo "Monitorizando temperaturas durante 60 segundos..."
echo ""
total_diff=0
count=0

# Bucle durante 60 segundos
for i in {1..60}
do
    # Extraer temperaturas (solo el número)
    temp0=$(sensors | grep "Core 0" | awk '{print $3}' | tr -d '+°C')
    temp1=$(sensors | grep "Core 1" | awk '{print $3}' | tr -d '+°C')

    # Calcular diferencia instantánea (Core 0 - Core 1)
    # Usamos 'bc' para manejar decimales
    diff=$(echo "$temp0 - $temp1" | bc)
   
    # Sumar a la diferencia total
    total_diff=$(echo "$total_diff + $diff" | bc)
    count=$((count + 1))
    # Imprimimos los datos
    echo "Segundo $i: Core0: ${temp0}°C | Core1: ${temp1}°C | Dif: ${diff}°C"
   
    sleep 1
done

    # Calcular promedio final
avg_diff=$(echo "scale=2; $total_diff / $count" | bc)

echo "------------------------------------------------"
echo "Monitoreo finalizado."
echo "La diferencia promedio entre Core 0 y 1 ha sido de: $avg_diff °C"

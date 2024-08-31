#!/bin/bash

# Obter o valor atual e o valor máximo da luminosidade
current_brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)

# Calcular a porcentagem de iluminação
percentage=$(awk "BEGIN {printf \"%.0f\", ($current_brightness / $max_brightness) * 100}")

# Exibir o resultado
echo "${percentage}%"


#!/bin/bash

if [ -z "$1" ]; then
    echo "Iniciando o container sem parâmetro"
else
    echo "Iniciando o container com parâmetro: $1"
fi

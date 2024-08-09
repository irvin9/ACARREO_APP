#!/bin/bash
echo "==============================="
echo "🛠️ Runner Build Mobile App"
echo "==============================="
echo

process_params() {
    local device=''
    local environment=''

    # Verificar si se ha pasado el parámetro --watch
    while [[ $# -gt 0 ]]; do
        case "$1" in
        --device)
            if [[ -n "$2" && "$2" != --* ]]; then
                device="$2"
                shift 2
            else
                echo "Error: El parámetro --device requiere un valor."
                exit 1
            fi
            ;;
        --environment)
            if [[ -n "$2" && "$2" != --* ]]; then
                environment="$2"
                shift 2
            else
                echo "Error: El parámetro --environment requiere un valor."
                exit 1
            fi
            ;;
        *)
            echo "Parámetro no reconocido: $1"
            exit 1
            ;;
        esac
    done
    # Retornar el valor de watch
    echo "$device $environment"
}

params=$(process_params "$@")
target_device=$(echo "$params" | awk '{print $1}')
environment=$(echo "$params" | awk '{print $2}')
version=$(grep 'version:' pubspec.yaml | sed 's/version: //')
project_app_name=$(grep 'name:' pubspec.yaml | sed 's/name: //')

echo "==============================="
echo "🔧 Varibles configuradas"
echo "Nombre del proyecto: $project_app_name"
echo "Plataforma: $target_device"
echo "Entorno de ejecución: $environment"
echo "Versión de la aplicación: $version"
echo "==============================="
echo

if [[ "$target_device" == "android" ]]; then
    echo "🚀 Contruyendo para Android"
    flutter build appbundle --obfuscate --split-debug-info=./debug-info --dart-define-from-file=config_$environment.json --flavor $environment

    original_file="build/app/outputs/bundle/${environment}Release/app-${environment}-release.aab"
    new_file="build/app/outputs/bundle/${environment}Release/${project_app_name}_v${version//./-}.aab"

    if [[ -f "$original_file" ]]; then
        mv "$original_file" "$new_file"
        green=$(tput setaf 2)
        bold=$(tput bold)
        reset=$(tput sgr0)
        echo "${green}${bold}✓ ${reset}${green}Archivo renombrado a $new_file${reset}"
    else
        echo "Error: El archivo $original_file no se encontró."
        exit 1
    fi
else
    echo "🚧 Plataforma actualmente no soportada."
fi

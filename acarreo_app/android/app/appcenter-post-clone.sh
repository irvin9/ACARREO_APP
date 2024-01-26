#!/usr/bin/env bash
#Place this script in project/android/app/
cd ..

# fail if any command fails
set -e
# debug log
set -x

cd ..
# Crear el contenido del archivo JSON utilizando variables de entorno o sistema
CONFIG_JSON=$(
    cat <<EOF
{
"ENVIRONMENT": "${ENVIRONMENT}",
  "APP_NAME": "${APP_NAME}",
  "APP_BUNDLE": "${APP_BUNDLE}",
  "APP_SUFFIX": "${APP_SUFFIX}",
  "ACARRO_API_HOST_URL": "${ACARRO_API_HOST_URL}",
  "ACARREO_API_VERSION": "${ACARREO_API_VERSION}",
  "FIREBASE_API_KEY_IOS": "${FIREBASE_API_KEY_IOS}",
  "FIREBASE_APP_ID_IOS": "${FIREBASE_APP_ID_IOS}",
  "FIREBASE_API_KEY_ANDROID": "${FIREBASE_API_KEY_ANDROID}",
  "FIREBASE_APP_ID_ANDROID": "${FIREBASE_APP_ID_ANDROID}",
  "FIREBASE_SENDER_ID": "${FIREBASE_SENDER_ID}",
  "FIREBASE_PROJECT_ID": "${FIREBASE_PROJECT_ID}",
  "FIREBASE_STORAGE_BUCKET": "${FIREBASE_STORAGE_BUCKET}"
}
EOF
)

# Guardar el contenido en un archivo config.json
echo "$CONFIG_JSON" >config.json

echo "Archivo config.json creado con éxito."

last_version=$(git describe --match "v[0-9]*.[0-9]*.[0-9]*+[0-9]*" --abbrev=0 --tags)
numberBuild="${last_version#*+}"

if [ "$ENVIRONMENT" == "dev" ]; then
    echo "El actual número de build es: $numberBuild"
    # Verificar si el número es un entero antes de sumar uno
    if [[ $numberBuild =~ ^[0-9]+$ ]]; then
        # Sumar uno al número de build
        newNumberBuild=$((numberBuild + 1))
        # Construir la nueva versión con el nuevo número de build
        newVersion=$(echo $last_version | sed "s/+${numberBuild}/+${newNumberBuild}/")

        # Etiquetar el repositorio Git con la nueva versión
        git checkout develop
        git tag -a "$newVersion" -m "feat: new version app $newVersion"
        git push origin develop --tags
        echo "Versión actualizada y repositorio etiquetado con $newVersion"
    else
        echo "Error: El número de build no es un entero válido."
        exit
    fi
else
    echo "Tag de $ENVIRONMENT -> $last_version"
fi

# Configuración para revertir en caso de error
trap 'handle_error' ERR

# Función para revertir el tag creado y salir con un mensaje de error
handle_error() {
    if [ "$ENVIRONMENT" == "dev" ]; then
        echo "Error detectado. Revertir el tag creado."
        git tag --delete "$newVersion"
        git push origin --delete refs/tags/$newVersion
        exit 1
    else
        echo "Error detectado."
    fi
}

echo "Instalando Flutter"
git clone -b stable https://github.com/flutter/flutter.git
cd flutter
git checkout 3.13.0
cd ..

export PATH=$(pwd)/flutter/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"

flutter doctor
echo "Installed flutter to $(pwd)/flutter"

flutter pub get
exit 0

# Desactivar la configuración de revertir en caso de error después de este punto
trap - ERR

#!/bin/bash

# Directorios necesarios para SonarQube
SONARQUBE_DIRS=(
    "./sonarqube_data"
    "./sonarqube_extensions"
    "./sonarqube_logs"
    "./sonarqube_conf"
    "./postgresql"
    "./posgresql_data"
)

# Crear directorios si no existen
for dir in "${SONARQUBE_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "Created directory: $dir"
    else
        echo "Directory already exists: $dir"
    fi
done

# Establecer permisos de lectura, escritura y ejecución para el propietario, y de lectura y ejecución para los demás
for dir in "${SONARQUBE_DIRS[@]}"; do
    chmod -R 755 "$dir"
    echo "Set permissions 755 for directory: $dir"
done

# Cambiar el propietario de los directorios al usuario con el UID 1000 (usuario predeterminado en muchos contenedores Docker)
for dir in "${SONARQUBE_DIRS[@]}"; do
    sudo chown -R 1000:1000 "$dir"
    echo "Changed ownership to 1000:1000 for directory: $dir"
done
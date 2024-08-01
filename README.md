# A2O-Dev-SonarQube-InOffice
Este repositorio contiene el archivo docker-compose.yaml que permite levantar un servidor de sonarqube utilizando el https://github.com/mc1arke/sonarqube-community-branch-plugin el cual permite el analisis a Branchs y a Pull Requests

## Descripcion de los archivos
- `create_sonarqube_directories.sh`: Script en bash que crea las carpetas necesarias para montar los volumenes utilizados por los contenedores en el archivo docker-compose.yaml
- `docker-compose.yaml`: Archivo que contiene la declaracion de los contenedores Sonarqube y la base de datos PostgreSql

## Requisitos previos
1. Entorno con docker y docker compose instalados
2. Configuraciones descritas en https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/pre-installation/linux/ deben ser realizadas:
    * `sudo sysctl -w vm.max_map_count=524288`
    * `echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf`
    * `sudo sysctl -p`

## Proceso de instalacion
1. Clone el repsoritorio en el servidor 
2. Asegurar los permisos de ejecucion para el archivo 
    * `chmod +x create_sonarqube_directories.sh`
3. Ejecute el script create_sonarqube_directories.sh
    * `./create_sonarqube_directories.sh`
4. Ejecute el archivo docker compose
    * `docker compose up -d`

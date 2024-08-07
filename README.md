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

## ¿Como analizar el código de tu repositorio con github Actions?
1. Verifica que el repositorio de Github en el que te encuentras tenga habilitada la funcion de Actions, ve a tu repositorio:
    * Settings -> Actions (panel de navegacion izquierdo) -> Actions permissions -> Allow all actions and reusable workflows.
2. En la raiz de tu repositorio crea la siguiente carpeta '.github/workflows'
3. En la carpeta .github/workflows que creaste en tu repositorio, crea un archivo .yaml copiando el contenido de .github/workflows/sonar-connections.yaml (de este reposirotiro, opcion como ejemplo, puedes mejorar el archivo para tus requerimientos)
4. Añade las siguientes secrets en las configuraciones de tu repositorio, ve a:
    * Settings -> Secrets and variables (panel de navegacion izquierdo) -> Actions -> pestaña Secrets -> Repository secrets
    * Secrets que deben ser añadidas:
        ```
            
            ## Token de acceso generado en el servidor sonarqube inoffice (solicitarlo al equipo de infra de A2ODev)
            SONAR_TOKEN= _sonar_token

            ## ID de red de la VPN de A2ODev (id zerotier network)
            ZEROTIER_NETWORK_ID=_zerotier_network_id
            
            ## Token de acceso a la VPN de A2odev "Zerotier" (solicitarlo al equipo de infra de A2ODev)
            ZEROTIER_CENTRAL_TOKEN=_zerotier_token
        ```
5. Añade las siguientes varibles en las configuraciones de tu repositorio, ve a:
    * Settings -> Secrets and variables (panel de navegacion izquierdo) -> Actions -> pestaña Variables -> Repository variables
    * Variables que deben ser añadidas:
        ```
        ## Direccion ip del servidor SonarQube inOffice
        SONARQUBE_IP_SERVER=172.29.81.0

        ## Url del servidor SonarQube inOffice
        SONAR_HOST_URL=http://172.29.81.0:9000

        ## key del proyecto (debe ser cambiado con la la key del proyecto que se este trabajando, previamente creado en sonarqube) 
        SONAR_PROJECT_KEY=test
        
        ## Nombre del proyecto (debe ser cambiado con el nombre del proyecto que se este trabajando, previamente creado en sonarquebe) 
        SONAR_PROJECT_NAME=test

        ```

6. Con las configuraciones realizadas, cada cambio que tu realices en la rama 'feature/*', 'develop', y 'main' de tu repositorio sera analizada por el servidor SonarQuebe de A2ODev.
7. Verifica que la ejecucion del Workflow haya concluido sin errores en la ventana de Actions.
8. Revisa los resultados del analisis en http://172.29.81.0:9000 con tus credenciales de acceso.

 
- Any feedback will be apreciated ;)

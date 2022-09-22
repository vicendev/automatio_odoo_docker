#!/bin/bash

# Argumentos para aplicacion Odoo
user_db=$1
pass_db=$2
name_db=$3

## Variables para instanciar base de datos postgres
image_odoo_name=$4
image_odoo_port=$5
image_odoo_volume_data=$6
image_odoo_path_addons=$7

## Variables para instanciar imagen odoo
image_db_name=$8
image_db_volume=$9

## Puede agregar mas argumentos.

## Funcion principal
function main () {

	validarArgumentos
	echo -e "Tengo todos los argumentos\n"
	echo -e "Argumentos para aplicacion: userdb = ${user_db}, passdb = ${pass_db}, namedb = ${name_db}"
	echo -e "Argumentos para imagen app odoo: odoo_image_name = ${image_odoo_name}, odoo_image_port = ${image_odoo_port}"
	echo -e "Argumentos para imagen app odoo: bd_image_name = ${image_db_name}, bd_image_port = ${image_db_port}"
	
	iniciarInstanciaDB
	
	echo -e "Esperando 30 segundos antes de iniciar instancia Odoo..."
	sleep 30 && iniciarInstanciaOdoo
	echo -e "Construccion de imagenes app odoo, finalizado."
	
	sleep 30 && crearArchivoCredenciales	    
	exit 0
}

# Funcion de ocio
function iniciarInstanciaDB () {
	echo -e "Iniciando Instancia Base de datos Postgres..."
	docker run -d -v ${image_db_volume}:/var/lib/postgresql/data -e POSTGRES_USER=${user_db} -e POSTGRES_PASSWORD=${pass_db} -e POSTGRES_DB=${name_db} --name ${image_db_name} postgres:13

}

# Inicia instancia imagen app Odoo
function iniciarInstanciaOdoo () {
	echo -e "Iniciando Instancia App Odoo..."
	docker run -v ${image_odoo_volume_data}:/var/lib/odoo -v ${image_odoo_path_addons}:/mnt/extra-addons -p 8069:${image_odoo_port} --name ${image_odoo_name} --link ${image_db_name}:${image_db_name} -d ${image_odoo_name}
}

# validar argumentos
function validarArgumentos () {
	
	if [ -z "$user_db" ];
	then 
		echo "Usuario DB Vacio" 
		exit 0
	fi
	if [ -z "$pass_db" ];
	then 
		echo "Password DB Vacio" 
		exit 0
	fi
	if [ -z "$name_db" ];
	then 
		echo "Nombre DB Vacio" 
		exit 0
	fi
	if [ -z "$image_odoo_name" ];
	then
		echo "Nombre de Imagen Vacio"
		exit 0
	fi
	if [ -z "$image_odoo_port" ];
	then
		echo "Puerto de Imagen Odoo Vacio"
		exit 0
	fi
	if [ -z "$image_odoo_volume_data" ];
	then
		echo "Volumen Data Imagen Odoo Vacio"
		exit 0
	fi
	if [ -z "$image_odoo_path_addons" ];
	then
		echo "Ruta de Addons Imagen Odoo Vacio"
		exit 0
	fi
	if [ -z "$image_db_name" ];
	then
		echo "Nombre de Imagen Base Datos Vacio"
		exit 0
	fi
	if [ -z "$image_db_volume" ];
	then
		echo "Volumen Imagen Base Datos Vacio"
		exit 0
	fi
}

# mostrar mensaje final
function crearArchivoCredenciales () {
	ODOO_DIR='/' read -r -a array <<< "$image_odoo_path_addons"

	echo -e "Creando archivo con credenciales: ${image_odoo_name}.txt"
	echo "Usuario db = ${user_db}, Password db = ${pass_db}, Nombre db = ${name_db}" > ${ODOO_DIR[0]}/${image_odoo_name}.txt 
}

############################################
### IMPORTANTE Ejemplo de comando docker ###
############################################

## docker run -d -e POSTGRES_USER=${user_db} -e POSTGRES_PASSWORD=${pass_db} -e POSTGRES_DB=${name_db} --name db postgres:13


main user_db pass_db name_db image_odoo_name image_odoo_port image_db_name ## se pasan los argumentos a la funcion principal

### Como usar Script
### ./test.sh argumento1 argumento2 argumento3

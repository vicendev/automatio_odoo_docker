# Script Automatizacion Odoo Docker

#### Variables

> Las siguientes variables son todas necesarias para la utilizacion de este script. es recomendable utilizar las sentencias especificadas según corresponda el argumento para evitar conflictos con el levantamiento de la imagen

##### Varibales:

**Base datos Odoo: **
- user_db: Argumento para nombre de usuario en base de datos Odoo. 	Ejemplo. -> miusuariodb
- pass_db: Argumento para password de usuario en base de datos Odoo. 	Ejemplo. -> mipassword123
- name_db: Argumento para nombre de la base de datos Odoo. 		Ejemplo. -> db_odoo

---
**Imagen App Odoo:**
- image_odoo_name: Argumento para nombrar la imagen docker		Ejemplo. -> odoo_15
- image_odoo_port: Argumento para asignar un puerto al contenedor	Ejemplo. -> 8069
- image_odoo_volume_data: Argumento para asignar un volumen de datos	Ejemplo. -> odoo_vol
- image_odoo_path_addons: Argumento para asignar una ruta de addons	Ejemplo. -> /miempresa/odoo/addons (Debe crear la carpeta previamente antes de asignar una ruta).

---
**Imagen Base Datos:**
- image_db_name: Argumento para nombrar la imagen docker		Ejemplo. -> db_ejemplo
- image_db_volume: Argumneto para asignar un volumen de datos		Ejemplo. -> vol_db_odoo

---
**Como utilizar el script**

run.sh miusuariodb mipassword123 db_odoo odoo_15 8069 odoo_vol /miempresa/odoo/addons db_ejemplo vol_db_odoo




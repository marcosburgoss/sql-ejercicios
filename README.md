# Ejercicios de SQL

Repositorio de ejercicios de SQL realizados durante el primer curso del ciclo **1GS - DAM**.

Incluye scripts para crear distintas bases de datos y ejercicios organizados por nivel y tipo de consulta.

## Contenido

### `bbdd/`

Contiene los scripts de creación e inserción de datos de las bases de datos utilizadas en los ejercicios:

- Biblioteca
- Colegio
- Gestión de empleados
- Gestión de ventas
- Jardinería
- Pokémon
- Tienda de informática
- Universidad
- Videoclub
- Voluntariado

### `consultas/`

Incluye ejercicios básicos y consultas sobre bases de datos concretas:

- Consultas de selección y filtrado
- Consultas de agrupación
- Consultas de acción
- Subconsultas
- Ejercicios con las bases de datos de Videoclub, Voluntariado y Pokémon

### `consultas-avanzadas/`

Contiene ejercicios de consulta avanzada:

- Composiciones internas y externas
- Consultas sobre Tienda, Empleados, Ventas y Jardinería
- Uso de índices

Además, el repositorio incluye el enunciado general [`EJERCICIOS SQL.pdf`](EJERCICIOS%20SQL.pdf) y su versión editable en Word.

## Uso

Los scripts están escritos principalmente para **MySQL/MariaDB**.

1. Abre un cliente de MySQL, como MySQL Workbench o la terminal de MySQL.
2. Ejecuta primero el script de la base de datos que quieras utilizar. Por ejemplo:

   ```sql
   SOURCE bbdd/tienda_de_informatica.sql;
   ```

3. Ejecuta a continuación el archivo de consultas correspondiente.

En sistemas Windows también puedes importar los archivos directamente desde el cliente de base de datos que utilices.

## Uso con Docker

Docker permite crear todas las bases de datos automáticamente y trabajar con ellas sin instalar MySQL directamente en el sistema.

Requisitos:

- Docker Desktop
- Docker Compose

Desde la raíz del repositorio, inicia los contenedores:

```bash
docker compose up -d
```

La primera ejecución puede tardar mientras Docker descarga las imágenes y carga los scripts de `bbdd/`.

Abre Adminer en <http://localhost:8080> con estos datos:

| Campo | Valor |
|---|---|
| Sistema | MySQL |
| Servidor | `mysql` |
| Usuario | `alumno` |
| Contraseña | `alumno1234` |
| Base de datos | Selecciona una base cargada |

También puedes conectarte desde la terminal:

```bash
docker compose exec mysql mysql -ualumno -palumno1234 tienda
```

Para ver las bases de datos disponibles:

```bash
docker compose exec mysql mysql -ualumno -palumno1234 -e "SHOW DATABASES;"
```

Cada vez que ejecutes una consulta:

```sql
USE tienda;
SELECT * FROM producto;
```

Las contraseñas y los puertos pueden modificarse copiando `.env.example` como `.env` antes de iniciar el entorno:

```bash
Copy-Item .env.example .env
```

Comandos útiles:

```bash
# Ver el estado y los logs
docker compose ps
docker compose logs -f mysql

# Detener los contenedores conservando las bases de datos
docker compose stop

# Volver a iniciarlos
docker compose start

# Detener y eliminar los contenedores
docker compose down

# Eliminar también los datos y recrear todas las bases de datos
docker compose down -v
docker compose up -d
```

## Ejemplo

Para trabajar con la base de datos de Tienda:

```sql
SOURCE bbdd/tienda_de_informatica.sql;

USE tienda;
```

Después puedes ejecutar las consultas de [`consultas-avanzadas/1.Tienda_CompExt.sql`](consultas-avanzadas/1.Tienda_CompExt.sql) o [`consultas-avanzadas/1.Tienda_CompInt.sql`](consultas-avanzadas/1.Tienda_CompInt.sql).

## Autor

Ejercicios realizados por **Marcos Burgos**.

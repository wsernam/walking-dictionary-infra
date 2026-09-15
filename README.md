# Walking Dictionary — Infraestructura

Docker Compose para levantar Walking Dictionary en local (backend + frontend + PostgreSQL). Staging y producción se despliegan en Vercel y Render, no con este repositorio.

## ¿Qué es este repositorio?

Este repo **no contiene código de la aplicación**. Solo contiene la orquestación necesaria para levantar el proyecto completo en un entorno de desarrollo local con un solo comando:

- `docker-compose.yml`
- `.env.example`
- Este README

El código de la aplicación vive en dos repositorios separados:

- **Backend:** [enlace al repo de backend]
- **Frontend:** [enlace al repo de frontend]

## Estructura esperada en tu máquina

```
walking-dictionary-infra/     (este repo)
├── docker-compose.yml
├── .env.example
├── .gitignore
├── README.md
├── backend/                  (clonado del repo de backend, no versionado aquí)
│   └── Dockerfile
└── frontend/                 (clonado del repo de frontend, no versionado aquí)
    └── Dockerfile
```

## Requisitos previos

- [Docker Desktop](https://www.docker.com/products/docker-desktop) (incluye Docker Compose)
- [Git](https://git-scm.com/)

Verifica la instalación:

```bash
docker --version
docker compose version
git --version
```

## Cómo empezar

1. Clonar este repositorio:

   ```bash
   git clone https://github.com/tu-org/walking-dictionary-infra.git
   cd walking-dictionary-infra
   ```

2. Clonar backend y frontend dentro de esta carpeta (rama `develop`):

   ```bash
   git clone -b develop https://github.com/tu-org/backend.git
   git clone -b develop https://github.com/tu-org/frontend.git
   ```

3. Copiar `.env.example` a `.env` y completar los valores:

   ```bash
   cp .env.example .env
   ```

4. Levantar todo:

   ```bash
   docker compose up --build
   ```

5. Abrir:
   - Frontend: [http://localhost:3000](http://localhost:3000)
   - Backend (API): [http://localhost:5000](http://localhost:5000)

6. Para apagar:

   ```bash
   docker compose down
   ```

## Servicios que levanta Docker Compose

| Servicio  | Descripción                                  | Puerto |
|-----------|-----------------------------------------------|--------|
| `db`      | PostgreSQL, con datos persistentes en volumen | 5432   |
| `backend` | API en Node.js / Express                      | 5000   |
| `frontend`| Aplicación en React                           | 3000   |

## Ambientes

| Ambiente     | Frontend               | Backend               | Base de datos          |
|--------------|-------------------------|-------------------------|--------------------------|
| Desarrollo   | Docker Compose (local)  | Docker Compose (local)  | PostgreSQL en contenedor |
| Staging      | Vercel (preview deploy) | Render (staging)        | Supabase (proyecto de staging) |
| Producción   | Vercel (rama `main`)    | Render (producción)     | Supabase (proyecto de producción) |

> Este repositorio y el `docker-compose.yml` solo aplican al ambiente de **desarrollo local**. Staging y producción no usan Docker Compose.

## Buenas prácticas

- Nunca subir el archivo `.env` con valores reales (está en `.gitignore`). Solo se versiona `.env.example`.
- Después de instalar una dependencia nueva en backend o frontend (`npm install algo`), reconstruir con `docker compose up --build` para que quede reflejada en la imagen.
- Los cambios de código sí se reflejan en caliente gracias a los volúmenes montados; solo hace falta reconstruir cuando cambian dependencias.
- La rama `main` de este repositorio está protegida: los cambios se hacen mediante Pull Request con al menos una revisión.
- Quien tenga el rol DevOps/QA en el sprint es responsable de mantener actualizados el `docker-compose.yml` y este README.

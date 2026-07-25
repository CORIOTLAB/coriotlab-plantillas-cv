# Manual de Usuario — Plantilla Hoja de Vida CORIOTLAB

Guía paso a paso para llenar y compilar su hoja de vida, pensada para quien no tiene
experiencia previa con LaTeX.

---

## 1. Antes de empezar

Necesita:

1. **Windows 10 u 11.**
2. **MiKTeX** instalado (incluye XeLaTeX). Si no lo tiene:
   [https://miktex.org/download](https://miktex.org/download) — durante la instalación,
   seleccione *"Install missing packages on-the-fly" = Yes*.
3. Haber ejecutado **una vez** el script de configuración, desde la raíz del repositorio:

   ```powershell
   .\setup_coriotlab.ps1
   ```

   Esto instala las tres tipografías de la marca (Inter, MuseoModerno, Space Mono) y
   verifica que XeLaTeX esté disponible. No necesita conexión a internet: las fuentes se
   toman directamente del Kit de Marca incluido en este proyecto.

---

## 2. Copiar la plantilla

**No edite `plantilla/plantilla_hoja_de_vida.tex` directamente.** Cópielo a la carpeta
donde va a trabajar:

```powershell
Copy-Item "plantilla\plantilla_hoja_de_vida.tex" "C:\MiCarpeta\HV_MiNombre.tex"
```

Si copia el archivo a una carpeta que **no** está dentro de este repositorio, debe ajustar
la ruta del logo (ver sección 7 más abajo) porque la plantilla usa una ruta relativa al
Kit de Marca.

---

## 3. Llenar la Zona de Configuración

Abra el `.tex` copiado en cualquier editor de texto (Bloc de notas, VS Code, TeXstudio,
Overleaf...). Las primeras ~35 líneas son la **Zona de Configuración**:

```latex
\newcommand{\CVNombre}{Nombre Apellido}
\newcommand{\CVTitulo}{Ingeniero(a) Electrónico(a) / Investigador(a) en Robótica}
\newcommand{\CVCorreo}{correo@ejemplo.com}
\newcommand{\CVTelefono}{+57 300 000 0000}
\newcommand{\CVCiudad}{Medellín, Colombia}
\newcommand{\CVLinkedIn}{}       % opcional
\newcommand{\CVORCID}{}          % opcional
\newcommand{\CVGitHub}{}         % opcional
\newcommand{\CVGoogleScholar}{}  % opcional
\newcommand{\CVResearchGate}{}   % opcional
\newcommand{\CVFecha}{Julio de 2026}
```

Reemplace el texto entre llaves `{ }` con su información. Para los campos marcados
*opcional* (LinkedIn, ORCID, GitHub, Google Scholar, ResearchGate):

- Si no aplica, déjelo vacío: `\newcommand{\CVLinkedIn}{}`
- Si aplica, escriba la **URL completa**: `\newcommand{\CVLinkedIn}{https://www.linkedin.com/in/usuario}`
- Para ORCID, escriba **solo el identificador** (sin URL): `\newcommand{\CVORCID}{0000-0000-0000-0000}`

La plantilla arma automáticamente la línea de "Redes" con los campos que sí llenó, y la
omite por completo si los deja todos vacíos.

---

## 4. Llenar cada sección

Busque cada sección en el documento (están marcadas con comentarios `%% ═══`) y
reemplace el texto entre corchetes `[ ]` con su información real. **No borre los
corchetes por error de otro texto** — son solo un marcador visual, bórrelos junto con el
texto de ejemplo.

### 4.1 Perfil Profesional (opcional)

Un párrafo de 3 a 5 líneas. Si no lo quiere usar, comente todo el bloque poniendo `%` al
inicio de cada línea, desde `\SeccionCV{Perfil Profesional}` hasta el final del párrafo.

### 4.2 Formación Académica

Cada estudio usa este patrón:

```latex
\ItemCV{Nombre del programa}{2023 -- en curso}
Institución\quad\NivelFormacion{Maestría}\quad\FormacionEnCurso
```

- **Primer parámetro de `\ItemCV`:** nombre del programa (aparece en negrita, izquierda).
- **Segundo parámetro:** fechas (aparece a la derecha).
- **`\NivelFormacion{...}`:** escriba uno de estos niveles: `Técnico/Tecnólogo`,
  `Pregrado`, `Especialización`, `Maestría`, `Doctorado`, `Postdoctorado`.
- **Estado:** use `\FormacionEnCurso` o `\FormacionCulminada` según corresponda.

Para agregar más estudios, copie y pegue el bloque completo (las 2 líneas) y edítelo.

### 4.3 Experiencia Certificada

```latex
\ItemCV{Cargo desempeñado}{Enero 2023 -- Actualidad}
Empresa o institución\quad\Certificado
\begin{itemize}
  \item{} Función o logro concreto.
  \item{} Segunda función o logro.
\end{itemize}
```

Use `\Certificado` si tiene soporte documental (certificación laboral, contrato, etc.) o
`\NoCertificado` si no lo tiene.

> **Importante:** cada `\item` debe llevar `{}` inmediatamente después (sin espacio), es
> decir `\item{} Texto...` y no `\item Texto...`. Si el texto del ítem empieza con `[`,
> LaTeX puede confundirlo con una opción del propio `\item` y desordenar el documento. El
> `{}` evita ese problema — no lo quite al editar.

### 4.4 Certificaciones

```latex
\ItemCV{Nombre del curso o certificación}{Marzo de 2024}
Entidad emisora\quad{\FuenteCodigo\small\color{GrisMedio}Código de verificación}
```

Si no tiene código de verificación, borre esa segunda parte y deje solo la entidad.

### 4.5 Publicaciones (formato APA 7)

```latex
\Publicacion{Apellido, N. A., y Apellido, N. B.}{2024}%
  {Título del artículo en formato de oración normal}%
  {Nombre de la Revista}{12(3), 45--60}%
  {https://doi.org/xx.xxxx/xxxxxxx}
```

Los 6 parámetros son: **autores**, **año**, **título**, **fuente** (revista/editorial),
**volumen(número), páginas**, y **DOI o URL**. Los dos últimos son opcionales — deje `{}`
si no aplican, por ejemplo para un libro sin volumen:

```latex
\Publicacion{Apellido, N. A.}{2023}{Título del libro}{Editorial}{}{}
```

El orden de aparición es manual: para reordenar sus publicaciones, simplemente mueva los
bloques `\Publicacion{...}` de lugar en el documento (por ejemplo, más recientes primero).

### 4.6 Congresos y Ponencias

```latex
\Ponencia{Título de la ponencia}%
  {Nombre del congreso o evento}%
  {Ponente}{Ciudad, País}{Octubre de 2024}
```

El tercer parámetro es el tipo de participación: `Ponente`, `Póster`, `Asistente`, etc.

---

## 5. Secciones opcionales adicionales

Al final del documento hay tres bloques completamente comentados (cada línea empieza con
`%`): **Idiomas**, **Habilidades Técnicas**, y **Software y Herramientas**. Para
activarlos, quite el `%` del inicio de cada línea del bloque que le interese y llene los
datos.

---

## 6. Compilar

### Opción A — Comandos directos

Desde la carpeta donde está su `.tex`:

```powershell
xelatex -interaction=nonstopmode HV_MiNombre.tex
xelatex -interaction=nonstopmode HV_MiNombre.tex
```

Sí, **dos veces** — la primera pasada resuelve los hipervínculos y referencias internas;
la segunda los incorpora correctamente al PDF.

### Opción B — Script incluido

Si trabaja dentro de este repositorio:

```powershell
.\compile.ps1 plantilla
.\compile.ps1 ejemplo
.\compile.ps1 todos
```

El script compila con doble pasada automáticamente y le avisa si el PDF se generó (o si
falló y por qué).

---

## 7. Si copió el `.tex` fuera de este repositorio

La plantilla incluye el logo con una ruta relativa:

```latex
\includegraphics[width=0.85\linewidth]%
  {../705_Kit de Marca Coriotlab/2. Logos/2. Logo Full Color/2. Horizontal/Coriotlab_Logo_Hor_FullColor.png}
```

Esa ruta (`../705_Kit de Marca Coriotlab/...`) solo funciona si su `.tex` está un nivel
adentro de la raíz del repositorio (como `plantilla/` o `ejemplos/`). Si lo movió a otra
carpeta, cambie esa línea por la ruta correcta hacia el Kit de Marca, por ejemplo con una
ruta absoluta:

```latex
{C:/CORIOTLAB/PLANTILLA HOJA DE VIDA/705_Kit de Marca Coriotlab/2. Logos/2. Logo Full Color/2. Horizontal/Coriotlab_Logo_Hor_FullColor.png}
```

---

## 8. Solución de problemas

| Problema | Causa probable | Solución |
|---|---|---|
| `Font cannot be found` | Fuentes no instaladas | Ejecute `.\setup_coriotlab.ps1`, reinicie PowerShell |
| El PDF no se actualiza al compilar | El PDF está abierto en un visor | Cierre el visor (Adobe, PDFgear, Edge, etc.) y compile de nuevo |
| El logo no aparece | Ruta relativa rota | Ver sección 7 de este manual |
| Los ítems de una lista se desordenan o el texto se sale del margen | Falta el `{}` después de `\item` | Revise que sea `\item{} Texto`, no `\item Texto` |
| Aparece "major issue: User/administrator updates are out-of-sync" pero el PDF sí se genera | Advertencia de MiKTeX, normalmente inofensiva | Verifique la fecha de modificación del PDF; si es reciente, la compilación fue exitosa |
| `dvipdfmx:fatal: Invalid font` y el PDF no se genera | Conflicto de fuentes duplicadas en Windows (dos versiones de la misma familia instaladas) | Vuelva a ejecutar `.\setup_coriotlab.ps1` — ya no reinstala fuentes que produzcan este conflicto. Si persiste, revise en el Panel de Control → Fuentes si hay entradas repetidas de Inter/MuseoModerno y elimine las que no coincidan con el nombre `NombreFuente-Peso.ttf` |

---

## 9. Preguntas frecuentes

**¿Puedo usar otro membrete de color en vez del logo?**
Sí. La carpeta `Membretes CoriotLab/Membrete formato imagen/` tiene 4 variantes de color.
Esta plantilla no usa el membrete de fondo completo por defecto (ver README, sección
"Logos y membretes"), pero puede adaptarlo siguiendo el ejemplo de `plantilla_tecnico.tex`
del repositorio de informes si lo prefiere.

**¿Mi CV puede tener más de una página?**
Sí, sin problema. La plantilla no fuerza una sola página; el pie de página numera
automáticamente si el contenido crece.

**¿Cómo cambio el orden de las secciones?**
Cada sección está delimitada por comentarios `%% ═══`. Puede cortar y pegar el bloque
completo (desde el comentario hasta el contenido) para reordenarlo.

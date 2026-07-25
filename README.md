<div align="center">

# CORIOTLAB · Plantilla de Hoja de Vida

**Laboratorio de Control, Robótica e Internet de las Cosas**
Instituto Tecnológico Metropolitano — ITM, Medellín, Colombia

---

[![XeLaTeX](https://img.shields.io/badge/XeLaTeX-requerido-2C6EAA?style=flat-square&logo=latex&logoColor=white)](https://miktex.org/)
[![MiKTeX](https://img.shields.io/badge/MiKTeX-26.5+-0078D4?style=flat-square&logo=windows&logoColor=white)](https://miktex.org/download)
[![Versión](https://img.shields.io/badge/versión-1.0.0-102D69?style=flat-square)](CHANGELOG.md)
[![Licencia](https://img.shields.io/badge/uso-CORIOTLAB%20ITM-C14894?style=flat-square)](mailto:info@coriotlab.co)

</div>

---

Plantilla LaTeX oficial de **Hoja de Vida (CV)** del Laboratorio CORIOTLAB, con la misma
identidad visual (colores, tipografías, estilo de Zona de Configuración) que el repositorio
hermano [`coriotlab-plantillas-informes`](../INFORMES). Pensada para investigadores,
docentes y estudiantes de ingeniería que necesiten un CV técnico-investigativo: formación
con niveles y estado, experiencia certificada, certificaciones, publicaciones en formato
APA 7 y congresos/ponencias.

**Sin fotografía** — es una instrucción explícita del encargo: la plantilla funciona
completa sin imagen del titular.

---

## Inicio rápido

### Paso 1 — Preparar el sistema (una sola vez por computador)

```powershell
.\setup_coriotlab.ps1
```

Instala **Inter**, **MuseoModerno** y **Space Mono** directamente desde el Kit de Marca
incluido en este proyecto (no requiere conexión a internet) y verifica que XeLaTeX esté
disponible.

### Paso 2 — Copiar la plantilla

```powershell
Copy-Item "plantilla\plantilla_hoja_de_vida.tex" "C:\MiCarpeta\HV_MiNombre.tex"
```

**No edite el archivo original.** Trabaje siempre sobre una copia.

### Paso 3 — Editar y compilar

Abra el `.tex` copiado, complete la **Zona de Configuración** (primeras ~35 líneas), llene
las secciones, y compile con doble pasada:

```powershell
xelatex -interaction=nonstopmode HV_MiNombre.tex
xelatex -interaction=nonstopmode HV_MiNombre.tex
```

O use el script incluido desde la raíz del repositorio:

```powershell
.\compile.ps1 plantilla    # plantilla base
.\compile.ps1 ejemplo      # ejemplo lleno de referencia
.\compile.ps1 todos        # ambos
```

> **¿Por qué doble pasada?** La primera resuelve los hipervínculos y referencias; la
> segunda los incorpora correctamente al PDF final.

---

## Ejemplo de referencia

Antes de empezar, revise **[`ejemplos/hoja_de_vida_ejemplo_completa.tex`](ejemplos/hoja_de_vida_ejemplo_completa.tex)**
(y su [PDF](ejemplos/hoja_de_vida_ejemplo_completa.pdf)): es un CV real, lleno con la
información profesional de un investigador del ITM, que muestra las 8 secciones en uso
con datos reales.

---

## Zona de Configuración

Al inicio del `.tex`, primeras ~35 líneas:

```latex
\newcommand{\CVNombre}{Nombre Apellido}
\newcommand{\CVTitulo}{Ingeniero(a) Electrónico(a) / Investigador(a) en Robótica}
\newcommand{\CVCorreo}{correo@ejemplo.com}
\newcommand{\CVTelefono}{+57 300 000 0000}
\newcommand{\CVCiudad}{Medellín, Colombia}
\newcommand{\CVLinkedIn}{}       % opcional — URL completa
\newcommand{\CVORCID}{}          % opcional — solo el identificador
\newcommand{\CVGitHub}{}         % opcional — URL completa
\newcommand{\CVGoogleScholar}{}  % opcional — URL completa
\newcommand{\CVResearchGate}{}   % opcional — URL completa
\newcommand{\CVFecha}{Julio de 2026}
```

Todos los campos marcados como *opcional* se pueden dejar vacíos (`{}`): la plantilla los
omite automáticamente de la línea de contacto/redes, sin dejar separadores sueltos.

---

## Estructura del documento

| # | Sección | ¿Obligatoria? | Contenido |
|---|---|---|---|
| — | Encabezado | Sí | Nombre, título, contacto, redes, logo horizontal |
| 1 | Perfil Profesional | Opcional (bloque comentado) | Párrafo de 3–5 líneas |
| 2 | Formación Académica | Sí | Programa, institución, nivel + estado, fechas |
| 3 | Experiencia Certificada | Sí | Cargo, entidad, periodo, funciones, indicador de certificación |
| 4 | Certificaciones | Sí | Curso/certificación, entidad, fecha, código de verificación |
| 5 | Publicaciones | Sí | Formato APA 7 vía `\Publicacion{}` |
| 6 | Congresos y Ponencias | Sí | Formato de cita breve vía `\Ponencia{}` |
| — | Idiomas | Opcional (bloque comentado) | Nivel de dominio por idioma |
| — | Habilidades Técnicas | Opcional (bloque comentado) | Stack tecnológico, herramientas |
| — | Software y Herramientas | Opcional (bloque comentado) | Lista de software con nivel de dominio |

Cada bloque está delimitado con comentarios `%% ═══` para que sea fácil comentar/activar
sin borrar contenido, siguiendo el mismo criterio que `plantilla_tecnico.tex` del repo de
informes.

---

## Sistema de etiquetas

### Nivel de formación académica

```latex
\NivelFormacion{Maestría}   % Técnico/Tecnólogo · Pregrado · Especialización
                              % Maestría · Doctorado · Postdoctorado
\FormacionEnCurso            % azul — estudio en curso
\FormacionCulminada          % verde — estudio culminado
```

### Certificación

```latex
\Certificado      % verde — respaldado por soporte documental
\NoCertificado     % gris — sin certificar
```

Ambas familias reutilizan la misma paleta y el mismo estilo de "píldora" (`\colorbox` +
`\strut`) que los estados `\Estado...` del repo de informes.

---

## Decisión técnica: publicaciones en formato APA

Se implementó la **Opción A** (recomendada por el encargo original): un comando
determinístico `\Publicacion{}` en LaTeX puro, **sin biblatex/biber ni archivo `.bib`
externo**:

```latex
\Publicacion{Autores}{Año}{Título}{Fuente en cursiva}%
            {Volumen(Número), páginas}{DOI o URL}
```

Deje `{}` vacío en el 5.º o 6.º parámetro si no aplica. El orden de aparición es manual:
para reordenar (cronológico o alfabético), simplemente reordene las llamadas en el
documento.

**Por qué no biblatex+biber (Opción B):** agregaría una dependencia nueva (el ejecutable
`biber`) al flujo de compilación, que hoy es solo XeLaTeX de doble pasada, y el público
objetivo (ingenieros, no siempre familiarizados con BibTeX) se beneficia más de un comando
con parámetros nombrados. El comando está organizado con sangría francesa correcta para
que migrar a `biblatex-apa` en el futuro sea sencillo si el laboratorio lo necesita.

El mismo criterio (comando estructurado, sin bibliografía externa) se usa para
**Congresos y Ponencias** vía `\Ponencia{}`, con un formato de cita breve.

---

## Logos y membretes — qué usar y cuándo

Este proyecto **no genera copias** de los logos ni membretes: los usa directamente desde
las carpetas ya incluidas.

### Logo (carpeta `705_Kit de Marca Coriotlab/2. Logos/`)

| Variante | Ruta | Cuándo usar |
|---|---|---|
| Horizontal Full Color | `2. Logo Full Color/2. Horizontal/Coriotlab_Logo_Hor_FullColor.png` | **Por defecto en el encabezado del CV** (fondo blanco/claro) |
| Horizontal White Color | `2. Logo Full Color/2. Horizontal/Coriotlab_Logo_Hor_WhiteColor.png` | Si se agrega algún bloque de fondo sólido oscuro |
| Horizontal Monocromático Negro | `3. Logo Monocromático/Coriotlab_Logo_Hor_Black.png` | Impresión en blanco y negro estricta |
| Isotipo Full Color | `2. Logo Full Color/1. Isotipo/Coriotlab_Isotipo_FullColor.png` | Elemento decorativo pequeño, si se necesita |

La plantilla usa la variante **Horizontal Full Color** en el encabezado de la primera
página, en tamaño reducido y con menor jerarquía visual que el nombre del titular, tal
como exige el Libro de Marca.

### Membretes (carpeta `Membretes CoriotLab/Membrete formato imagen/`)

| Archivo | Color | HEX | Cuándo usar |
|---|---|---|---|
| `membrete_azul.png` | AzulITM | `#102D69` | Documentos estándar |
| `membrete_celeste.png` | AzulDigital | `#56ACDE` | Proyectos IoT o conectividad |
| `membrete_gris.png` | GrisPizarra | `#2F2F2F` | Documentos formales o neutros |
| `membrete_magenta.png` | Magenta | `#C14894` | Proyectos de robótica |

**Decisión de diseño — por qué esta plantilla NO usa el membrete de fondo a página
completa** (a diferencia de los informes, que aplican `membrete_azul.png` a 40% de
opacidad en todo el documento): ese formato está pensado para reportes con prosa y
espacio en blanco; en una hoja de vida —densa en tablas y listas— un watermark central
compite con el contenido y reduce el contraste en blanco y negro. En su lugar, el
encabezado usa el logo horizontal en alta resolución y el pie de página es una regla +
fecha + número de página construidos en LaTeX con los mismos tokens de color.

Si de todas formas prefiere el look de los informes (membrete de fondo completo), puede
adaptarlo desde `plantilla_tecnico.tex` del repo hermano: agregue `eso-pic` y
`\AddToShipoutPictureBG` apuntando a la ruta del membrete deseado.

---

## Identidad visual

### Paleta de colores

| Token | HEX | RGB | Uso |
|---|---|---|---|
| `AzulITM` | `#102D69` | 16, 45, 105 | Nombre, títulos de sección, acentos institucionales |
| `Magenta` | `#C14894` | 193, 72, 148 | Acentos de robótica / certificaciones destacadas |
| `AzulDigital` | `#56ACDE` | 86, 172, 222 | Enlaces, reglas de sección, acentos IoT |
| `GrisPizarra` | `#2F2F2F` | 47, 47, 47 | Texto de cuerpo principal |
| `GrisClaro` | `#F5F5F5` | 245, 245, 245 | Fondos de bloque |
| `GrisMedio` | `#888888` | 136, 136, 136 | Fechas, metadatos, etiquetas secundarias |
| `GrisLinea` | `#DDDDDD` | 221, 221, 221 | Separadores y bordes |
| `VerdeTarea` | `#1A6B3C` | 26, 107, 60 | Indicador "Certificado" / "Culminado" |

### Tipografías

| Fuente | Uso |
|---|---|
| **MuseoModerno** | Nombre del titular, títulos de sección |
| **Inter** | Todo el cuerpo de texto |
| **Space Mono** | Fechas, códigos de certificación, ORCID, DOI |

Compilación **obligatoria con XeLaTeX** (nunca pdfLaTeX/LuaLaTeX).

---

## Requisitos del sistema

| Componente | Requisito | Notas |
|---|---|---|
| Sistema operativo | Windows 10 / 11 | Scripts PowerShell |
| Compilador LaTeX | XeLaTeX (incluido en MiKTeX) | Nunca usar pdfLaTeX |
| Distribución LaTeX | MiKTeX 26.5+ | [miktex.org/download](https://miktex.org/download) |
| Fuentes | Inter · MuseoModerno · Space Mono | Instalar con `setup_coriotlab.ps1` (offline, desde el Kit de Marca) |

---

## Estructura del repositorio

```
PLANTILLA HOJA DE VIDA/
│
├── 705_Kit de Marca Coriotlab/    ← Manual de marca (PDF) + logos + tipografías
├── Membretes CoriotLab/           ← Membretes PNG (4 variantes de color)
│
├── plantilla/
│   ├── plantilla_hoja_de_vida.tex ← archivo principal, copiar y editar
│   └── plantilla_hoja_de_vida.pdf ← PDF de referencia
│
├── ejemplos/
│   ├── hoja_de_vida_ejemplo_completa.tex  ← ejemplo con datos reales
│   └── hoja_de_vida_ejemplo_completa.pdf
│
├── docs/
│   └── MANUAL_USUARIO.md          ← guía paso a paso
│
├── compile.ps1                     ← compilar (doble pasada automática)
├── setup_coriotlab.ps1             ← instalar fuentes (offline)
├── README.md
├── CHANGELOG.md
└── .gitignore
```

---

## Solución de problemas frecuentes

<details>
<summary><strong>El PDF se genera pero con exit code distinto de 0</strong></summary>

MiKTeX puede mostrar advertencias (`"So far, you have not checked for updates"` o
`"User/administrator updates are out-of-sync"`) que devuelven un exit code distinto de 0
aunque el PDF se haya generado correctamente. Abra el PDF — si existe y tiene fecha de
modificación reciente, la compilación fue exitosa. `compile.ps1` ya verifica esto por
usted (compara la fecha del PDF antes/después de compilar, no el exit code).

</details>

<details>
<summary><strong>El PDF no se actualiza al compilar, sin ningún error visible</strong></summary>

Si tiene el PDF abierto en un visor (PDFgear, Adobe Reader, Edge, etc.), Windows bloquea
el archivo para escritura y `dvipdfmx` falla silenciosamente con
`"Unable to open ....pdf"` — xelatex termina con advertencia pero **no genera el nuevo
PDF**. Cierre el visor y vuelva a compilar.

</details>

<details>
<summary><strong>Error: "Font cannot be found"</strong></summary>

Las fuentes no están instaladas en Windows. Ejecute desde la raíz del repositorio:

```powershell
.\setup_coriotlab.ps1
```

Luego cierre y reabra PowerShell antes de compilar.

</details>

<details>
<summary><strong>El logo no aparece en el PDF</strong></summary>

La ruta relativa `../705_Kit de Marca Coriotlab/...` solo funciona cuando el `.tex` está
en `plantilla/` o `ejemplos/`. Si copió el `.tex` a otra carpeta, cambie la ruta del
`\includegraphics` por la ruta absoluta o relativa correcta hacia el Kit de Marca.

</details>

---

## Manual de usuario completo

Para instrucciones detalladas paso a paso (incluyendo cómo agregar/quitar publicaciones y
ponencias), consulte el **[Manual de Usuario](docs/MANUAL_USUARIO.md)**.

---

<div align="center">

**Laboratorio CORIOTLAB — Instituto Tecnológico Metropolitano**
Medellín, Colombia · [info@coriotlab.co](mailto:info@coriotlab.co)

</div>

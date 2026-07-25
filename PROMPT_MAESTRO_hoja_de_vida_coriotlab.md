# PROMPT MAESTRO — Desarrollo de Plantilla LaTeX "Hoja de Vida CORIOTLAB"

> Copia todo el contenido de este archivo y pégalo como instrucción inicial a Claude Code
> dentro de la carpeta `C:\CORIOTLAB\PLANTILLA HOJA DE VIDA`.

---

## 0. ROL Y CONTEXTO

Actúas como desarrollador LaTeX senior especializado en diseño editorial e identidad de marca.
Vas a construir, de principio a fin, una **plantilla LaTeX profesional de Hoja de Vida (CV)**
para el **Laboratorio CORIOTLAB** (Control, Robótica e IoT — Instituto Tecnológico
Metropolitano, ITM, Medellín, Colombia).

Este proyecto es hermano de un repositorio previo ya existente:
`coriotlab-plantillas-informes` (Informe de Actividades + Informe Técnico + Presentación).
La hoja de vida debe **sentirse de la misma familia visual** que esos documentos: mismos
colores, mismas tipografías, mismo estilo de "Zona de Configuración" al inicio del `.tex`,
mismo criterio de secciones opcionales comentadas, mismos scripts de compilación en
PowerShell. No es un proyecto visualmente aislado — es la cuarta pieza de un mismo sistema
de identidad.

**Carpeta de trabajo local:** `C:\CORIOTLAB\PLANTILLA HOJA DE VIDA`
**Destino final:** cuando el desarrollo esté validado y funcional, se publicará como
repositorio nuevo e independiente en GitHub (instrucciones en la Fase 6).

### 0.1 Assets ya existentes en la ruta de trabajo — REVISAR ANTES DE EMPEZAR

Dentro de `C:\CORIOTLAB\PLANTILLA HOJA DE VIDA` ya existen dos carpetas con material
oficial que **debes inspeccionar primero** (`view`/listar su contenido) antes de crear
nada nuevo, en vez de asumir su estructura:

1. **Carpeta del kit de marca** — contiene el Libro de Marca (manual de marca en PDF) y
   los **archivos de logo** en sus distintas variantes (full color, monocromático blanco,
   monocromático negro, versión horizontal, versión vertical, isotipo solo, etc.).
   Revisa todos los archivos disponibles y **decide cuál variante de logo usar según el
   caso de uso dentro del CV**, aplicando las reglas de "Usos correctos del logo" del
   manual (sección 3 de este prompt):
   - Sobre fondo blanco/claro (caso por defecto del CV) → versión full color o
     monocromática negra, según el contexto (ver 3.3 más abajo).
   - Si en algún bloque decorativo usas un fondo de color sólido de la paleta → usar la
     variante del logo en blanco.
   - Nunca uses una variante pensada para fondo oscuro sobre un documento de fondo claro,
     ni viceversa.
   - Usa el archivo de logo **tal cual existe** (no lo redibujes ni lo recrees en LaTeX/TikZ)
     salvo que ningún archivo disponible cubra el caso necesario.
2. **Carpeta de membretes** — contiene los membretes PNG ya diseñados (variantes de color:
   azul, celeste, gris, magenta — igual que en el repo de informes). **Reutiliza estos
   archivos directamente**, no los copies desde el repositorio de informes ni los
   regeneres. Usa `membrete_azul.png` (AzulITM) como variante por defecto para la hoja de
   vida, salvo que el usuario pida otra al momento de llenar la plantilla.

Antes de escribir el `.tex`, lista el contenido exacto de ambas carpetas y **documenta en
el README qué archivo corresponde a qué variante/uso**, para que quien edite el CV sepa
cuál lograr sin tener que abrir el PDF del manual de marca cada vez.

---

## 1. PÚBLICO Y PROPÓSITO DEL DOCUMENTO

- **Público objetivo:** ingenieros, investigadores, docentes y estudiantes de ingeniería
  (electrónica, mecatrónica, sistemas, automatización, afines).
- **Tono:** profesional, técnico, orientado a investigación — no es un CV "creativo" de
  diseño gráfico ni un CV comercial/comprensivo de RRHH genérico. Debe transmitir
  rigurosidad académica y solidez técnica.
- **Uso típico:** postulación a semilleros, becas, convocatorias de investigación,
  proyectos con la industria, procesos de vinculación docente/investigativa, perfiles
  para propuestas técnicas ante clientes.

---

## 2. REQUISITOS DE CONTENIDO (obligatorios — vienen del encargo original)

La plantilla debe permitir capturar y presentar, de forma ordenada y editable, la
siguiente información. Estructúrala como secciones del documento:

1. **Datos de identificación y contacto** (nombre, título profesional/rol, correo,
   teléfono, ciudad, LinkedIn/ORCID/GitHub si aplica — *campos opcionales individuales*).
2. **SIN FOTOGRAFÍA.** No incluir placeholder de foto en ningún punto de la plantilla.
   Esto es una instrucción explícita y no negociable — el diseño de portada/encabezado debe
   funcionar completo sin imagen de la persona.
3. **Perfil / Resumen profesional** — párrafo breve (3–5 líneas) opcional.
4. **Formación académica**, indicando claramente el **nivel** de cada estudio y su estado.
   Debe existir un sistema de etiquetas de nivel (ver sección 4) — ej.: Pregrado,
   Especialización, Maestría, Doctorado — y de estado (en curso / completado).
5. **Experiencia certificada** — experiencia laboral o de investigación respaldada por
   certificación (empresa/institución, cargo, periodo, funciones/logros, y un indicador
   visual de "certificada").
6. **Certificaciones** (cursos, diplomados, certificaciones técnicas — con entidad emisora,
   fecha y, si aplica, código/enlace de verificación).
7. **Publicaciones** — deben listarse **en formato de cita APA 7ª edición**, para que la
   sección se vea ordenada y sea directamente reutilizable en hojas de vida institucionales
   (CvLAC, currículum de convocatorias, etc.). Ver especificación técnica en sección 5.
8. **Ponencias / Participación en congresos y eventos científicos** (nombre del evento,
   tipo de participación — ponente, póster, asistente —, lugar, fecha).
9. **Formación complementaria opcional según el CV** (idiomas, habilidades técnicas /
   stack tecnológico, software, herramientas de laboratorio) — sección opcional, no fue
   pedida explícitamente pero es estándar en un CV técnico-investigativo; inclúyela como
   **bloque opcional comentado**, no obligatorio.

**Todas las secciones deben ser modulares y opcionales de activar/desactivar**, siguiendo
exactamente el mismo patrón que ya usa `plantilla_tecnico.tex` con sus bloques
`%% === OPT-A ===` etc. Nadie debe tener que borrar contenido: solo comentar/descomentar
bloques y llenar campos.

---

## 3. IDENTIDAD VISUAL OBLIGATORIA (Libro de Marca CORIOTLAB, v. 17-jul-2025)

Todo el diseño debe cumplir estrictamente el manual de marca adjunto. Resumen técnico ya
extraído para tu implementación:

### 3.1 Paleta de colores (usar los mismos tokens ya definidos en el repo de informes)

| Token         | HEX       | RGB           | Uso en la hoja de vida                                   |
|---------------|-----------|---------------|------------------------------------------------------------|
| `AzulITM`     | `#102D69` | 16, 45, 105   | Nombre, títulos de sección, líneas de acento institucional |
| `Magenta`     | `#C14894` | 193, 72, 148  | Acentos de "Robótica" / certificaciones destacadas          |
| `AzulDigital` | `#56ACDE` | 86, 172, 222  | Enlaces, iconos de contacto, acentos "IoT"                  |
| `GrisPizarra` | `#2F2F2F` | 47, 47, 47    | Texto de cuerpo principal                                   |
| `GrisClaro`   | `#F5F5F5` | 245, 245, 245 | Fondos de bloque, filas alternas de tablas                  |
| `GrisMedio`   | `#888888` | 136, 136, 136 | Fechas, metadatos, etiquetas secundarias                    |
| `GrisLinea`   | `#DDDDDD` | 221, 221, 221 | Separadores y bordes                                        |
| `VerdeTarea`  | `#1A6B3C` | 26, 107, 60   | Reutilizar para indicador "Certificado / Verificado"         |

No inventes colores nuevos. Si necesitas un color adicional para el sistema de "nivel
académico" (sección 4), derívalo por variación de opacidad/tint de estos mismos tokens, no
introduzcas una paleta paralela.

### 3.2 Tipografías (idénticas al resto del sistema)

| Fuente         | Uso en la hoja de vida                                   |
|----------------|-------------------------------------------------------------|
| **MuseoModerno** | Nombre del titular, títulos de sección                    |
| **Inter**        | Todo el cuerpo de texto (descripciones, listas, tablas)   |
| **Space Mono**   | Datos "técnicos": fechas, códigos de certificación, stack tecnológico, ORCID/DOI |

Compilación **obligatoriamente con XeLaTeX** (nunca pdfLaTeX/LuaLaTeX) — es el único motor
que carga las fuentes TrueType/OTF instaladas en el sistema, tal como ya está resuelto en
el repo de informes con `setup_coriotlab.ps1`.

### 3.3 Isotipo y logo

- Usa el isotipo "<" con píxeles de acento (azul oscuro, magenta, celeste) exactamente como
  en `membretes/`. **Reutiliza los mismos archivos de membrete** del repo de informes
  (`membrete_azul.png` por defecto) copiándolos a este nuevo proyecto — no los regeneres.
- Respeta el margen mínimo del isotipo: **110 px a los lados, 50 px arriba/abajo**.
- Versión horizontal del logo (isotipo + "CORIOT" + slogan "CONTROL · ROBÓTICA · IOT") va
  en el encabezado de la primera página, discreta y de menor jerarquía que el nombre del
  titular (el protagonista visual del CV es la persona, no el laboratorio).
- **Nunca** alterar proporciones, colores, tipografía del logo ni aplicarle sombras/efectos
  (regla explícita del libro de marca, sección "Usos incorrectos").

### 3.4 Elementos gráficos complementarios permitidos

Puedes usar, con moderación, los elementos que el libro de marca define como
complementarios: líneas diagonales como divisores/marcadores de sección, pequeños
cuadrados de acento (conexión visual con los píxeles del logo), y los signos "<" / ">"
como viñetas o marcadores decorativos de listas — dan una estética sutil de
programación/computación coherente con el laboratorio.

### 3.5 Restricciones de fotografía

El libro de marca sugiere fotografía de manos/robots/personas en el laboratorio para
*piezas de comunicación institucional* (banners, redes, sitio web) — **eso NO aplica a
este documento**. La hoja de vida es un documento formal de datos: cero fotografías,
ni del titular ni decorativas.

---

## 4. SISTEMA DE ETIQUETAS (extensión del patrón "Estado" ya usado en Informe de Actividades)

Diseña dos sistemas de etiquetas visuales coherentes con `\Estado...` del repo de informes:

**A. Nivel de formación académica** (comando tipo `\NivelFormacion{...}`):
- Técnico / Tecnólogo
- Pregrado
- Especialización
- Maestría
- Doctorado
- Postdoctorado

Cada uno con estado adicional: *en curso* / *culminado*, usando el mismo código de color
que ya existe para estados (`VerdeTarea` = culminado, `AzulDigital` = en curso).

**B. Certificación** (comando tipo `\Certificado{}` / `\NoCertificado{}`) para marcar
visualmente qué ítems de experiencia o formación cuentan con soporte documental — dado que
el encargo pide explícitamente "experiencia certificada" como criterio de inclusión.

Documenta ambos sistemas en el mismo estilo de tabla que usa el README del repo de
informes para los estados de actividad.

---

## 5. ESPECIFICACIÓN TÉCNICA — PUBLICACIONES EN FORMATO APA

Este es el punto técnico más delicado del encargo. Antes de implementar, evalúa y decide
entre estas dos rutas, dejando la decisión documentada en el README:

- **Opción A (recomendada por simplicidad y consistencia con el repo existente):**
  Comando manual `\Publicacion{...}` con parámetros estructurados (autores, año, título,
  fuente/revista, volumen, DOI/URL) que internamente compone el formato APA 7 de forma
  determinística en LaTeX puro. **Cero dependencias externas nuevas** (no requiere biber,
  no requiere `.bib`, no rompe el flujo actual de "un solo `.tex`, doble pasada XeLaTeX").
  Ideal porque el público (ingenieros, no siempre familiarizados con BibTeX/biblatex) solo
  llena campos con nombres claros.
- **Opción B (más rigurosa académicamente):** `biblatex` + `biber` con estilo `apa`
  (paquete `biblatex-apa`), archivo `.bib` externo. Formatea automáticamente casos límite
  (múltiples autores, "et al.", DOIs, etc.) pero **agrega una dependencia nueva** (biber
  como ejecutable separado) al flujo de compilación, que hoy es solo XeLaTeX de doble
  pasada. Requeriría actualizar `compile.ps1` y `setup_coriotlab.ps1`.

**Implementa la Opción A por defecto** para mantener cero fricción de instalación, pero dej
a el código organizado (comando bien parametrizado, con sangría francesa correcta, orden
alfabético/cronológico configurable) de modo que migrar a Opción B en el futuro sea
sencillo si el laboratorio lo pide. Documenta explícitamente esta decisión y el trade-off
en el README, para que el usuario pueda cambiarlo si lo prefiere.

Igual criterio (mismo comando estructurado, sin bibliografía externa) para la sección de
**Congresos/Ponencias**, con un formato de cita breve consistente (no necesariamente APA
estricta, pero visualmente alineado).

---

## 6. ESTRUCTURA DE ARCHIVOS A CREAR

Crea el proyecto **autocontenido** (no dependas de rutas del otro repositorio, porque este
se publicará como repo independiente). Ten en cuenta que **las carpetas de kit de marca y
de membretes ya existen** dentro de `C:\CORIOTLAB\PLANTILLA HOJA DE VIDA` (ver sección
0.1) — no las recrees ni dupliques su contenido; intégralas a la estructura final tal como
están, renombrando solo si hace falta para mantener consistencia con el resto del proyecto.
Estructura sugerida — ajústala si tienes una razón técnica mejor, pero mantén el mismo
espíritu del repo de informes:

```
C:\CORIOTLAB\PLANTILLA HOJA DE VIDA\
│
├── [carpeta existente] Kit de Marca\    ← YA EXISTE — manual de marca (PDF) + logos en
│                                            todas sus variantes. Revisar y usar desde aquí,
│                                            referenciando rutas relativas desde el .tex.
├── [carpeta existente] Membretes\       ← YA EXISTE — membrete_azul / celeste / gris /
│                                            magenta en PNG. Reutilizar directamente.
│
├── plantilla\
│   ├── plantilla_hoja_de_vida.tex      ← archivo principal, con Zona de Configuración
│   └── plantilla_hoja_de_vida.pdf      ← PDF de referencia ya compilado con datos ficticios
│
├── ejemplos\
│   └── hoja_de_vida_ejemplo_completa.tex   ← ejemplo lleno con datos ficticios realistas
│                                              (perfil investigador técnico en robótica/IoT)
│
├── docs\
│   └── MANUAL_USUARIO.md               ← guía paso a paso, mismo estilo que el repo hermano,
│                                            incluye tabla de "qué logo/membrete usar cuándo"
│
├── compile.ps1                          ← doble pasada XeLaTeX automática
├── setup_coriotlab.ps1                  ← instala Inter, MuseoModerno, Space Mono
├── README.md                            ← mismo formato/tono que el README del repo hermano
├── CHANGELOG.md
└── .gitignore                           ← ignorar .aux, .log, .out, .toc, etc.
```

> Nota: usa los nombres reales de esas dos carpetas tal como las encuentres al listar el
> directorio (no asumas que se llaman exactamente "Kit de Marca" o "Membretes" — verifícalo
> primero, sección 0.1).

---

## 7. ZONA DE CONFIGURACIÓN DEL `.tex` (contrato de campos editables)

Al inicio del archivo, en las primeras ~30 líneas, define comandos `\newcommand` claros y
comentados en español, siguiendo el patrón exacto del repo de informes. Como mínimo:

```latex
% === IDENTIFICACIÓN ===
\newcommand{\CVNombre}{Nombre Apellido}
\newcommand{\CVTitulo}{Ingeniero(a) Electrónico / Investigador(a) en Robótica}
\newcommand{\CVCorreo}{correo@ejemplo.com}
\newcommand{\CVTelefono}{+57 300 000 0000}
\newcommand{\CVCiudad}{Medellín, Colombia}
\newcommand{\CVLinkedIn}{linkedin.com/in/usuario}   % opcional, dejar vacío si no aplica
\newcommand{\CVORCID}{0000-0000-0000-0000}          % opcional
\newcommand{\CVGitHub}{github.com/usuario}          % opcional
\newcommand{\CVFecha}{Julio de 2026}                % fecha de última actualización del CV
```

Y bloques opcionales (`%% === OPT-A === Perfil profesional`, `%% === OPT-B === Idiomas`,
etc.) exactamente en el mismo estilo comentado que usa `plantilla_tecnico.tex`, con
instrucciones inline de cuándo activarlos.

---

## 8. PLAN DE TRABAJO DETALLADO (ejecútalo en este orden, fase por fase)

### Fase 0 — Preparación
1. Verifica la carpeta `C:\CORIOTLAB\PLANTILLA HOJA DE VIDA` y **lista su contenido
   completo primero**, identificando la carpeta del kit de marca (manual + logos) y la
   carpeta de membretes ya existentes (ver sección 0.1). No continúes a la Fase 1 sin
   haber inventariado qué variantes de logo y de membrete hay disponibles.
2. Confirma que XeLaTeX (MiKTeX) está disponible en el sistema; si no, indícalo pero
   continúa generando el código (no bloquees el desarrollo por falta de compilador).
3. Crea el resto de la estructura de carpetas de la sección 6, integrando (no duplicando)
   las dos carpetas ya existentes.

### Fase 1 — Fundamentos de estilo
1. Crea un archivo de preámbulo/estilo (puede ser un `.tex` de estilo separado o
   directamente en el preámbulo del documento principal — decide según mantenibilidad)
   con: definición de colores (`xcolor`), fuentes (`fontspec`), geometría de página,
   encabezados/pies de página con el membrete, numeración, espaciados.
2. Implementa los comandos de sección con la tipografía MuseoModerno y el acento de color
   AzulITM (línea o cuadrado de acento antes del título de cada sección, evocando los
   píxeles del logo).
3. Implementa el sistema de etiquetas de la sección 4 (`\NivelFormacion`, `\Certificado`).
4. Implementa el comando `\Publicacion{...}` en formato APA (Opción A, sección 5).
5. Implementa un comando de encabezado de congreso/ponencia.

### Fase 2 — Estructura del documento
1. Encabezado/portada: nombre (grande, MuseoModerno, AzulITM), título profesional, línea
   de contacto (correo · teléfono · ciudad · LinkedIn/ORCID/GitHub si están definidos),
   logo horizontal CORIOT discreto (esquina, tamaño reducido, respetando márgenes mínimos
   del isotipo).
2. Sección Perfil profesional (opcional).
3. Sección Formación académica (tabla o lista con: título, institución, nivel + estado,
   fechas).
4. Sección Experiencia certificada (entidad, cargo, periodo, funciones/logros, indicador
   de certificación).
5. Sección Certificaciones (entidad emisora, nombre, fecha, código/link si aplica).
6. Sección Publicaciones (lista en APA, usando `\Publicacion{}`).
7. Sección Congresos y Ponencias.
8. Bloques opcionales adicionales comentados (idiomas, stack técnico/herramientas).
9. Pie de página discreto con fecha de actualización del CV y numeración de página si el
   CV excede una página.

### Fase 3 — Contenido de ejemplo
1. Llena `ejemplos/hoja_de_vida_ejemplo_completa.tex` con un perfil ficticio pero
   **realista y coherente**: investigador(a) en robótica/IoT del ITM, con 2–3 estudios
   (pregrado + maestría en curso, por ejemplo), 2 experiencias certificadas, 2–3
   certificaciones, 2–3 publicaciones en APA bien formadas, 2 congresos.
2. Compila con doble pasada XeLaTeX y verifica que el PDF resultante no tenga overflows,
   fuentes faltantes, ni errores de compilación.
3. Ajusta espaciados hasta lograr una vista limpia, sin foto, con jerarquía tipográfica
   clara (nombre > títulos de sección > cuerpo > metadatos).

### Fase 4 — Scripts y automatización
1. `compile.ps1`: doble pasada XeLaTeX sobre la plantilla o sobre el ejemplo, con manejo
   de exit code igual al del repo hermano (advertencia de MiKTeX no debe interpretarse
   como fallo si el PDF se generó).
2. `setup_coriotlab.ps1`: instala las 3 fuentes (puede ser una copia adaptada del script
   del repo hermano — no reinventar si ya funciona, solo referenciar/adaptar rutas).

### Fase 5 — Documentación
1. `README.md` con el mismo tono/estructura del repo hermano: qué es, campos a
   configurar, tabla de niveles de formación, tabla de estado de certificación, requisitos
   del sistema, solución de problemas frecuentes, tabla de paleta y tipografías.
2. `docs/MANUAL_USUARIO.md` con guía paso a paso para alguien sin experiencia en LaTeX:
   cómo copiar la plantilla, cómo llenar cada sección, cómo agregar/quitar publicaciones,
   cómo compilar.
3. `CHANGELOG.md` iniciando en versión `1.0.0`.
4. `.gitignore` para artefactos de compilación LaTeX.

### Fase 6 — Preparación para publicación en GitHub (al final, cuando todo esté validado)
1. Verifica que no haya rutas absolutas de tu computador personal hardcodeadas en el
   `.tex` (usa rutas relativas dentro del repo, como ya hace el repo hermano con
   `../../membretes/...`).
2. Ejecuta `git init`, primer commit limpio con mensaje descriptivo.
3. Deja instrucciones claras en el README de cómo conectar el repo local a un repositorio
   remoto nuevo en GitHub (`git remote add origin ...` / `git push -u origin master`) —
   **no ejecutes el push tú mismo**, eso lo hace el usuario manualmente cuando cree el
   repositorio en GitHub.

---

## 9. CHECKLIST DE CALIDAD (verificar antes de dar por terminado)

- [ ] Cero fotografías en cualquier parte de la plantilla o el ejemplo.
- [ ] Todos los colores usados corresponden exactamente a los tokens de la sección 3.1
      (sin colores inventados).
- [ ] Las tres tipografías se usan según su rol definido (MuseoModerno / Inter / Space Mono).
- [ ] El isotipo/logo respeta márgenes mínimos y no está alterado en proporción/color.
- [ ] Compila sin errores con doble pasada XeLaTeX (`xelatex` → `xelatex`).
- [ ] Las publicaciones se ven como citas APA 7 correctamente formateadas (sangría
      francesa, cursiva en título de revista/libro, año entre paréntesis).
- [ ] Formación académica muestra claramente nivel + estado (en curso/culminado).
- [ ] Experiencia y certificaciones distinguen visualmente lo que está certificado.
- [ ] Todas las secciones no obligatorias están comentadas y son fáciles de activar.
- [ ] El documento se ve profesional impreso en blanco y negro también (por si alguien lo
      imprime) — validar que el contraste de texto no dependa 100% del color.
- [ ] README y manual de usuario completos y en español, mismo tono que el repo hermano.

---

## 10. PREGUNTAS QUE PUEDES HACERME SI ALGO NO QUEDA CLARO

Si durante el desarrollo encuentras ambigüedad, pregúntame puntualmente antes de asumir,
especialmente sobre:
- Longitud objetivo del CV (¿estrictamente 1 página o puede crecer a 2 si hay muchas
  publicaciones?).
- Si quiero variante de membrete distinta a la azul por defecto para este documento.
- Si en el futuro debo migrar publicaciones a la Opción B (biblatex+biber) de la sección 5.

No preguntes por decisiones ya resueltas en este documento (colores, tipografías, ausencia
de foto, formato APA, ubicación de carpetas): esas ya están definidas y no deben
reabrirse sin instrucción explícita.

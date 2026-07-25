# CHANGELOG — Plantilla Hoja de Vida CORIOTLAB

## [1.0.0] — 2026-07-24

### Añadido

- `plantilla/plantilla_hoja_de_vida.tex`: plantilla base con Zona de Configuración,
  encabezado sin fotografía, y secciones de Perfil Profesional (opcional), Formación
  Académica, Experiencia Certificada, Certificaciones, Publicaciones (APA 7),
  Congresos y Ponencias, e Idiomas/Habilidades Técnicas/Software (opcionales,
  comentados).
- Sistema de etiquetas de nivel de formación (`\NivelFormacion`, `\FormacionEnCurso`,
  `\FormacionCulminada`) y de certificación (`\Certificado`, `\NoCertificado`),
  coherente con el sistema `\Estado...` del repositorio de informes.
- Comando `\Publicacion{}` para citas APA 7 en LaTeX puro (Opción A: sin
  biblatex/biber ni archivo `.bib` externo — ver README para el trade-off documentado).
- Comando `\Ponencia{}` para congresos/ponencias con formato de cita breve.
- Campos opcionales de redes académicas en el encabezado: LinkedIn, ORCID, GitHub,
  Google Scholar y ResearchGate, con línea de "Redes" separada de la línea de
  contacto, y omisión automática de campos vacíos (`\ifdefempty`).
- `ejemplos/hoja_de_vida_ejemplo_completa.tex`: ejemplo con datos reales (no
  ficticios) de un investigador del ITM, usado con autorización de su titular,
  demostrando las 8 secciones con contenido real: formación, experiencia certificada,
  15 certificaciones, producción técnica (registros de software DNDA y prototipos),
  5 ponencias, reconocimientos e idiomas.
- `compile.ps1`: compilación con doble pasada XeLaTeX; verifica éxito comparando la
  fecha de modificación del PDF (no el código de salida, que MiKTeX puede reportar
  distinto de 0 aunque el PDF se haya generado correctamente).
- `setup_coriotlab.ps1`: instala Inter, MuseoModerno y Space Mono directamente desde
  el Kit de Marca incluido en el proyecto (sin conexión a internet), con mapeo
  explícito de archivos para evitar conflictos de familia de fuente.
- `docs/MANUAL_USUARIO.md`: guía paso a paso para usuarios sin experiencia en LaTeX.
- Documentación en el README de qué logo/membrete usar según el caso de uso, y de la
  decisión de no usar el membrete de fondo a página completa (a diferencia de los
  informes) por razones de legibilidad en un documento denso en tablas/listas.

### Decisiones de diseño documentadas

- No se usa el membrete de fondo a página completa (40% opacidad) que usan los
  informes: se reemplaza por un logo horizontal nítido en el encabezado y un pie de
  página construido en LaTeX (regla + fecha + número de página).
- Longitud del CV flexible (1–2+ páginas según contenido real), no forzada a una
  sola página.
- Publicaciones en Opción A (comando LaTeX puro) por defecto, con la Opción B
  (biblatex+biber) documentada como alternativa futura si el laboratorio la necesita.

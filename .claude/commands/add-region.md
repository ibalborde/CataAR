---
description: Investiga y genera la ficha JSON de una zona vitivinícola, la valida y la deja lista para revisión
argument-hint: <nombre de la zona>
---

Generá la ficha de la zona **$ARGUMENTS** siguiendo el esquema de "Modelo de contenido" en CLAUDE.md.

1. Ubicala en el árbol geográfico: definí `level` y `parentId`. Si el padre no existe (por ejemplo `ar-salta`),
   creá primero la ficha mínima del padre y avisalo.
2. Verificá que no exista ya en `CataKit/Sources/ContentBundle/Resources/regions/`.
3. Investigá: INV (superficie, cepas principales, registro de IG), Wines of Argentina, Ley 25.163 y
   Res. INV 37/2025 para IG/IP/DOC, y el material del curso si el usuario lo aportó (pedí el PDF si existe).
4. Redactá con palabras propias. Completá:
   - `altitudeMeters`, `climate` (amplitud térmica, precipitaciones, riesgos), `soils`.
   - `keyGrapeIds`: solo cepas que ya existen en `grapes/`; las que falten, listalas al final.
   - `wineStyle`: cómo se expresan los vinos de la zona en copa, en términos útiles para cata a ciegas.
   - `protectedDesignations`: IG o DOC reconocidas, con sus reglas principales.
   - `coordinates` aproximadas del centro de la zona.
5. Si corresponde, agregá `regionalExpressions` en las cepas existentes que apuntan a esta zona.
6. Corré `ContentTests` y corregí hasta que pasen.
7. Presentá al usuario el JSON, las afirmaciones más técnicas para validar y las fuentes.
   **No hagas commit hasta que el usuario apruebe.** Al aprobar: `content: add <id>`.

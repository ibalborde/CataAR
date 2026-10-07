---
description: Investiga y genera la ficha JSON de una cepa, la valida y la deja lista para revisión
argument-hint: <nombre de la cepa>
---

Generá la ficha de la cepa **$ARGUMENTS** siguiendo el esquema de "Modelo de contenido" en CLAUDE.md.

1. Verificá que no exista ya en `CataKit/Sources/ContentBundle/Resources/grapes/` (buscá también por alias).
2. Investigá en fuentes confiables, en este orden: INV (superficie por cepa y provincia, año más reciente),
   Wines of Argentina, Wine Folly y el material del curso si el usuario lo aportó. Abrí las páginas; no te
   quedes con el snippet del buscador.
3. Redactá con palabras propias. Nada literal de fuentes con copyright.
4. Completá con especial cuidado:
   - `structure` (1–5) coherente con las cepas ya cargadas: comparalas antes de asignar números.
   - `blindTastingKeys`: 3 a 5 claves concretas para reconocerla a ciegas.
   - `confusedWith`: las 1 a 3 cepas con las que más se confunde y cómo distinguirlas.
   - `evolution`: joven frente a evolucionado y potencial de guarda en años.
   - `regionalExpressions`: solo para regiones que ya existen en `regions/`. Si falta alguna relevante,
     mencionalo al final en lugar de inventar el id.
5. Si aparecen descriptores nuevos, agregalos a `descriptors.json` con id estable.
6. Corré `ContentTests` y corregí hasta que pasen.
7. Presentá al usuario el JSON, las 5 afirmaciones más técnicas para que las valide y las fuentes.
   **No hagas commit hasta que el usuario apruebe.** Al aprobar: `content: add <id>`.

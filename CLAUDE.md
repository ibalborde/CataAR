# CLAUDE.md — CataAR

App iOS nativa de referencia para cata de vinos argentinos, orientada a estudiantes de sommelier.
MVP (v1.0): fichas de 8 cepas y 6 zonas, búsqueda, enlaces cruzados. Offline, gratis, en español.
El plan completo está en el doc "Plan de desarrollo — App de cata de vinos argentinos".

El dueño del proyecto es desarrollador iOS senior y sommelier en formación: no expliques lo básico de Swift,
sí explicá decisiones de arquitectura cuando no sean obvias.

---

## Stack (no cambiar sin preguntar)

- Xcode 27, SDK iOS 27, **Swift 6.4, modo de lenguaje 6, strict concurrency completa**.
- Deployment target: **iOS 26**.
- SwiftUI + Observation (`@Observable`). Prohibido `ObservableObject`, `@Published`, Combine.
- Navegación: `NavigationStack` + `enum Route: Hashable` por feature.
- Tests: **Swift Testing** (`import Testing`, `@Test`, `#expect`, `#require`). XCTest solo para XCUITest.
- Formato: `swift format` (toolchain). Sin SwiftLint.
- **Cero dependencias de terceros.** Si algo parece necesitar una, proponelo y esperá aprobación.
- Textos de UI: `Localizable.xcstrings`. Nunca strings hardcodeados visibles al usuario.

## Estructura

```
CataAR/
├─ CataAR.xcodeproj           # solo el target de app. NO editar el .pbxproj salvo pedido explícito
├─ App/                       # @main CataARApp, AppContainer (composition root), RootView
├─ CataKit/                   # paquete Swift local: TODO el código vive acá
│  ├─ Package.swift
│  ├─ Sources/
│  │  ├─ Domain/              # entidades, protocolos, casos de uso. Sin imports de UI ni persistencia
│  │  ├─ Data/                # DTOs, mappers, repositorios concretos
│  │  ├─ ContentBundle/       # Content/: manifest.json, grapes/*.json, regions/*.json, descriptors.json
│  │  │                       # (named Content, not Resources: Xcode 27's codesign rejects any .bundle
│  │  │                       #  with a nested folder literally named "Resources" as malformed)
│  │  ├─ DesignSystem/        # tokens + componentes reutilizables
│  │  ├─ GrapesFeature/
│  │  ├─ RegionsFeature/
│  │  ├─ SearchFeature/
│  │  └─ TestSupport/         # fakes, fixtures y builders compartidos por tests y previews
│  └─ Tests/
│     ├─ DomainTests/
│     ├─ DataTests/
│     ├─ ContentTests/        # validación de los JSON reales
│     └─ <Feature>Tests/
└─ CataARUITests/
```

## Regla de dependencias (la hace cumplir Package.swift)

```
App ──► Features ──► Domain ◄── Data ──► ContentBundle
          │
          └──► DesignSystem
```

- `Domain` no depende de nada (solo Foundation).
- Las features dependen de `Domain` y `DesignSystem`. **Nunca de `Data`.**
- `Data` implementa los protocolos de `Domain`.
- Solo `App/AppContainer.swift` conoce las implementaciones concretas y las inyecta.
- Una feature no importa otra feature. La navegación entre features (cepa → zona) se resuelve con
  closures o un `Router` inyectado desde App.

## Principios de código

- SOLID pragmático: protocolo en el borde de cada capa, implementación concreta detrás.
- Inyección por inicializador. Prohibido singletons, `static shared`, service locators.
- Entidades de Domain: `struct`, `Sendable`, `Hashable`, `Identifiable`. Inmutables.
- Repositorios: `protocol ...: Sendable` con métodos `async throws`, aunque hoy lean del bundle.
- ViewModels: `@MainActor @Observable final class`, estado expuesto como `enum ViewState { loading, loaded(T), empty, failed(Error) }`.
- Vistas chicas: si un `body` pasa ~60 líneas, extraer subvistas.
- Errores tipados en Domain (`enum ContentError: Error`). No `fatalError` fuera de previews.
- Nombres en inglés en el código; contenido y UI en español.
- Sin comentarios que repiten el código. Sí doc comments (`///`) en protocolos públicos de Domain.

## Modelo de contenido

IDs = slugs estables en kebab-case. **Nunca renombrar un id publicado.**
- Cepas: `malbec`, `cabernet-sauvignon`, `torrontes-riojano`
- Regiones: prefijo de país + jerarquía: `ar`, `ar-mendoza`, `ar-mendoza-lujan-de-cuyo`, `ar-mendoza-lujan-de-cuyo-agrelo`

Todo texto de contenido es `LocalizedText` (`{"es": "..."}`); `es` es obligatorio y es el fallback.

`manifest.json`:
```json
{ "schemaVersion": 1, "contentVersion": "2026.10.1", "defaultLocale": "es" }
```

`grapes/malbec.json` (forma de referencia; el texto real lo redacta `/add-grape`):
```json
{
  "id": "malbec",
  "names": { "es": "Malbec" },
  "aliases": ["Côt", "Auxerrois"],
  "color": "red",
  "origin": { "regionId": "fr", "note": { "es": "..." } },
  "structure": { "body": 4, "tannin": 3, "acidity": 3, "alcohol": 4, "colorIntensity": 5 },
  "visual": { "es": "..." },
  "aromas": [
    { "descriptorId": "plum", "kind": "primary" },
    { "descriptorId": "violet", "kind": "primary" },
    { "descriptorId": "vanilla", "kind": "secondary" }
  ],
  "palate": { "es": "..." },
  "blindTastingKeys": [{ "es": "..." }],
  "confusedWith": [{ "grapeId": "bonarda", "howToTell": { "es": "..." } }],
  "evolution": {
    "young": { "es": "..." },
    "aged": { "es": "..." },
    "agingPotentialYears": { "min": 3, "max": 15 }
  },
  "regionalExpressions": [{ "regionId": "ar-mendoza-valle-de-uco", "notes": { "es": "..." } }],
  "sources": [{ "title": "INV — Informe anual de superficie 2025", "url": "https://...", "accessed": "2026-10-07" }]
}
```

`regions/ar-mendoza-lujan-de-cuyo.json`:
```json
{
  "id": "ar-mendoza-lujan-de-cuyo",
  "parentId": "ar-mendoza",
  "level": "department",
  "names": { "es": "Luján de Cuyo" },
  "altitudeMeters": { "min": 850, "max": 1100 },
  "climate": { "es": "..." },
  "soils": { "es": "..." },
  "keyGrapeIds": ["malbec", "cabernet-sauvignon"],
  "wineStyle": { "es": "..." },
  "protectedDesignations": [{ "kind": "DOC", "name": { "es": "DOC Luján de Cuyo" }, "rules": { "es": "..." } }],
  "coordinates": { "lat": -33.035, "lon": -68.878 },
  "sources": [ ... ]
}
```

`level` ∈ `country | province | region | department | district | gi`. Escalas de `structure`: enteros 1–5.
`descriptors.json`: lista de `{ "id", "names", "family" }` (familias: fruta roja, fruta negra, fruta blanca, floral,
especiado, vegetal, mineral, crianza, evolución). Los ids de descriptores también son estables.

Cambiar el esquema = subir `schemaVersion`, actualizar DTOs, mappers, fixtures y ContentTests en el mismo commit.

## Reglas de contenido (importante)

- **Redacción propia.** No copiar texto literal de los PDFs del curso (Asociación Rosarina de Sommeliers) ni de
  sitios con copyright (Wine Folly, Wines of Argentina, etc.). Parafrasear y sintetizar. Las leyes y resoluciones
  sí se pueden citar.
- Cada ficha lleva `sources` con URL y fecha de consulta. Sin fuente → no entra.
- Fuentes priorizadas: INV (estadísticas, registro de IG), Wines of Argentina, Wine Folly, material del curso
  (pedirle al usuario el PDF si hace falta), Ley 25.163 y Res. INV 37/2025 para IG/IP/DOC.
- Estadísticas siempre con año ("INV 2025").
- `blindTastingKeys` y `confusedWith` son el valor diferencial de la app: concretos y comparativos
  ("más acidez y menos tanino que el Malbec, color igual de intenso"), no adjetivos sueltos.
- **Todo contenido nuevo lo revisa el usuario antes del commit.** Mostrá el JSON y un resumen de las afirmaciones
  más técnicas para que las valide.

## Tests

- TDD en Domain y Data: test primero, después implementación.
- Cada bug corregido trae el test que lo reproduce.
- `ContentTests` recorre los JSON reales con tests parametrizados y verifica:
  ids únicos y en kebab-case; toda referencia (`grapeId`, `regionId`, `parentId`, `descriptorId`) existe;
  escalas 1–5; `es` presente en todo `LocalizedText`; `sources` no vacío; `min ≤ max` en rangos;
  `schemaVersion` del manifest soportado.
- ViewModels con repositorios fake de `TestSupport`; cubrir loading, loaded, empty y failed.
- Previews con fixtures de `TestSupport`, nunca con el repositorio real.
- Metas: Domain y Data ≥ 90 %, features ≥ 80 %, ContentTests 100 % de archivos.

## Comandos

Simulador: definir una vez `SIM='platform=iOS Simulator,name=iPhone 17'` (ajustar al que liste
`xcrun simctl list devices available`).

```bash
# Tests del paquete (rápido, lo que más vas a correr)
cd CataKit && xcodebuild test -scheme CataKit-Package -destination "$SIM" -quiet

# Un solo target de tests
cd CataKit && xcodebuild test -scheme CataKit-Package -destination "$SIM" -only-testing:ContentTests -quiet

# App completa + UI tests
xcodebuild test -project CataAR.xcodeproj -scheme CataAR -destination "$SIM" -quiet

# Formato
swift format --in-place --recursive App CataKit/Sources CataKit/Tests CataARUITests
swift format lint --recursive App CataKit/Sources CataKit/Tests CataARUITests
```

## Flujo de trabajo

1. Antes de tocar código en una tarea de más de un archivo, proponé un plan corto y esperá OK.
2. Escribí o actualizá tests primero.
3. Implementá lo mínimo para que pasen.
4. Corré tests del paquete + `swift format lint`. No reportes "listo" con tests rojos o warnings de concurrencia.
5. Commits chicos con Conventional Commits: `feat(grapes): ...`, `content: add malbec`, `test(data): ...`,
   `refactor(domain): ...`, `chore: ...`. Un commit por unidad lógica.
6. Al terminar, resumí qué cambió y qué quedó pendiente en 3–5 líneas.

## Definition of Done (por feature o ficha)

- [ ] Tests nuevos y existentes en verde
- [ ] Sin warnings de compilación ni de concurrencia
- [ ] `swift format lint` limpio
- [ ] Strings de UI en el String Catalog
- [ ] Preview funcionando con fixtures
- [ ] Dynamic Type (hasta AX5) y VoiceOver revisados en las pantallas tocadas
- [ ] Modo oscuro revisado
- [ ] Contenido aprobado por el usuario (si aplica)

## Qué NO hacer

- No editar `CataAR.xcodeproj/project.pbxproj` salvo pedido explícito; todo target nuevo va en `Package.swift`.
- No agregar dependencias, analytics, tracking ni llamadas de red en la v1.x.
- No usar `UserDefaults` para datos de dominio.
- No importar `Data` desde una feature ni una feature desde otra.
- No inventar datos vitivinícolas: si no hay fuente, se marca como pendiente y se le pregunta al usuario.
- No usar `@unchecked Sendable` ni `nonisolated(unsafe)` sin justificarlo en el PR.

## Comandos de Claude Code del proyecto

En `.claude/commands/`:
- `/add-grape <nombre>` — investiga y genera la ficha JSON de una cepa, la valida y la presenta para revisión.
- `/add-region <nombre>` — ídem para una zona.
- `/feature <descripción>` — scaffolding de un target de feature con ViewModel, vistas, Route y tests.
- `/release-check` — checklist previo a subir a App Store Connect.

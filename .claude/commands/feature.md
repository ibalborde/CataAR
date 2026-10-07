---
description: Crea el scaffolding de un target de feature (vistas, ViewModel, Route y tests) respetando la arquitectura
argument-hint: <nombre y descripción de la feature>
---

Creá la feature **$ARGUMENTS** respetando CLAUDE.md.

1. Proponé un plan corto: nombre del target (`<Nombre>Feature`), casos de uso de Domain que necesita
   (nuevos o existentes), pantallas y `Route`. Esperá OK antes de escribir código.
2. En `Package.swift`: target `<Nombre>Feature` (depende solo de `Domain` y `DesignSystem`) y
   `<Nombre>FeatureTests` (depende de la feature y de `TestSupport`).
3. Si hace falta un caso de uso nuevo, empezá por Domain con TDD.
4. Estructura del target:
   - `<Nombre>ViewModel.swift`: `@MainActor @Observable final class` con `ViewState`.
   - `<Nombre>View.swift` y subvistas chicas.
   - `<Nombre>Route.swift`: `enum` `Hashable` con los destinos.
   - `<Nombre>Factory.swift`: init público que recibe protocolos de Domain y closures de navegación.
5. Tests del ViewModel con fakes de `TestSupport`: loading, loaded, empty, failed y cada acción de usuario.
6. Previews con fixtures. Strings de UI en el String Catalog.
7. Conectalo en `App/AppContainer.swift` y en la navegación raíz.
8. Corré tests + `swift format lint` y revisá la Definition of Done de CLAUDE.md.

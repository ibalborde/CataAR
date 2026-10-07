---
description: Checklist previo a subir un build a App Store Connect
---

Verificá todo lo siguiente y reportá una tabla con ✅ / ❌ y qué falta. No subas nada por tu cuenta.

**Código**
- [ ] Tests del paquete y de la app en verde (incluido XCUITest).
- [ ] Sin warnings de compilación ni de concurrencia en Release.
- [ ] `swift format lint` limpio.
- [ ] Sin `print`, `TODO` ni `fatalError` fuera de previews.

**Versión**
- [ ] `MARKETING_VERSION` subido según el cambio (1.0.0, 1.0.1, 1.1.0…).
- [ ] `CURRENT_PROJECT_VERSION` incrementado respecto del último build subido.
- [ ] `contentVersion` en `manifest.json` actualizado si cambió el contenido.

**Contenido**
- [ ] `ContentTests` en verde y todas las fichas aprobadas por el usuario.
- [ ] Pantalla Acerca de muestra fuentes, versión de app y de contenido, y aviso de consumo responsable.

**App Store**
- [ ] Ícono 1024×1024 sin transparencia.
- [ ] Política de privacidad publicada y URL cargada.
- [ ] App Privacy: "Data Not Collected" coherente con el código (sin red, sin analytics).
- [ ] Cuestionario de clasificación por edad respondido (referencias al alcohol).
- [ ] Capturas para los tamaños de iPhone requeridos, en español.
- [ ] Descripción, subtítulo, palabras clave y notas de la versión en español.
- [ ] Probado en TestFlight en un dispositivo real.

**Accesibilidad**
- [ ] Dynamic Type hasta AX5 sin texto cortado en fichas y listas.
- [ ] VoiceOver lee escalas 1–5 con valor ("Taninos: 3 de 5").
- [ ] Modo oscuro revisado.

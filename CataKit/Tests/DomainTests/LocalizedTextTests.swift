import Domain
import Testing

@Suite("LocalizedText")
struct LocalizedTextTests {
  @Test("es is readable directly")
  func esIsReadableDirectly() {
    let text = LocalizedText(values: ["es": "Hola"])
    #expect(text.es == "Hola")
  }

  @Test("missing locale falls back to es")
  func missingLocaleFallsBackToEs() {
    let text = LocalizedText(values: ["es": "Hola"])
    #expect(text.text(locale: "en") == "Hola")
  }

  @Test("present locale overrides the fallback")
  func presentLocaleOverridesFallback() {
    let text = LocalizedText(values: ["es": "Hola", "en": "Hello"])
    #expect(text.text(locale: "en") == "Hello")
  }

  @Test("missing es yields empty string instead of crashing")
  func missingEsYieldsEmptyString() {
    let text = LocalizedText(values: [:])
    #expect(text.es == "")
  }
}

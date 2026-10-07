import Foundation
import Testing

@testable import Data

@Suite("ManifestDTO")
struct ManifestDTOTests {
  @Test("decodes and maps to ContentManifest")
  func decodesAndMaps() throws {
    let json = """
      { "schemaVersion": 1, "contentVersion": "2026.10.1", "defaultLocale": "es" }
      """
    let dto = try JSONDecoder().decode(ManifestDTO.self, from: Data(json.utf8))
    let manifest = dto.toDomain()
    #expect(manifest.schemaVersion == 1)
    #expect(manifest.contentVersion == "2026.10.1")
    #expect(manifest.defaultLocale == "es")
  }
}
